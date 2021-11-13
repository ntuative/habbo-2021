package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.UserCountRenderer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomCategoryData;
    import com.sulake.habbo.navigator.domain.RoomSessionTags;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.navigator.*;

    public class PromotedRoomsListCtrl implements IDisposable 
    {

        private static const CATEGORY_SPACING:int = 5;

        private var _navigator:HabboNavigator;
        private var _SafeStr_2912:UserCountRenderer;
        private var _SafeStr_2934:PromotedRoomsGuestRoomListCtrl;

        public function PromotedRoomsListCtrl(_arg_1:HabboNavigator):void
        {
            _navigator = _arg_1;
            _SafeStr_2912 = new UserCountRenderer(_navigator);
            _SafeStr_2934 = new PromotedRoomsGuestRoomListCtrl(_navigator);
        }

        public function dispose():void
        {
            _navigator = null;
            if (_SafeStr_2912)
            {
                _SafeStr_2912.dispose();
                _SafeStr_2912 = null;
            };
            if (_SafeStr_2934)
            {
                _SafeStr_2934.dispose();
                _SafeStr_2934 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_navigator == null);
        }

        private function getCategoryContainer(_arg_1:IWindowContainer, _arg_2:int):IWindowContainer
        {
            return (IWindowContainer(_arg_1.getChildByID(_arg_2)));
        }

        public function refresh(_arg_1:IWindowContainer, _arg_2:Array):void
        {
            var _local_4:int;
            var _local_5:IWindowContainer;
            Util.hideChildren(_arg_1);
            var _local_3:int;
            _local_4 = 0;
            while (_local_4 < _arg_2.length)
            {
                _local_5 = getCategoryContainer(_arg_1, _local_4);
                if (_local_5 == null)
                {
                    _local_5 = createEntry(_local_4);
                    _local_5.id = _local_4;
                    _arg_1.addChild(_local_5);
                };
                refreshEntry(_local_5, _arg_2[_local_4]);
                _local_5.y = _local_3;
                _local_3 = (_local_3 + (_local_5.height + 5));
                _local_5.visible = true;
                _local_4++;
            };
            _arg_1.height = ((Util.getLowestPoint(_arg_1) > 0) ? (Util.getLowestPoint(_arg_1) + 5) : 0);
        }

        public function createEntry(_arg_1:int):IWindowContainer
        {
            var _local_2:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("grs_promoted_room_category"));
            setProcedureAndId(_local_2, _arg_1, "enter_room_button", onEnterRoomButton);
            setProcedureAndId(_local_2, _arg_1, "leader_region", onLeaderRegion);
            setProcedureAndId(_local_2, _arg_1, "toggle_open_region", onToggleOpenRegion);
            _navigator.refreshButton(_local_2, "navi_room_icon", true, null, 0);
            return (_local_2);
        }

        private function getLocationAfter(_arg_1:IWindowContainer, _arg_2:String, _arg_3:int=3):int
        {
            var _local_4:IWindow = _arg_1.findChildByName(_arg_2);
            return ((_local_4.x + _local_4.width) + _arg_3);
        }

        private function setProcedureAndId(_arg_1:IWindowContainer, _arg_2:int, _arg_3:String, _arg_4:Function):void
        {
            _arg_1.findChildByName(_arg_3).procedure = _arg_4;
            _arg_1.findChildByName(_arg_3).id = _arg_2;
        }

        public function refreshEntry(_arg_1:IWindowContainer, _arg_2:PromotedRoomCategoryData):void
        {
            var _local_4:String = _navigator.getText(("promotedroomcategory." + _arg_2.code));
            _arg_1.findChildByName("category_name_txt").caption = _local_4;
            _arg_1.findChildByName("category_header").width = (_arg_1.findChildByName("category_name_txt").width + 13);
            _navigator.registerParameter("navigator.promotedrooms.hidetopten", "category", _local_4);
            _navigator.registerParameter("navigator.promotedrooms.viewtopten", "category", _local_4);
            _arg_1.findChildByName("open_txt").caption = _navigator.getText("navigator.promotedrooms.viewtopten");
            _arg_1.findChildByName("close_txt").caption = _navigator.getText("navigator.promotedrooms.hidetopten");
            _arg_1.findChildByName("room_name_txt").caption = _arg_2.bestRoom.roomName;
            var _local_3:IWindow = _arg_1.findChildByName("leader_name_txt");
            _local_3.caption = ((_arg_2.bestRoom.showOwner) ? _arg_2.bestRoom.ownerName : "");
            _local_3.x = getLocationAfter(_arg_1, "leader_name_caption_txt", 0);
            _arg_1.findChildByName("arrow_down_icon").visible = _arg_2.open;
            _arg_1.findChildByName("arrow_right_icon").visible = (!(_arg_2.open));
            _arg_1.findChildByName("close_txt").visible = _arg_2.open;
            _arg_1.findChildByName("open_txt").visible = (!(_arg_2.open));
            _arg_1.findChildByName("arrow_down_icon").x = getLocationAfter(_arg_1, "close_txt");
            _arg_1.findChildByName("arrow_right_icon").x = getLocationAfter(_arg_1, "open_txt");
            _SafeStr_2912.refreshUserCount(_arg_2.bestRoom.maxUserCount, IWindowContainer(_arg_1.findChildByName("enter_room_button")), _arg_2.bestRoom.userCount, "${navigator.usercounttooltip.users}", 222, 35);
            refreshAvatarImage(_arg_1, _arg_2);
            _arg_1.findChildByName("item_list").visible = _arg_2.open;
            if (_arg_2.open)
            {
                _arg_1.findChildByName("item_list").height = (_arg_2.rooms.length * 17);
                _SafeStr_2934.content = _arg_1;
                _SafeStr_2934.category = _arg_2;
                _SafeStr_2934.refresh();
            };
            _arg_1.height = ((_arg_2.open) ? (Util.getLowestPoint(_arg_1) + 3) : 90);
        }

        private function onEnterRoomButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:PromotedRoomCategoryData;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = findCategory(_arg_2);
                _navigator.data.roomSessionTags = new RoomSessionTags(_local_3.code, "1");
                _navigator.goToPrivateRoom(_local_3.bestRoom.flatId);
                _navigator.closeNavigator();
            };
        }

        private function onLeaderRegion(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:PromotedRoomCategoryData;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = findCategory(_arg_2);
                _navigator.trackGoogle("extendedProfile", "navigator_promotedRoom");
                _navigator.send(new GetExtendedProfileMessageComposer(_local_3.bestRoom.ownerId));
            };
        }

        private function onToggleOpenRegion(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_5:PromotedRoomCategoryData;
            var _local_3:PromotedRoomCategoryData;
            if (_arg_1.type == "WME_CLICK")
            {
                while (_local_4 < _navigator.data.promotedRooms.entries.length)
                {
                    _local_5 = _navigator.data.promotedRooms.entries[_local_4];
                    if (_arg_2.id != _local_4)
                    {
                        _local_5.open = false;
                    };
                    _local_4++;
                };
                _local_3 = findCategory(_arg_2);
                _local_3.toggleOpen();
                _navigator.mainViewCtrl.refresh();
            };
        }

        private function findCategory(_arg_1:IWindow):PromotedRoomCategoryData
        {
            return (_navigator.data.promotedRooms.entries[_arg_1.id]);
        }

        private function refreshAvatarImage(_arg_1:IWindowContainer, _arg_2:PromotedRoomCategoryData):void
        {
            var _local_3:IWidgetWindow = IWidgetWindow(_arg_1.findChildByName("avatar_image_widget"));
            var _local_4:IAvatarImageWidget = IAvatarImageWidget(_local_3.widget);
            _local_4.figure = _arg_2.leaderFigure;
        }


    }
}


package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.IFlatUser;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.utils.ExtendedProfileIcon;
    import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;

    public class UserListCtrl implements IDisposable 
    {

        private static const DISPLAY_LIMIT:int = 200;

        protected var _navigator:IHabboTransitionalNavigator;
        private var _SafeStr_2948:Boolean;
        protected var _SafeStr_2335:int;

        public function UserListCtrl(_arg_1:IHabboTransitionalNavigator, _arg_2:Boolean)
        {
            _navigator = _arg_1;
            _SafeStr_2948 = _arg_2;
        }

        public function dispose():void
        {
            _navigator = null;
        }

        public function get disposed():Boolean
        {
            return (_navigator == null);
        }

        public function refresh(_arg_1:IItemListWindow, _arg_2:Array, _arg_3:String, _arg_4:int):void
        {
            var _local_6:int;
            var _local_5:Boolean;
            var _local_8:Array = [];
            for each (var _local_7:IFlatUser in _arg_2)
            {
                if (((_arg_3 == "") || (_local_7.userName.toLowerCase().indexOf(_arg_3) > -1)))
                {
                    _local_8.push(_local_7);
                };
                if (_local_8.length >= 200) break;
            };
            _arg_1.autoArrangeItems = false;
            _local_6 = 0;
            while (true)
            {
                _local_5 = refreshEntry(_arg_1, _local_6, _local_8[_local_6], _arg_4);
                if (_local_5) break;
                _local_6++;
            };
            _arg_1.autoArrangeItems = true;
            _arg_1.invalidate();
            _SafeStr_2335 = _local_8.length;
        }

        private function getListEntry(_arg_1:int):IWindowContainer
        {
            var _local_2:IWindowContainer = getRowView();
            var _local_3:IRegionWindow = IRegionWindow(_local_2.findChildByName("bg_region"));
            _local_3.addEventListener("WME_CLICK", onBgMouseClick);
            _local_3.addEventListener("WME_OVER", onBgMouseOver);
            _local_3.addEventListener("WME_OUT", onBgMouseOut);
            ExtendedProfileIcon.setup(_local_2, onUserInfoMouseClick);
            _local_2.id = _arg_1;
            return (_local_2);
        }

        protected function getRowView():IWindowContainer
        {
            return (IWindowContainer(_navigator.getXmlWindow(((_SafeStr_2948) ? "ros_friend" : "ros_flat_controller"))));
        }

        protected function getBgColor(_arg_1:int, _arg_2:Boolean):uint
        {
            return ((_arg_2) ? 4290173439 : (((_arg_1 % 2) != 0) ? 0xFFFFFFFF : 4293519841));
        }

        private function refreshEntry(_arg_1:IItemListWindow, _arg_2:int, _arg_3:IFlatUser, _arg_4:int):Boolean
        {
            var _local_5:IWindowContainer = IWindowContainer(_arg_1.getListItemAt(_arg_2));
            if (_local_5 == null)
            {
                if (_arg_3 == null)
                {
                    return (true);
                };
                _local_5 = getListEntry(_arg_2);
                _arg_1.addListItem(_local_5);
            };
            if (_arg_3 != null)
            {
                _local_5.color = this.getBgColor(_arg_2, (_arg_3.userId == _arg_4));
                refreshEntryDetails(_local_5, _arg_3);
                _local_5.visible = true;
                _local_5.height = 20;
            }
            else
            {
                _local_5.height = 0;
                _local_5.visible = false;
            };
            return (false);
        }

        private function refreshEntryDetails(_arg_1:IWindowContainer, _arg_2:IFlatUser):void
        {
            _arg_1.findChildByName("user_name_txt").caption = _arg_2.userName;
            var _local_3:IRegionWindow = IRegionWindow(_arg_1.findChildByName("bg_region"));
            _local_3.id = _arg_2.userId;
            _arg_1.findChildByName("user_info_region").id = _arg_2.userId;
            ExtendedProfileIcon.setUserInfoState(false, _arg_1);
        }

        protected function onBgMouseClick(_arg_1:WindowEvent):void
        {
            var _local_2:Array;
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.target);
            if (_SafeStr_2948)
            {
                _navigator.send(new AssignRightsMessageComposer(_local_3.id));
            }
            else
            {
                _local_2 = [];
                _local_2.push(_local_3.id);
                _navigator.send(new RemoveRightsMessageComposer(_local_2));
            };
        }

        private function onBgMouseOver(_arg_1:WindowEvent):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.target.parent);
            _local_3.color = getBgColor(-1, true);
            var _local_2:IWindow = _local_3.findChildByName("arrow_icon");
            if (_local_2 != null)
            {
                _local_2.visible = true;
            };
        }

        private function onBgMouseOut(_arg_1:WindowEvent):void
        {
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.target.parent);
            _local_3.color = getBgColor(_local_3.id, false);
            var _local_2:IWindow = _local_3.findChildByName("arrow_icon");
            if (_local_2 != null)
            {
                _local_2.visible = false;
            };
        }

        public function get userCount():int
        {
            return (_SafeStr_2335);
        }

        private function onUserInfoMouseClick(_arg_1:WindowEvent):void
        {
            _navigator.trackGoogle("extendedProfile", "navigator_roomSettingsUsersList");
            _navigator.send(new GetExtendedProfileMessageComposer(_arg_1.target.id));
        }


    }
}


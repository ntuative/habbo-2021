package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;

    public class OfficialRoomListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _SafeStr_853:IItemListWindow;
        private var _SafeStr_2932:PromotedRoomsListCtrl;

        public function OfficialRoomListCtrl(_arg_1:HabboNavigator):void
        {
            _navigator = _arg_1;
            _SafeStr_2932 = new PromotedRoomsListCtrl(_navigator);
        }

        public function dispose():void
        {
            if (_SafeStr_2932 != null)
            {
                _SafeStr_2932.dispose();
                _SafeStr_2932 = null;
            };
        }

        public function set content(_arg_1:IWindowContainer):void
        {
            _content = _arg_1;
            _SafeStr_853 = ((_content) ? IItemListWindow(_content.findChildByName("item_list_official")) : null);
        }

        public function get content():IWindowContainer
        {
            return (_content);
        }

        public function refresh():void
        {
            var _local_4:int;
            var _local_5:Boolean;
            var _local_3:IWindowContainer;
            var _local_1:Boolean;
            var _local_2:Array = this.getVisibleEntries();
            _SafeStr_853.autoArrangeItems = false;
            refreshPromotedRooms();
            _local_4 = 0;
            while (true)
            {
                _local_5 = (!((_local_4 % 2) == 0));
                _local_3 = IWindowContainer(_SafeStr_853.getListItemAt((_local_4 + 1)));
                if (_local_4 < _local_2.length)
                {
                    refreshEntry(true, _local_5, _local_3, _local_2[_local_4]);
                }
                else
                {
                    _local_1 = refreshEntry(false, _local_5, _local_3, null);
                    if (_local_1) break;
                };
                _local_4++;
            };
            _SafeStr_853.autoArrangeItems = true;
        }

        private function getVisibleEntries():Array
        {
            var _local_2:Array = _navigator.data.officialRooms.entries;
            var _local_1:Array = [];
            var _local_4:int;
            for each (var _local_3:OfficialRoomEntryData in _local_2)
            {
                if (_local_3.folderId > 0)
                {
                    if (_local_3.folderId == _local_4)
                    {
                        _local_1.push(_local_3);
                    };
                }
                else
                {
                    _local_4 = ((_local_3.open) ? _local_3.index : 0);
                    _local_1.push(_local_3);
                };
            };
            return (_local_1);
        }

        private function refreshEntry(_arg_1:Boolean, _arg_2:Boolean, _arg_3:IWindowContainer, _arg_4:OfficialRoomEntryData):Boolean
        {
            if (_arg_3 == null)
            {
                if (!_arg_1)
                {
                    return (true);
                };
                _arg_3 = _navigator.officialRoomEntryManager.createEntry(_arg_2);
                _SafeStr_853.addListItem(_arg_3);
            };
            _navigator.officialRoomEntryManager.refreshEntry(_arg_3, _arg_1, _arg_4);
            return (false);
        }

        private function refreshPromotedRooms():void
        {
            var _local_1:IWindowContainer = IWindowContainer(_SafeStr_853.getListItemAt(0));
            _SafeStr_2932.refresh(_local_1, _navigator.data.promotedRooms.entries);
        }


    }
}


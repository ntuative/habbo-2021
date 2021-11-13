package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.navigator._SafeStr_32;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.*;

    public class MyRoomsTabPageDecorator implements ITabPageDecorator 
    {

        private const SUB_ITEMS:Array = [[5, "navigator.navisel.myrooms"], [4, "navigator.navisel.wherearemyfriends"], [3, "navigator.navisel.myfriendsrooms"], [18, "navigator.navisel.roomswithrights"], [19, "navigator.navisel.mygroups"], [6, "navigator.navisel.myfavourites"], [7, "navigator.navisel.visitedrooms"], [23, ""]];

        private var _navigator:HabboNavigator;
        private var _SafeStr_2719:IDropMenuWindow;

        public function MyRoomsTabPageDecorator(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
        }

        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
            var _local_2:String = "me_header";
            var _local_3:IWindowContainer = (_arg_1.getChildByName(_local_2) as IWindowContainer);
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                _SafeStr_2719 = IDropMenuWindow(_local_3.findChildByName("meSubNavi"));
                prepareSubNavi();
                _SafeStr_2719.addEventListener("WE_SELECTED", onFilterSelected);
            };
            _local_3.visible = true;
        }

        public function tabSelected():void
        {
            if (((!(_SafeStr_2719 == null)) && (!(_SafeStr_2719.disposed))))
            {
                _SafeStr_2719.removeEventListener("WE_SELECTED", onFilterSelected);
                _SafeStr_2719.selection = 0;
                _SafeStr_2719.addEventListener("WE_SELECTED", onFilterSelected);
            };
        }

        public function refreshFooter(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.getChildByName("me_footer") as IWindowContainer);
            var _local_3:IWindow = _local_2.findChildByName("create_room_but");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onCreateRoomClick);
            };
            _navigator.refreshButton(_local_2, "create_room", true, null, 0);
            _local_2.visible = true;
        }

        public function navigatorOpenedWhileInTab():void
        {
            startSearch();
        }

        private function onCreateRoomClick(_arg_1:WindowEvent):void
        {
            _navigator.send(new _SafeStr_32());
        }

        private function prepareSubNavi():void
        {
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                return;
            };
            var _local_2:Array = [];
            for each (var _local_1:Array in SUB_ITEMS)
            {
                _local_2.push(_navigator.getText(_local_1[1]));
            };
            _SafeStr_2719.populate(_local_2);
            _SafeStr_2719.selection = 0;
        }

        private function onFilterSelected(_arg_1:WindowEvent):void
        {
            startSearch();
            var _local_2:IWindow = _arg_1.target;
            if ((_local_2 is IDropMenuWindow))
            {
                _navigator.trackNavigationDataPoint(IDropMenuWindow(_local_2).enumerateSelection()[IDropMenuWindow(_local_2).selection], "category.view");
            };
        }

        private function startSearch():void
        {
            var _local_1:int = (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)) ? 0 : _SafeStr_2719.selection);
            _navigator.mainViewCtrl.startSearch(3, getSearchTypeForIndex(_local_1));
        }

        private function getSearchTypeForIndex(_arg_1:int):int
        {
            if (_arg_1 <= SUB_ITEMS.length)
            {
                return (SUB_ITEMS[_arg_1][0]);
            };
            return (SUB_ITEMS[0][0]);
        }

        public function get filterCategory():String
        {
            return (((_SafeStr_2719) && (!(_SafeStr_2719.disposed))) ? _SafeStr_2719.enumerateSelection()[_SafeStr_2719.selection] : null);
        }

        public function setSubSelection(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:Array;
            if (((!(_SafeStr_2719)) || (_SafeStr_2719.disposed)))
            {
                return;
            };
            var _local_4:int = _SafeStr_2719.numMenuItems;
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _local_2 = SUB_ITEMS[_local_3];
                if (_local_2[0] == _arg_1)
                {
                    _SafeStr_2719.selection = _local_3;
                    return;
                };
                _local_3++;
            };
            _SafeStr_2719.selection = 0;
        }

        public function processSearchParam(_arg_1:String):String
        {
            return (_arg_1);
        }


    }
}


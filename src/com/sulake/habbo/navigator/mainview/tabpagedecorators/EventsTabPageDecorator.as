package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class EventsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_2719:IDropMenuWindow;

        public function EventsTabPageDecorator(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
        }

        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.getChildByName("room_ad_header") as IWindowContainer);
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                _SafeStr_2719 = (_local_2.getChildByName("roomAdFilter") as IDropMenuWindow);
                prepareFilter();
                _SafeStr_2719.addEventListener("WE_SELECTED", onFilterSelected);
            };
            _local_2.visible = true;
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
            var _local_2:IWindowContainer = (_arg_1.getChildByName("room_ads_footer") as IWindowContainer);
            var _local_3:IWindow = _local_2.findChildByName("get_event_but");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onGetEventClick);
            };
            _local_2.visible = true;
        }

        public function navigatorOpenedWhileInTab():void
        {
            startSearch();
        }

        private function prepareFilter():void
        {
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                return;
            };
            var _local_1:Array = [];
            _local_1.push(_navigator.getText("navigator.roomad.topads"));
            _local_1.push(_navigator.getText("navigator.roomad.newads"));
            _SafeStr_2719.populate(_local_1);
            _SafeStr_2719.selection = 0;
        }

        private function onFilterSelected(_arg_1:WindowEvent):void
        {
            startSearch();
        }

        private function onGetEventClick(_arg_1:WindowEvent):void
        {
            _navigator.openCatalogRoomAdsPage();
        }

        private function startSearch():void
        {
            var _local_1:int = 16;
            if (((!(_SafeStr_2719 == null)) && (!(_SafeStr_2719.disposed))))
            {
                _local_1 = getSearchType(_SafeStr_2719.selection);
            };
            _navigator.mainViewCtrl.startSearch(1, _local_1);
        }

        private function getSearchType(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (16);
                case 1:
                    return (17);
                default:
                    Logger.log(("Invalid index when searching Room ad search type: " + _arg_1));
                    return (0);
            };
        }

        public function get filterCategory():String
        {
            if (((_SafeStr_2719 == null) || (_SafeStr_2719.disposed)))
            {
                return (null);
            };
            return (_SafeStr_2719.enumerateSelection()[_SafeStr_2719.selection]);
        }

        public function setSubSelection(_arg_1:int):void
        {
        }

        public function processSearchParam(_arg_1:String):String
        {
            return (_arg_1);
        }


    }
}


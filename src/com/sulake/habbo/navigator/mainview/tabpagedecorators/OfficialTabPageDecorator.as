package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;

    public class OfficialTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;

        public function OfficialTabPageDecorator(_arg_1:HabboNavigator)
        {
            _navigator = _arg_1;
        }

        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
        }

        public function tabSelected():void
        {
        }

        public function refreshFooter(_arg_1:IWindowContainer):void
        {
            _navigator.officialRoomEntryManager.refreshAdFooter(_arg_1);
        }

        public function navigatorOpenedWhileInTab():void
        {
            _navigator.mainViewCtrl.startSearch(4, 11, "-1", 4);
        }

        public function get filterCategory():String
        {
            return (null);
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
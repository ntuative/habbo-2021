package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPurseUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const CREDIT_BALANCE:String = "RWPUE_CREDIT_BALANCE";
        public static const _SafeStr_4044:String = "RWPUE_PIXEL_BALANCE";
        public static const SHELL_BALANCE:String = "RWPUE_SHELL_BALANCE";

        private var _balance:int;

        public function RoomWidgetPurseUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _balance = _arg_2;
        }

        public function get balance():int
        {
            return (_balance);
        }


    }
}


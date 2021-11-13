package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4034:String = "RWFCE_FLOOD_CONTROL";

        private var _seconds:int = 0;

        public function RoomWidgetFloodControlEvent(_arg_1:int)
        {
            super("RWFCE_FLOOD_CONTROL", false, false);
            _seconds = _arg_1;
        }

        public function get seconds():int
        {
            return (_seconds);
        }


    }
}


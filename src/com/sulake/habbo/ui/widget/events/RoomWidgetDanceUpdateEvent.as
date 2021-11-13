package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDanceUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4031:String = "RWUE_DANCE";

        private var _style:int;

        public function RoomWidgetDanceUpdateEvent(_arg_1:int, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("RWUE_DANCE", _arg_2, _arg_3);
            _style = _arg_1;
        }

        public function get style():int
        {
            return (_style);
        }


    }
}


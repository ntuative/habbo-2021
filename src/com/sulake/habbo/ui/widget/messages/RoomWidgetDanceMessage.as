package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDanceMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4186:String = "RWCM_MESSAGE_DANCE";
        public static const _SafeStr_4187:int = 0;
        public static const _SafeStr_632:Array = [2, 3, 4];

        private var _style:int = 0;

        public function RoomWidgetDanceMessage(_arg_1:int)
        {
            super("RWCM_MESSAGE_DANCE");
            _style = _arg_1;
        }

        public function get style():int
        {
            return (_style);
        }


    }
}


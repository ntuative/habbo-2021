package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_TEST:String = "RWM_MESSAGE_TEST";

        private var _type:String = "";

        public function RoomWidgetMessage(_arg_1:String)
        {
            _type = _arg_1;
        }

        public function get type():String
        {
            return (_type);
        }


    }
}
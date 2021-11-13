package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChangeMottoMessage extends RoomWidgetMessage 
    {

        public static const CHANGE_MOTTO:String = "RWVM_CHANGE_MOTTO_MESSAGE";

        private var _motto:String;

        public function RoomWidgetChangeMottoMessage(_arg_1:String)
        {
            super("RWVM_CHANGE_MOTTO_MESSAGE");
            _motto = _arg_1;
        }

        public function get motto():String
        {
            return (_motto);
        }


    }
}
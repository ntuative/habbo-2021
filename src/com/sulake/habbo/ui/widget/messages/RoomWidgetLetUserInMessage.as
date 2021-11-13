package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetLetUserInMessage extends RoomWidgetMessage 
    {

        public static const LET_USER_IN:String = "RWLUIM_LET_USER_IN";

        private var _userName:String;
        private var _canEnter:Boolean;

        public function RoomWidgetLetUserInMessage(_arg_1:String, _arg_2:Boolean)
        {
            super("RWLUIM_LET_USER_IN");
            _userName = _arg_1;
            _canEnter = _arg_2;
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get canEnter():Boolean
        {
            return (_canEnter);
        }


    }
}
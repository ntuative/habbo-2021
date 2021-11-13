package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenProfileMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4199:String = "RWOPEM_OPEN_USER_PROFILE";

        private var _userId:int;
        private var _trackingLocation:String;

        public function RoomWidgetOpenProfileMessage(_arg_1:String, _arg_2:int, _arg_3:String)
        {
            super(_arg_1);
            _userId = _arg_2;
            _trackingLocation = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get trackingLocation():String
        {
            return (_trackingLocation);
        }


    }
}


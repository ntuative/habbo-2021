package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFriendRequestMessage extends RoomWidgetMessage 
    {

        public static const ACCEPT:String = "RWFRM_ACCEPT";
        public static const DECLINE:String = "RWFRM_DECLINE";

        private var _requestId:int = 0;

        public function RoomWidgetFriendRequestMessage(_arg_1:String, _arg_2:int=0)
        {
            super(_arg_1);
            _requestId = _arg_2;
        }

        public function get requestId():int
        {
            return (_requestId);
        }


    }
}
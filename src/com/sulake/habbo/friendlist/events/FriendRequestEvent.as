package com.sulake.habbo.friendlist.events
{
    import flash.events.Event;

    public class FriendRequestEvent extends Event 
    {

        public static const ACCEPTED:String = "FRE_ACCEPTED";
        public static const DECLINED:String = "FRE_DECLINED";

        private var _requestId:int;

        public function FriendRequestEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _requestId = _arg_2;
        }

        public function get requestId():int
        {
            return (_requestId);
        }


    }
}
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionFriendRequestEvent extends RoomSessionEvent 
    {

        public static const FRIEND_REQUEST:String = "RSFRE_FRIEND_REQUEST";

        private var _requestId:int = 0;
        private var _userId:int = 0;
        private var _userName:String;

        public function RoomSessionFriendRequestEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super("RSFRE_FRIEND_REQUEST", _arg_1, _arg_5, _arg_6);
            _requestId = _arg_2;
            _userId = _arg_3;
            _userName = _arg_4;
        }

        public function get requestId():int
        {
            return (_requestId);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }


    }
}
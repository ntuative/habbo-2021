package com.sulake.habbo.session.events
{
    import flash.events.Event;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionEvent extends Event 
    {

        public static const _SafeStr_3683:String = "RSE_CREATED";
        public static const _SafeStr_3684:String = "RSE_STARTED";
        public static const _SafeStr_3685:String = "RSE_ENDED";
        public static const SESSION_ROOM_DATA:String = "RSE_ROOM_DATA";

        private var _session:IRoomSession;
        private var _openLandingPage:Boolean;

        public function RoomSessionEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=true, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            _session = _arg_2;
            _openLandingPage = _arg_3;
        }

        public function get session():IRoomSession
        {
            return (_session);
        }

        public function get openLandingPage():Boolean
        {
            return (_openLandingPage);
        }


    }
}


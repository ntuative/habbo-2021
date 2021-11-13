package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserBadgesEvent extends RoomSessionEvent 
    {

        public static const USER_BADGES:String = "RSUBE_BADGES";

        private var _userId:int = 0;
        private var _badges:Array = [];

        public function RoomSessionUserBadgesEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:Array, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RSUBE_BADGES", _arg_1, _arg_4, _arg_5);
            _userId = _arg_2;
            _badges = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get badges():Array
        {
            return (_badges);
        }


    }
}
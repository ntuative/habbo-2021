package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDanceEvent extends RoomSessionEvent 
    {

        public static const _SafeStr_1305:String = "RSDE_DANCE";

        private var _userId:int;
        private var _danceStyle:int;

        public function RoomSessionDanceEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RSDE_DANCE", _arg_1, _arg_4, _arg_5);
            _userId = _arg_2;
            _danceStyle = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get danceStyle():int
        {
            return (_danceStyle);
        }


    }
}


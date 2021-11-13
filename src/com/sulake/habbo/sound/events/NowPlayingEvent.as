package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class NowPlayingEvent extends Event 
    {

        public static const USER_PLAY_SONG:String = "NPE_USER_PLAY_SONG";
        public static const USER_STOP_SONG:String = "NPW_USER_STOP_SONG";
        public static const _SafeStr_3719:String = "NPE_SONG_CHANGED";

        private var _id:int;
        private var _position:int;
        private var _priority:int;

        public function NowPlayingEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            _id = _arg_3;
            _position = _arg_4;
            _priority = _arg_2;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get position():int
        {
            return (_position);
        }

        public function get priority():int
        {
            return (_priority);
        }


    }
}


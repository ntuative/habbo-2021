package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class SongInfoReceivedEvent extends Event 
    {

        public static const TRAX_SONG_INFO_RECEIVED:String = "SIR_TRAX_SONG_INFO_RECEIVED";

        private var _id:int;

        public function SongInfoReceivedEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _id = _arg_2;
        }

        public function get id():int
        {
            return (_id);
        }


    }
}
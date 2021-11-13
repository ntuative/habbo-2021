package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class PlayListStatusEvent extends Event 
    {

        public static const PLAY_LIST_UPDATED:String = "PLUE_PLAY_LIST_UPDATED";
        public static const PLAY_LIST_FULL:String = "PLUE_PLAY_LIST_FULL";

        public function PlayListStatusEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}
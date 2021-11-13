package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSongUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const SONG_PLAYING_CHANGED:String = "RWSUE_PLAYING_CHANGED";
        public static const SONG_DATA_RECEIVED:String = "RWSUE_DATA_RECEIVED";

        private var _songId:int;
        private var _songName:String;
        private var _songAuthor:String;

        public function RoomWidgetSongUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            _songId = _arg_2;
            _songName = _arg_3;
            _songAuthor = _arg_4;
        }

        public function get songId():int
        {
            return (_songId);
        }

        public function get songName():String
        {
            return (_songName);
        }

        public function get songAuthor():String
        {
            return (_songAuthor);
        }


    }
}
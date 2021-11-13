package com.sulake.habbo.communication.messages.parser.room.furniture
{
        public class YoutubeDisplayPlaylist 
    {

        private var _playlistId:String;
        private var _title:String;
        private var _description:String;

        public function YoutubeDisplayPlaylist(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            _playlistId = _arg_1;
            _title = _arg_2;
            _description = _arg_3;
        }

        public function get playlistId():String
        {
            return (_playlistId);
        }

        public function get title():String
        {
            return (_title);
        }

        public function get description():String
        {
            return (_description);
        }


    }
}
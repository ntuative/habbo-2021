package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YoutubeDisplayPlaylistsMessageParser implements IMessageParser 
    {

        private var _furniId:int;
        private var _playlists:Vector.<YoutubeDisplayPlaylist>;
        private var _selectedPlaylistId:String;


        public function flush():Boolean
        {
            _playlists = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_2:String;
            var _local_6:String;
            var _local_5:String;
            _furniId = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _playlists = new Vector.<YoutubeDisplayPlaylist>(0);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = _arg_1.readString();
                _local_6 = _arg_1.readString();
                _local_5 = _arg_1.readString();
                _playlists.push(new YoutubeDisplayPlaylist(_local_2, _local_6, _local_5));
                _local_4++;
            };
            _selectedPlaylistId = _arg_1.readString();
            return (true);
        }

        public function get furniId():int
        {
            return (_furniId);
        }

        public function get playlists():Vector.<YoutubeDisplayPlaylist>
        {
            return (_playlists);
        }

        public function get selectedPlaylistId():String
        {
            return (_selectedPlaylistId);
        }


    }
}
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylistsMessageParser;

        public class YoutubeDisplayPlaylistsMessageEvent extends MessageEvent 
    {

        public function YoutubeDisplayPlaylistsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YoutubeDisplayPlaylistsMessageParser);
        }

        public function getParser():YoutubeDisplayPlaylistsMessageParser
        {
            return (parser as YoutubeDisplayPlaylistsMessageParser);
        }


    }
}
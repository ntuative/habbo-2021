package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayVideoMessageParser;

        public class YoutubeDisplayVideoMessageEvent extends MessageEvent 
    {

        public function YoutubeDisplayVideoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YoutubeDisplayVideoMessageParser);
        }

        public function getParser():YoutubeDisplayVideoMessageParser
        {
            return (parser as YoutubeDisplayVideoMessageParser);
        }


    }
}
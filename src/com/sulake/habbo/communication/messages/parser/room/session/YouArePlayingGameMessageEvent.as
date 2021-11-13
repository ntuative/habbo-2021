package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class YouArePlayingGameMessageEvent extends MessageEvent 
    {

        public function YouArePlayingGameMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouArePlayingGameMessageParser);
        }

        public function getParser():YouArePlayingGameMessageParser
        {
            return (_SafeStr_816 as YouArePlayingGameMessageParser);
        }


    }
}


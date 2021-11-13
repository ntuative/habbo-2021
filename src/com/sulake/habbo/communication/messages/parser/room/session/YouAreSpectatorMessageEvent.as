package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class YouAreSpectatorMessageEvent extends MessageEvent 
    {

        public function YouAreSpectatorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreSpectatorMessageParser);
        }

        public function getParser():YouAreSpectatorMessageParser
        {
            return (_SafeStr_816 as YouAreSpectatorMessageParser);
        }


    }
}


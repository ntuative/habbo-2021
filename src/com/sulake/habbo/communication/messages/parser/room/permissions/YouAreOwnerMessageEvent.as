package com.sulake.habbo.communication.messages.parser.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class YouAreOwnerMessageEvent extends MessageEvent 
    {

        public function YouAreOwnerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreOwnerMessageParser);
        }

        public function getParser():YouAreOwnerMessageParser
        {
            return (_SafeStr_816 as YouAreOwnerMessageParser);
        }


    }
}


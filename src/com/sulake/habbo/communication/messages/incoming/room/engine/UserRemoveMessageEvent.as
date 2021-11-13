package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;

        public class UserRemoveMessageEvent extends MessageEvent 
    {

        public function UserRemoveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserRemoveMessageParser);
        }

        public function getParser():UserRemoveMessageParser
        {
            return (_SafeStr_816 as UserRemoveMessageParser);
        }


    }
}


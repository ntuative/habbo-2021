package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class UserTypingMessageEvent extends MessageEvent 
    {

        public function UserTypingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserTypingMessageParser);
        }

        public function getParser():UserTypingMessageParser
        {
            return (_SafeStr_816 as UserTypingMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class ChatMessageEvent extends MessageEvent 
    {

        public function ChatMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ChatMessageParser);
        }

        public function getParser():ChatMessageParser
        {
            return (_SafeStr_816 as ChatMessageParser);
        }


    }
}


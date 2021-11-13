package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionOfferedToGuideMessageParser;

        public class ChatReviewSessionOfferedToGuideMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ChatReviewSessionOfferedToGuideMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ChatReviewSessionOfferedToGuideMessageParser);
        }

        public function getParser():ChatReviewSessionOfferedToGuideMessageParser
        {
            return (_SafeStr_816 as ChatReviewSessionOfferedToGuideMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionVotingStatusMessageParser;

        public class ChatReviewSessionVotingStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ChatReviewSessionVotingStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ChatReviewSessionVotingStatusMessageParser);
        }

        public function getParser():ChatReviewSessionVotingStatusMessageParser
        {
            return (_SafeStr_816 as ChatReviewSessionVotingStatusMessageParser);
        }


    }
}


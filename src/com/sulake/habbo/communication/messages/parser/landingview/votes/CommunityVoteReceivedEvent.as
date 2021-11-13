package com.sulake.habbo.communication.messages.parser.landingview.votes
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CommunityVoteReceivedEvent extends MessageEvent 
    {

        public function CommunityVoteReceivedEvent(_arg_1:Function)
        {
            super(_arg_1, CommunityVoteReceivedParser);
        }

        public function getParser():CommunityVoteReceivedParser
        {
            return (_SafeStr_816 as CommunityVoteReceivedParser);
        }


    }
}


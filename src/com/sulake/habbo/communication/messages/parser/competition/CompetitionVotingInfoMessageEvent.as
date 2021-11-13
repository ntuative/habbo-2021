package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CompetitionVotingInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CompetitionVotingInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CompetitionVotingInfoMessageParser);
        }

        public function getParser():CompetitionVotingInfoMessageParser
        {
            return (_SafeStr_816 as CompetitionVotingInfoMessageParser);
        }


    }
}


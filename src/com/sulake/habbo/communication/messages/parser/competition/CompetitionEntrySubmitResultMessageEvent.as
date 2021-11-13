package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CompetitionEntrySubmitResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CompetitionEntrySubmitResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CompetitionEntrySubmitResultMessageParser);
        }

        public function getParser():CompetitionEntrySubmitResultMessageParser
        {
            return (_SafeStr_816 as CompetitionEntrySubmitResultMessageParser);
        }


    }
}


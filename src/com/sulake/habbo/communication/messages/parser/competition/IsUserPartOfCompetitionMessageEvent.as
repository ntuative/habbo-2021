package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class IsUserPartOfCompetitionMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IsUserPartOfCompetitionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IsUserPartOfCompetitionMessageParser);
        }

        public function getParser():IsUserPartOfCompetitionMessageParser
        {
            return (_SafeStr_816 as IsUserPartOfCompetitionMessageParser);
        }


    }
}


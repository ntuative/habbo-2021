package com.sulake.habbo.communication.messages.parser.vault
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class IncomeRewardClaimResponseMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IncomeRewardClaimResponseMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IncomeRewardClaimResponseMessageEventParser);
        }

        public function getParser():IncomeRewardClaimResponseMessageEventParser
        {
            return (_SafeStr_816 as IncomeRewardClaimResponseMessageEventParser);
        }


    }
}


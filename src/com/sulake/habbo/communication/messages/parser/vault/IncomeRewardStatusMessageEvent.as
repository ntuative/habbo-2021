package com.sulake.habbo.communication.messages.parser.vault
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class IncomeRewardStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IncomeRewardStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IncomeRewardStatusMessageEventParser);
        }

        public function getParser():IncomeRewardStatusMessageEventParser
        {
            return (_SafeStr_816 as IncomeRewardStatusMessageEventParser);
        }


    }
}


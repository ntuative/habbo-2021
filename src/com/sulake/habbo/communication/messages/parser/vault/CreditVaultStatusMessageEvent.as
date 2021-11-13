package com.sulake.habbo.communication.messages.parser.vault
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CreditVaultStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CreditVaultStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CreditVaultStatusMessageEventParser);
        }

        public function getParser():CreditVaultStatusMessageEventParser
        {
            return (_SafeStr_816 as CreditVaultStatusMessageEventParser);
        }


    }
}


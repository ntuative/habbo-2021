package com.sulake.habbo.communication.messages.parser.inventory.purse
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CreditBalanceEvent extends MessageEvent implements IMessageEvent 
    {

        public function CreditBalanceEvent(_arg_1:Function)
        {
            super(_arg_1, CreditBalanceParser);
        }

        public function getParser():CreditBalanceParser
        {
            return (this._SafeStr_816 as CreditBalanceParser);
        }


    }
}


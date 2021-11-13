package com.sulake.habbo.communication.messages.parser.inventory.purse
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CreditBalanceParser implements IMessageParser
    {

        private var _balance:int;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _balance = int(_arg_1.readString());
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get balance():int
        {
            return (_balance);
        }


    }
}

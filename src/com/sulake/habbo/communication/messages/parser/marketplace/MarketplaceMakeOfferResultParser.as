package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketplaceMakeOfferResultParser implements IMessageParser 
    {

        private var _result:int;


        public function get result():int
        {
            return (_result);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _result = _arg_1.readInteger();
            return (true);
        }


    }
}
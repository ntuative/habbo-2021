package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketplaceBuyOfferResultParser implements IMessageParser 
    {

        private var _result:int;
        private var _offerId:int = -1;
        private var _newPrice:int = -1;
        private var _requestedOfferId:int = -1;


        public function get result():int
        {
            return (_result);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get newPrice():int
        {
            return (_newPrice);
        }

        public function get requestedOfferId():int
        {
            return (_requestedOfferId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _result = _arg_1.readInteger();
            _offerId = _arg_1.readInteger();
            _newPrice = _arg_1.readInteger();
            _requestedOfferId = _arg_1.readInteger();
            return (true);
        }


    }
}
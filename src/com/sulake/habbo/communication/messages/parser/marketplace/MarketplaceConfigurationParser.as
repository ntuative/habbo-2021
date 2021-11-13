package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketplaceConfigurationParser implements IMessageParser 
    {

        private var _isEnabled:Boolean;
        private var _commission:int;
        private var _tokenBatchPrice:int;
        private var _tokensBatchSize:int;
        private var _offerMaxPrice:int;
        private var _offerMinPrice:int;
        private var _expirationHours:int;
        private var _averagePricePeriod:int;
        private var _sellingFeePercentage:int;
        private var _revenueLimit:int;
        private var _halfTaxLimit:int;


        public function get isEnabled():Boolean
        {
            return (_isEnabled);
        }

        public function get commission():int
        {
            return (_commission);
        }

        public function get tokenBatchPrice():int
        {
            return (_tokenBatchPrice);
        }

        public function get tokenBatchSize():int
        {
            return (_tokensBatchSize);
        }

        public function get offerMinPrice():int
        {
            return (_offerMinPrice);
        }

        public function get offerMaxPrice():int
        {
            return (_offerMaxPrice);
        }

        public function get expirationHours():int
        {
            return (_expirationHours);
        }

        public function get averagePricePeriod():int
        {
            return (_averagePricePeriod);
        }

        public function get tokensBatchSize():int
        {
            return (_tokensBatchSize);
        }

        public function get sellingFeePercentage():int
        {
            return (_sellingFeePercentage);
        }

        public function get revenueLimit():int
        {
            return (_revenueLimit);
        }

        public function get halfTaxLimit():int
        {
            return (_halfTaxLimit);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isEnabled = _arg_1.readBoolean();
            _commission = _arg_1.readInteger();
            _tokenBatchPrice = _arg_1.readInteger();
            _tokensBatchSize = _arg_1.readInteger();
            _offerMinPrice = _arg_1.readInteger();
            _offerMaxPrice = _arg_1.readInteger();
            _expirationHours = _arg_1.readInteger();
            _averagePricePeriod = _arg_1.readInteger();
            _sellingFeePercentage = _arg_1.readInteger();
            _revenueLimit = _arg_1.readInteger();
            _halfTaxLimit = _arg_1.readInteger();
            return (true);
        }


    }
}
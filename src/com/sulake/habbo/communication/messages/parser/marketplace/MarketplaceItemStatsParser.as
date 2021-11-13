package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketplaceItemStatsParser implements IMessageParser 
    {

        private var _averagePrice:int;
        private var _offerCount:int;
        private var _historyLength:int;
        private var _dayOffsets:Array;
        private var _averagePrices:Array;
        private var _soldAmounts:Array;
        private var _furniTypeId:int;
        private var _furniCategoryId:int;


        public function get averagePrice():int
        {
            return (_averagePrice);
        }

        public function get offerCount():int
        {
            return (_offerCount);
        }

        public function get historyLength():int
        {
            return (_historyLength);
        }

        public function get dayOffsets():Array
        {
            return (_dayOffsets);
        }

        public function get averagePrices():Array
        {
            return (_averagePrices);
        }

        public function get soldAmounts():Array
        {
            return (_soldAmounts);
        }

        public function get furniTypeId():int
        {
            return (_furniTypeId);
        }

        public function get furniCategoryId():int
        {
            return (_furniCategoryId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _averagePrice = _arg_1.readInteger();
            _offerCount = _arg_1.readInteger();
            _historyLength = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _dayOffsets = [];
            _averagePrices = [];
            _soldAmounts = [];
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _dayOffsets.push(_arg_1.readInteger());
                _averagePrices.push(_arg_1.readInteger());
                _soldAmounts.push(_arg_1.readInteger());
                _local_3++;
            };
            _furniCategoryId = _arg_1.readInteger();
            _furniTypeId = _arg_1.readInteger();
            return (true);
        }


    }
}
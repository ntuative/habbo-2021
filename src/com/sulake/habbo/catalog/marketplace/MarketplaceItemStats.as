package com.sulake.habbo.catalog.marketplace
{
    public class MarketplaceItemStats 
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

        public function set averagePrice(_arg_1:int):void
        {
            _averagePrice = _arg_1;
        }

        public function set offerCount(_arg_1:int):void
        {
            _offerCount = _arg_1;
        }

        public function set historyLength(_arg_1:int):void
        {
            _historyLength = _arg_1;
        }

        public function set dayOffsets(_arg_1:Array):void
        {
            _dayOffsets = _arg_1.slice();
        }

        public function set averagePrices(_arg_1:Array):void
        {
            _averagePrices = _arg_1.slice();
        }

        public function set soldAmounts(_arg_1:Array):void
        {
            _soldAmounts = _arg_1.slice();
        }

        public function set furniTypeId(_arg_1:int):void
        {
            _furniTypeId = _arg_1;
        }

        public function set furniCategoryId(_arg_1:int):void
        {
            _furniCategoryId = _arg_1;
        }


    }
}
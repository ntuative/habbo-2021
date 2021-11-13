package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BundleDiscountRuleset 
    {

        private var _maxPurchaseSize:int;
        private var _bundleSize:int;
        private var _bundleDiscountSize:int;
        private var _bonusThreshold:int;
        private var _additionalBonusDiscountThresholdQuantities:Array;

        public function BundleDiscountRuleset(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _maxPurchaseSize = _arg_1.readInteger();
            _bundleSize = _arg_1.readInteger();
            _bundleDiscountSize = _arg_1.readInteger();
            _bonusThreshold = _arg_1.readInteger();
            _additionalBonusDiscountThresholdQuantities = [];
            var _local_2:int = _arg_1.readInteger();
            while (_local_3 < _local_2)
            {
                _additionalBonusDiscountThresholdQuantities.push(_arg_1.readInteger());
                _local_3++;
            };
        }

        public function get maxPurchaseSize():int
        {
            return (_maxPurchaseSize);
        }

        public function get bundleSize():int
        {
            return (_bundleSize);
        }

        public function get bundleDiscountSize():int
        {
            return (_bundleDiscountSize);
        }

        public function get bonusThreshold():int
        {
            return (_bonusThreshold);
        }

        public function get additionalBonusDiscountThresholdQuantities():Array
        {
            return (_additionalBonusDiscountThresholdQuantities);
        }


    }
}
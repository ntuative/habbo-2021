package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;

    public class GiftWrappingConfiguration 
    {

        private var _isEnabled:Boolean = false;
        private var _price:int;
        private var _stuffTypes:Array;
        private var _boxTypes:Array;
        private var _ribbonTypes:Array;
        private var _defaultStuffTypes:Array;

        public function GiftWrappingConfiguration(_arg_1:GiftWrappingConfigurationEvent)
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:GiftWrappingConfigurationParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            _isEnabled = _local_2.isWrappingEnabled;
            _price = _local_2.wrappingPrice;
            _stuffTypes = _local_2.stuffTypes;
            _boxTypes = _local_2.boxTypes;
            _ribbonTypes = _local_2.ribbonTypes;
            _defaultStuffTypes = _local_2.defaultStuffTypes;
        }

        public function get isEnabled():Boolean
        {
            return (_isEnabled);
        }

        public function get price():int
        {
            return (_price);
        }

        public function get stuffTypes():Array
        {
            return (_stuffTypes);
        }

        public function get boxTypes():Array
        {
            return (_boxTypes);
        }

        public function get ribbonTypes():Array
        {
            return (_ribbonTypes);
        }

        public function get defaultStuffTypes():Array
        {
            return (_defaultStuffTypes);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GiftWrappingConfigurationParser implements IMessageParser 
    {

        private var _isWrappingEnabled:Boolean;
        private var _wrappingPrice:int;
        private var _stuffTypes:Array;
        private var _boxTypes:Array;
        private var _ribbonTypes:Array;
        private var _defaultStuffTypes:Array;


        public function get isWrappingEnabled():Boolean
        {
            return (_isWrappingEnabled);
        }

        public function get wrappingPrice():int
        {
            return (_wrappingPrice);
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

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _stuffTypes = [];
            _boxTypes = [];
            _ribbonTypes = [];
            _defaultStuffTypes = [];
            _isWrappingEnabled = _arg_1.readBoolean();
            _wrappingPrice = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _stuffTypes.push(_arg_1.readInteger());
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _boxTypes.push(_arg_1.readInteger());
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _ribbonTypes.push(_arg_1.readInteger());
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _defaultStuffTypes.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }


    }
}
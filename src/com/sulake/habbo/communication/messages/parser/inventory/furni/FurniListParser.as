package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FurniListParser implements IMessageParser 
    {

        protected var _SafeStr_1976:int;
        protected var _SafeStr_1977:int;
        private var _furniFragment:Map;


        public function get totalFragments():int
        {
            return (_SafeStr_1976);
        }

        public function get fragmentNo():int
        {
            return (_SafeStr_1977);
        }

        public function get furniFragment():Map
        {
            return (_furniFragment);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:FurniData;
            _SafeStr_1976 = _arg_1.readInteger();
            _SafeStr_1977 = _arg_1.readInteger();
            _furniFragment = new Map();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = new FurniData(_arg_1);
                _furniFragment.add(_local_4.itemId, _local_4);
                _local_3++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            if (_furniFragment)
            {
                _furniFragment.dispose();
                _furniFragment = null;
            };
            return (true);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetInventoryMessageParser implements IMessageParser 
    {

        protected var _SafeStr_1976:int;
        protected var _SafeStr_1977:int;
        private var _petListFragment:Map;


        public function flush():Boolean
        {
            if (_petListFragment)
            {
                _petListFragment.dispose();
                _petListFragment = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:PetData;
            _SafeStr_1976 = _arg_1.readInteger();
            _SafeStr_1977 = _arg_1.readInteger();
            _petListFragment = new Map();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = new PetData(_arg_1);
                _petListFragment.add(_local_4.id, _local_4);
                _local_3++;
            };
            return (true);
        }

        public function get petListFragment():Map
        {
            return (_petListFragment);
        }

        public function get totalFragments():int
        {
            return (_SafeStr_1976);
        }

        public function get fragmentNo():int
        {
            return (_SafeStr_1977);
        }


    }
}


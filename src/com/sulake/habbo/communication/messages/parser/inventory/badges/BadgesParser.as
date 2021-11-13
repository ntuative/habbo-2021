package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BadgesParser implements IMessageParser 
    {

        protected var _SafeStr_1976:int;
        protected var _SafeStr_1977:int;
        private var _currentFragment:Map;


        public function get totalFragments():int
        {
            return (_SafeStr_1976);
        }

        public function get fragmentNo():int
        {
            return (_SafeStr_1977);
        }

        public function get currentFragment():Map
        {
            return (_currentFragment);
        }

        public function flush():Boolean
        {
            if (_currentFragment)
            {
                _currentFragment.dispose();
                _currentFragment = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:int;
            _SafeStr_1976 = _arg_1.readInteger();
            _SafeStr_1977 = _arg_1.readInteger();
            _currentFragment = new Map();
            var _local_5:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_5)
            {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                _currentFragment.add(_local_3, _local_2);
                _local_4++;
            };
            return (true);
        }


    }
}


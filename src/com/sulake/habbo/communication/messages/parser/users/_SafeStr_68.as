package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class _SafeStr_68 implements IMessageParser 
    {

        protected var _SafeStr_2111:Map;


        public function flush():Boolean
        {
            if (_SafeStr_2111)
            {
                _SafeStr_2111.dispose();
                _SafeStr_2111 = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:String;
            var _local_5:int;
            var _local_4:int = _arg_1.readInteger();
            _SafeStr_2111 = new Map();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _arg_1.readInteger();
                _local_2 = _arg_1.readString();
                _SafeStr_2111.add(_local_3, _local_2);
                _local_5++;
            };
            return (true);
        }

        public function get badges():Map
        {
            var _local_1:int;
            var _local_2:Map = new Map();
            _local_1 = 0;
            while (_local_1 < _SafeStr_2111.length)
            {
                _local_2.add(_SafeStr_2111.getKey(_local_1), _SafeStr_2111.getWithIndex(_local_1));
                _local_1++;
            };
            return (_local_2);
        }


    }
}


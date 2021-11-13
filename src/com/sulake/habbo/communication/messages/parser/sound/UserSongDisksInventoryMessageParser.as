package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserSongDisksInventoryMessageParser implements IMessageParser 
    {

        private var _SafeStr_2101:Map;

        public function UserSongDisksInventoryMessageParser()
        {
            _SafeStr_2101 = new Map();
        }

        public function get songDiskCount():int
        {
            return (_SafeStr_2101.length);
        }

        public function getDiskId(_arg_1:int):int
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_2101.length)))
            {
                return (_SafeStr_2101.getKey(_arg_1));
            };
            return (-1);
        }

        public function getSongId(_arg_1:int):int
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_2101.length)))
            {
                return (_SafeStr_2101.getWithIndex(_arg_1));
            };
            return (-1);
        }

        public function flush():Boolean
        {
            _SafeStr_2101.reset();
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _SafeStr_2101.add(_local_4, _local_5);
                _local_3++;
            };
            return (true);
        }


    }
}


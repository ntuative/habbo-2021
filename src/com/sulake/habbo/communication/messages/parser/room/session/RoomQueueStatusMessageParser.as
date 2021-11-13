package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomQueueStatusMessageParser implements IMessageParser 
    {

        private var _flatId:int = 0;
        private var _SafeStr_2087:Map = new Map();
        private var _activeTarget:int = 0;


        public function get flatId():int
        {
            return (_flatId);
        }

        public function get activeTarget():int
        {
            return (_activeTarget);
        }

        public function flush():Boolean
        {
            _SafeStr_2087.reset();
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_6:RoomQueueSet;
            var _local_7:int;
            var _local_2:String;
            var _local_5:int;
            var _local_8:int;
            _SafeStr_2087.reset();
            _flatId = _arg_1.readInteger();
            var _local_4:int = _arg_1.readInteger();
            _local_7 = 0;
            while (_local_7 < _local_4)
            {
                _local_2 = _arg_1.readString();
                _local_5 = _arg_1.readInteger();
                if (_local_7 == 0)
                {
                    _activeTarget = _local_5;
                };
                _local_6 = new RoomQueueSet(_local_2, _local_5);
                _local_3 = _arg_1.readInteger();
                _local_8 = 0;
                while (_local_8 < _local_3)
                {
                    _local_6.addQueue(_arg_1.readString(), _arg_1.readInteger());
                    _local_8++;
                };
                _SafeStr_2087.add(_local_6.target, _local_6);
                _local_7++;
            };
            return (true);
        }

        public function getQueueSetTargets():Array
        {
            return (_SafeStr_2087.getKeys());
        }

        public function getQueueSet(_arg_1:int):RoomQueueSet
        {
            return (_SafeStr_2087.getValue(_arg_1) as RoomQueueSet);
        }


    }
}


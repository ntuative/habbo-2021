package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ObjectsMessageParser implements IMessageParser 
    {

        private var _SafeStr_743:Array = [];


        public function flush():Boolean
        {
            _SafeStr_743 = [];
            return (true);
        }

        public function getObjectCount():int
        {
            return (_SafeStr_743.length);
        }

        public function getObject(_arg_1:int):ObjectMessageData
        {
            if (((_arg_1 < 0) || (_arg_1 >= getObjectCount())))
            {
                return (null);
            };
            var _local_2:ObjectMessageData = (_SafeStr_743[_arg_1] as ObjectMessageData);
            if (_local_2 != null)
            {
                _local_2.setReadOnly();
            };
            return (_local_2);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_6:int;
            var _local_2:String;
            var _local_8:ObjectMessageData;
            if (_arg_1 == null)
            {
                return (false);
            };
            _SafeStr_743 = [];
            var _local_5:Map = new Map();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_6 = _arg_1.readInteger();
                _local_2 = _arg_1.readString();
                _local_5.add(_local_6, _local_2);
                _local_4++;
            };
            var _local_7:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_7)
            {
                _local_8 = _SafeStr_75.parseObjectData(_arg_1);
                if (_local_8 != null)
                {
                    _local_8.ownerName = _local_5.getValue(_local_8.ownerId);
                    _SafeStr_743.push(_local_8);
                };
                _local_4++;
            };
            return (true);
        }


    }
}


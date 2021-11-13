package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.room.object.data._SafeStr_80;
    import com.sulake.habbo.room.IStuffData;

        public class _SafeStr_75
    {


        public static function parseObjectData(_arg_1:IMessageDataWrapper):ObjectMessageData
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_2:int = _arg_1.readInteger();
            var _local_5:ObjectMessageData = new ObjectMessageData(_local_2);
            var _local_3:int = _arg_1.readInteger();
            _local_5.type = _local_3;
            _local_5.x = _arg_1.readInteger();
            _local_5.y = _arg_1.readInteger();
            _local_5.dir = ((_arg_1.readInteger() % 8) * 45);
            _local_5.z = Number(_arg_1.readString());
            _local_5.sizeZ = Number(_arg_1.readString());
            _local_5.extra = _arg_1.readInteger();
            _local_5.data = parseStuffData(_arg_1);
            var _local_4:Number = parseFloat(_local_5.data.getLegacyString());
            if (!isNaN(_local_4))
            {
                _local_5.state = int(_local_5.data.getLegacyString());
            };
            _local_5.expiryTime = _arg_1.readInteger();
            _local_5.usagePolicy = _arg_1.readInteger();
            _local_5.ownerId = _arg_1.readInteger();
            if (_local_3 < 0)
            {
                _local_5.staticClass = _arg_1.readString();
            };

            return (_local_5);
        }

        public static function parseStuffData(_arg_1:IMessageDataWrapper):IStuffData
        {
            var _local_3:int = _arg_1.readInteger();
            var _local_2:IStuffData = _SafeStr_80.getStuffDataWrapperForType(_local_3);
            _local_2.initializeFromIncomingMessage(_arg_1);
            return (_local_2);
        }


    }
}
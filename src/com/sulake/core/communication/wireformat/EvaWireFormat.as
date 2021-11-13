package com.sulake.core.communication.wireformat
{
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;
    import com.sulake.core.communication.util.Byte;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.connection.IConnection;

        public final class EvaWireFormat implements IWireFormat
    {

        private static const MAX_DATA:uint = 0x40000;


        public function dispose():void
        {
        }

        public function encode(_arg_1:int, _arg_2:Array):ByteArray
        {
            var _local_4:ByteArray;
            var _local_3:ByteArray = new ByteArray();
            _local_3.writeInt(0);
            _local_3.writeShort(_arg_1);
            for each (var _local_5:Object in _arg_2)
            {
                if ((_local_5 is String))
                {
                    _local_3.writeUTF((_local_5 as String));
                }
                else
                {
                    if ((_local_5 is int))
                    {
                        _local_3.writeInt((_local_5 as int));
                    }
                    else
                    {
                        if ((_local_5 is Boolean))
                        {
                            _local_3.writeBoolean((_local_5 as Boolean));
                        }
                        else
                        {
                            if ((_local_5 is Short))
                            {
                                _local_3.writeShort((_local_5 as Short).value);
                            }
                            else
                            {
                                if ((_local_5 is Byte))
                                {
                                    _local_3.writeByte((_local_5 as Byte).value);
                                }
                                else
                                {
                                    if ((_local_5 is ByteArray))
                                    {
                                        _local_4 = (_local_5 as ByteArray);
                                        _local_3.writeInt(_local_4.length);
                                        _local_3.writeBytes(_local_4);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            var _local_6:uint = _local_3.length;
            _local_3.position = 0;
            _local_3.writeInt((_local_6 - 4));
            _local_3.position = _local_6;
            return (_local_3);
        }

        public function splitMessages(_arg_1:ByteArray, _arg_2:IConnection):Array
        {
            var _local_4:uint;
            var _local_3:uint;
            var _local_7:IEncryption;
            var _local_10:ByteArray;
            var _local_9:ByteArray;
            var _local_5:ByteArray;
            var _local_8:int;
            var _local_6:Array = [];
            while (true)
            {
                if (_arg_1.bytesAvailable < 6)
                {
                    return (_local_6);
                };
                _local_4 = _arg_1.position;
                _local_3 = 0;
                _local_7 = _arg_2.getServerToClientEncryption();
                if (_local_7 != null)
                {
                    _local_7.mark();
                    _local_10 = new ByteArray();
                    _arg_1.readBytes(_local_10, 0, 4);
                    _local_7.decipher(_local_10);
                    _local_3 = _local_10.readInt();
                }
                else
                {
                    _local_3 = _arg_1.readInt();
                };
                if (((_local_3 < 2) || (_local_3 > 0x40000)))
                {
                    throw (new Error(("Invalid message length " + _local_3)));
                };
                if (_arg_1.bytesAvailable < _local_3)
                {
                    _arg_1.position = _local_4;
                    if (_local_7 != null)
                    {
                        _local_7.reset();
                    };
                    return (_local_6);
                };
                _local_9 = new ByteArray();
                if (_local_7 != null)
                {
                    _local_5 = new ByteArray();
                    _local_5.writeBytes(_arg_1, _arg_1.position, _local_3);
                    _local_7.decipher(_local_5);
                    _local_9.writeBytes(_local_5, 0, _local_3);
                    _local_9.position = 0;
                }
                else
                {
                    _local_9.writeBytes(_arg_1, _arg_1.position, _local_3);
                    _local_9.position = 0;
                };
                _arg_1.position = (_arg_1.position + _local_3);
                _local_8 = _local_9.readShort();
                _local_6.push(new EvaMessageDataWrapper(_local_8, _local_9));
            };

            return _local_6;
        }


    }
}

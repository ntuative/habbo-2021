package com.sulake.core.communication.encryption
{
    import flash.utils.ByteArray;

    public class CryptoTools 
    {


        public static function byteArrayToString(_arg_1:ByteArray):String
        {
            _arg_1.position = 0;
            var _local_2:String = "";
            while (_arg_1.bytesAvailable)
            {
                _local_2 = (_local_2 + String.fromCharCode(_arg_1.readByte()));
            };
            return (_local_2);
        }

        public static function stringToByteArray(_arg_1:String):ByteArray
        {
            var _local_3:int;
            var _local_2:ByteArray = new ByteArray();
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2.writeByte(_arg_1.charCodeAt(_local_3));
                _local_3++;
            };
            _local_2.position = 0;
            return (_local_2);
        }

        public static function byteArrayToHexString(_arg_1:ByteArray, _arg_2:Boolean=false):String
        {
            var _local_6:uint;
            var _local_3:uint;
            var _local_4:uint;
            _arg_1.position = 0;
            var _local_5:String = "";
            while (_arg_1.bytesAvailable)
            {
                _local_6 = _arg_1.readUnsignedByte();
                _local_3 = (_local_6 >> 4);
                _local_4 = (_local_6 & 0x0F);
                _local_5 = (_local_5 + _local_3.toString(16));
                _local_5 = (_local_5 + _local_4.toString(16));
            };
            if (_arg_2)
            {
                _local_5 = _local_5.toUpperCase();
            };
            return (_local_5);
        }

        public static function hexStringToByteArray(_arg_1:String):ByteArray
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_6:int;
            var _local_5:ByteArray = new ByteArray();
            if ((_arg_1.length % 2) != 0)
            {
                _arg_1 = ("0" + _arg_1);
            };
            _local_2 = 0;
            while (_local_2 < (_arg_1.length - 1))
            {
                _local_3 = parseInt(_arg_1.charAt((_local_2 + 0)), 16);
                _local_4 = parseInt(_arg_1.charAt((_local_2 + 1)), 16);
                _local_6 = ((_local_3 << 4) | _local_4);
                _local_5.writeByte(_local_6);
                _local_2++;
                _local_2++;
            };
            return (_local_5);
        }

        public static function BigIntegerToRadix(_arg_1:ByteArray, _arg_2:uint=16):String
        {
            return ("");
        }

        public static function fletcher100(_arg_1:ByteArray, _arg_2:int, _arg_3:int):int
        {
            var _local_6:int;
            var _local_4:int = _arg_2;
            var _local_5:int = _arg_3;
            _local_6 = 0;
            while (_local_6 < _arg_1.length)
            {
                _local_4 = ((_local_4 + _arg_1[_local_6]) % 0xFF);
                _local_5 = ((_local_4 + _local_5) % 0xFF);
                _local_6++;
            };
            return ((_local_4 + _local_5) % 100);
        }


    }
}
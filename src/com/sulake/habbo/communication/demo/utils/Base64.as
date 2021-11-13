package com.sulake.habbo.communication.demo.utils
{
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;

        public class Base64 
    {

        private static const _decodeChars:Vector.<int> = _initDecodeChar();


        public static function decode(_arg_1:String):String
        {
            var _local_2:ByteArray = decodeToByteArray(_arg_1);
            return (_local_2.readUTFBytes(_local_2.length));
        }

        public static function decodeToByteArray(_arg_1:String):ByteArray
        {
            var _local_8:int;
            var _local_9:int;
            var _local_2:int;
            var _local_3:int;
            var _local_7:int;
            var _local_4:int = _arg_1.length;
            var _local_5:ByteArray = new ByteArray();
            _local_5.writeUTFBytes(_arg_1);
            var _local_6:int;
            while (_local_7 < _local_4)
            {
                _local_8 = _decodeChars[_local_5[_local_7++]];
                if (_local_8 == -1) break;
                _local_9 = _decodeChars[_local_5[_local_7++]];
                if (_local_9 == -1) break;
                _local_5[_local_6++] = ((_local_8 << 2) | ((_local_9 & 0x30) >> 4));
                _local_2 = _local_5[_local_7++];
                if (_local_2 == 61) break;
                _local_2 = _decodeChars[int(_local_2)];
                if (_local_2 == -1) break;
                _local_5[_local_6++] = (((_local_9 & 0x0F) << 4) | ((_local_2 & 0x3C) >> 2));
                _local_3 = _local_5[_local_7++];
                if (_local_3 == 61) break;
                _local_3 = _decodeChars[int(_local_3)];
                if (_local_3 == -1) break;
                _local_5[_local_6++] = (((_local_2 & 0x03) << 6) | _local_3);
            };
            _local_5.length = _local_6;
            _local_5.position = 0;
            return (_local_5);
        }

        private static function _initEncoreChar():Vector.<int>
        {
            var _local_1:int;
            var _local_2:Vector.<int> = new Vector.<int>(64, true);
            var _local_3:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            _local_1 = 0;
            while (_local_1 < 64)
            {
                _local_2[_local_1] = _local_3.charCodeAt(_local_1);
                _local_1++;
            };
            return (_local_2);
        }

        private static function _initDecodeChar():Vector.<int>
        {
            return (new <int>[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        }


    }
}
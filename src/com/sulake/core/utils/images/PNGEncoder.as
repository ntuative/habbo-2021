package com.sulake.core.utils.images
{
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import flash.geom.*;

    public class PNGEncoder 
    {

        private static var _SafeStr_861:Array;
        private static var _SafeStr_862:Boolean = false;


        public static function encode(_arg_1:BitmapData):ByteArray
        {
            var _local_4:int;
            var _local_2:uint;
            var _local_5:int;
            var _local_3:ByteArray = new ByteArray();
            _local_3.writeUnsignedInt(2303741511);
            _local_3.writeUnsignedInt(218765834);
            var _local_7:ByteArray = new ByteArray();
            _local_7.writeInt(_arg_1.width);
            _local_7.writeInt(_arg_1.height);
            _local_7.writeUnsignedInt(134610944);
            _local_7.writeByte(0);
            writeChunk(_local_3, 1229472850, _local_7);
            var _local_6:ByteArray = new ByteArray();
            _local_4 = 0;
            while (_local_4 < _arg_1.height)
            {
                _local_6.writeByte(0);
                if (!_arg_1.transparent)
                {
                    _local_5 = 0;
                    while (_local_5 < _arg_1.width)
                    {
                        _local_2 = _arg_1.getPixel(_local_5, _local_4);
                        _local_6.writeUnsignedInt((((_local_2 & 0xFFFFFF) << 8) | 0xFF));
                        _local_5++;
                    };
                }
                else
                {
                    _local_5 = 0;
                    while (_local_5 < _arg_1.width)
                    {
                        _local_2 = _arg_1.getPixel32(_local_5, _local_4);
                        _local_6.writeUnsignedInt((((_local_2 & 0xFFFFFF) << 8) | (_local_2 >>> 24)));
                        _local_5++;
                    };
                };
                _local_4++;
            };
            _local_6.compress();
            writeChunk(_local_3, 1229209940, _local_6);
            writeChunk(_local_3, 1229278788, null);
            return (_local_3);
        }

        private static function writeChunk(_arg_1:ByteArray, _arg_2:uint, _arg_3:ByteArray):void
        {
            var _local_5:uint;
            var _local_10:uint;
            var _local_9:uint;
            var _local_8:int;
            if (!_SafeStr_862)
            {
                _SafeStr_862 = true;
                _SafeStr_861 = [];
                _local_10 = 0;
                while (_local_10 < 0x0100)
                {
                    _local_5 = _local_10;
                    _local_9 = 0;
                    while (_local_9 < 8)
                    {
                        if ((_local_5 & 0x01))
                        {
                            _local_5 = (0xEDB88320 ^ (_local_5 >>> 1));
                        }
                        else
                        {
                            _local_5 = (_local_5 >>> 1);
                        };
                        _local_9++;
                    };
                    _SafeStr_861[_local_10] = _local_5;
                    _local_10++;
                };
            };
            var _local_6:uint;
            if (_arg_3 != null)
            {
                _local_6 = _arg_3.length;
            };
            _arg_1.writeUnsignedInt(_local_6);
            var _local_4:uint = _arg_1.position;
            _arg_1.writeUnsignedInt(_arg_2);
            if (_arg_3 != null)
            {
                _arg_1.writeBytes(_arg_3);
            };
            var _local_7:uint = _arg_1.position;
            _arg_1.position = _local_4;
            _local_5 = 0xFFFFFFFF;
            _local_8 = 0;
            while (_local_8 < (_local_7 - _local_4))
            {
                _local_5 = (_SafeStr_861[((_local_5 ^ _arg_1.readUnsignedByte()) & 0xFF)] ^ (_local_5 >>> 8));
                _local_8++;
            };
            _local_5 = (_local_5 ^ 0xFFFFFFFF);
            _arg_1.position = _local_7;
            _arg_1.writeUnsignedInt(_local_5);
        }


    }
}


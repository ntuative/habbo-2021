package deng.utils
{
    import flash.utils.ByteArray;

    public class ChecksumUtil 
    {

        private static var _SafeStr_861:Array = makeCRCTable();


        private static function makeCRCTable():Array
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_1:uint;
            var _local_4:Array = [];
            _local_2 = 0;
            while (_local_2 < 0x0100)
            {
                _local_1 = _local_2;
                _local_3 = 0;
                while (_local_3 < 8)
                {
                    if ((_local_1 & 0x01))
                    {
                        _local_1 = (3988292384 ^ (_local_1 >>> 1));
                    }
                    else
                    {
                        _local_1 = (_local_1 >>> 1);
                    };
                    _local_3++;
                };
                _local_4.push(_local_1);
                _local_2++;
            };
            return (_local_4);
        }

        public static function CRC32(_arg_1:ByteArray, _arg_2:uint=0, _arg_3:uint=0):uint
        {
            var _local_5:uint;
            if (_arg_2 >= _arg_1.length)
            {
                _arg_2 = _arg_1.length;
            };
            if (_arg_3 == 0)
            {
                _arg_3 = (_arg_1.length - _arg_2);
            };
            if ((_arg_3 + _arg_2) > _arg_1.length)
            {
                _arg_3 = (_arg_1.length - _arg_2);
            };
            var _local_4:* = 0xFFFFFFFF;
            _local_5 = _arg_2;
            while (_local_5 < _arg_3)
            {
                _local_4 = (_SafeStr_861[((_local_4 ^ _arg_1[_local_5]) & 0xFF)] ^ (_local_4 >>> 8));
                _local_5++;
            };
            return (_local_4 ^ 0xFFFFFFFF);
        }

        public static function Adler32(_arg_1:ByteArray, _arg_2:uint=0, _arg_3:uint=0):uint
        {
            if (_arg_2 >= _arg_1.length)
            {
                _arg_2 = _arg_1.length;
            };
            if (_arg_3 == 0)
            {
                _arg_3 = (_arg_1.length - _arg_2);
            };
            if ((_arg_3 + _arg_2) > _arg_1.length)
            {
                _arg_3 = (_arg_1.length - _arg_2);
            };
            var _local_6:* = _arg_2;
            var _local_4:uint = 1;
            var _local_5:uint;
            while (_local_6 < (_arg_2 + _arg_3))
            {
                _local_4 = ((_local_4 + _arg_1[_local_6]) % 65521);
                _local_5 = ((_local_4 + _local_5) % 65521);
                _local_6++;
            };
            return ((_local_5 << 16) | _local_4);
        }


    }
}


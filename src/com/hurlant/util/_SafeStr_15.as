package com.hurlant.util
{
    import flash.utils.ByteArray;

    public class _SafeStr_15 
    {


        public static function toArray(_arg_1:String):ByteArray
        {
            var _local_3:uint;
            _arg_1 = _arg_1.replace(/^0x|\s|:/gm, "");
            var _local_2:ByteArray = new ByteArray();
            if ((_arg_1.length & 0x01) == 1)
            {
                _arg_1 = ("0" + _arg_1);
            };
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2[(_local_3 / 2)] = parseInt(_arg_1.substr(_local_3, 2), 16);
                _local_3 = (_local_3 + 2);
            };
            return (_local_2);
        }

        public static function fromArray(_arg_1:ByteArray, _arg_2:Boolean=false):String
        {
            var _local_4:uint;
            var _local_3:String = "";
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_3 = (_local_3 + ("0" + _arg_1[_local_4].toString(16)).substr(-2, 2));
                if (_arg_2)
                {
                    if (_local_4 < (_arg_1.length - 1))
                    {
                        _local_3 = (_local_3 + ":");
                    };
                };
                _local_4++;
            };
            return (_local_3);
        }

        public static function toString(_arg_1:String, _arg_2:String="utf-8"):String
        {
            var _local_3:ByteArray = toArray(_arg_1);
            return (_local_3.readMultiByte(_local_3.length, _arg_2));
        }

        public static function toRawString(_arg_1:String):String
        {
            return (toString(_arg_1, "iso-8859-1"));
        }

        public static function fromString(_arg_1:String, _arg_2:Boolean=false, _arg_3:String="utf-8"):String
        {
            var _local_4:ByteArray = new ByteArray();
            _local_4.writeMultiByte(_arg_1, _arg_3);
            return (fromArray(_local_4, _arg_2));
        }

        public static function fromRawString(_arg_1:String, _arg_2:Boolean=false):String
        {
            return (fromString(_arg_1, _arg_2, "iso-8859-1"));
        }


    }
}


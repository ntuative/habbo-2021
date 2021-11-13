package com.hurlant.crypto.hash
{
    public class SHA1 extends SHABase implements IHash 
    {

        public static const _SafeStr_754:int = 20;


        override public function getHashSize():uint
        {
            return (20);
        }

        override protected function core(_arg_1:Array, _arg_2:uint):Array
        {
            var _local_9:uint;
            var _local_13:int;
            var _local_14:int;
            var _local_8:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:uint;
            var _local_15:uint;
            var _local_17:* = (_arg_2 >> 5);
            var _local_18:* = (_arg_1[_local_17] | (128 << (24 - (_arg_2 % 32))));
            _arg_1[_local_17] = _local_18;
            _arg_1[((((_arg_2 + 64) >> 9) << 4) + 15)] = _arg_2;
            var _local_16:Array = [];
            var _local_3:* = 1732584193;
            var _local_4:* = 4023233417;
            var _local_5:* = 2562383102;
            var _local_6:* = 271733878;
            var _local_7:* = 3285377520;
            _local_9 = 0;
            while (_local_9 < _arg_1.length)
            {
                _local_13 = _local_3;
                _local_14 = _local_4;
                _local_8 = _local_5;
                _local_10 = _local_6;
                _local_11 = _local_7;
                _local_12 = 0;
                while (_local_12 < 80)
                {
                    if (_local_12 < 16)
                    {
                        _local_16[_local_12] = ((_arg_1[(_local_9 + _local_12)]) || (0));
                    }
                    else
                    {
                        _local_16[_local_12] = rol((((_local_16[(_local_12 - 3)] ^ _local_16[(_local_12 - 8)]) ^ _local_16[(_local_12 - 14)]) ^ _local_16[(_local_12 - 16)]), 1);
                    };
                    _local_15 = ((((rol(_local_3, 5) + ft(_local_12, _local_4, _local_5, _local_6)) + _local_7) + _local_16[_local_12]) + kt(_local_12));
                    _local_7 = _local_6;
                    _local_6 = _local_5;
                    _local_5 = rol(_local_4, 30);
                    _local_4 = _local_3;
                    _local_3 = _local_15;
                    _local_12++;
                };
                _local_3 = (_local_3 + _local_13);
                _local_4 = (_local_4 + _local_14);
                _local_5 = (_local_5 + _local_8);
                _local_6 = (_local_6 + _local_10);
                _local_7 = (_local_7 + _local_11);
                _local_9 = (_local_9 + 16);
            };
            return ([_local_3, _local_4, _local_5, _local_6, _local_7]);
        }

        private function rol(_arg_1:uint, _arg_2:uint):uint
        {
            return ((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2)));
        }

        private function ft(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint):uint
        {
            if (_arg_1 < 20)
            {
                return ((_arg_2 & _arg_3) | ((~(_arg_2)) & _arg_4));
            };
            if (_arg_1 < 40)
            {
                return ((_arg_2 ^ _arg_3) ^ _arg_4);
            };
            if (_arg_1 < 60)
            {
                return (((_arg_2 & _arg_3) | (_arg_2 & _arg_4)) | (_arg_3 & _arg_4));
            };
            return ((_arg_2 ^ _arg_3) ^ _arg_4);
        }

        private function kt(_arg_1:uint):uint
        {
            return ((_arg_1 < 20) ? 1518500249 : ((_arg_1 < 40) ? 1859775393 : ((_arg_1 < 60) ? 2400959708 : 3395469782)));
        }

        override public function toString():String
        {
            return ("sha1");
        }


    }
}


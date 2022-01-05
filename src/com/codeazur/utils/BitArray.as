package com.codeazur.utils
{
    import flash.utils.ByteArray;

    public class BitArray extends ByteArray
    {

        protected var _SafeStr_753:uint = 0;


        public function readBits(_arg_1:uint, _arg_2:uint=0):uint
        {
            var _local_5:uint;
            var _local_4:uint;
            var _local_3:uint;
            if (_arg_1 == 0)
            {
                return (_arg_2);
            };
            if (_SafeStr_753 > 0)
            {
                _local_3 = (this[(position - 1)] & (0xFF >> (8 - _SafeStr_753)));
                _local_4 = Math.min(_SafeStr_753, _arg_1);
                _SafeStr_753 = (_SafeStr_753 - _local_4);
                _local_5 = (_local_3 >> _SafeStr_753);
            }
            else
            {
                _local_4 = Math.min(8, _arg_1);
                _SafeStr_753 = (8 - _local_4);
                _local_5 = (readUnsignedByte() >> _SafeStr_753);
            };
            _arg_1 = (_arg_1 - _local_4);
            _arg_2 = ((_arg_2 << _local_4) | _local_5);
            return ((_arg_1 > 0) ? readBits(_arg_1, _arg_2) : _arg_2);
        }

        public function writeBits(_arg_1:uint, _arg_2:uint):void
        {
            var _local_3:uint;
            if (_arg_1 == 0)
            {
                return;
            };
            _arg_2 = (_arg_2 & (0xFFFFFFFF >>> (32 - _arg_1)));
            if (_SafeStr_753 > 0)
            {
                if (_SafeStr_753 > _arg_1)
                {
                    var _local_4:int = (position - 1);
                    var _local_5:int = (this[_local_4] | (_arg_2 << (_SafeStr_753 - _arg_1)));
                    this[_local_4] = _local_5;
                    _local_3 = _arg_1;
                    _SafeStr_753 = (_SafeStr_753 - _arg_1);
                }
                else
                {
                    if (_SafeStr_753 == _arg_1)
                    {
                        _local_5 = (position - 1);
                        _local_4 = (this[_local_5] | _arg_2);
                        this[_local_5] = _local_4;
                        _local_3 = _arg_1;
                        _SafeStr_753 = 0;
                    }
                    else
                    {
                        _local_4 = (position - 1);
                        _local_5 = (this[_local_4] | (_arg_2 >> (_arg_1 - _SafeStr_753)));
                        this[_local_4] = _local_5;
                        _local_3 = _SafeStr_753;
                        _SafeStr_753 = 0;
                    };
                };
            }
            else
            {
                _local_3 = Math.min(8, _arg_1);
                _SafeStr_753 = (8 - _local_3);
                writeByte(((_arg_2 >> (_arg_1 - _local_3)) << _SafeStr_753));
            };
            _arg_1 = (_arg_1 - _local_3);
            if (_arg_1 > 0)
            {
                writeBits(_arg_1, _arg_2);
            };
        }

        public function resetBitsPending():void
        {
            _SafeStr_753 = 0;
        }

        public function calculateMaxBits(_arg_1:Boolean, _arg_2:Array):uint
        {
            var _local_4:uint;
            var _local_7:int = -2147483648;
            if (!_arg_1)
            {
                for each (var _local_3:uint in _arg_2)
                {
                    _local_4 = (_local_4 | _local_3);
                };
            }
            else
            {
                for each (var _local_5:int in _arg_2)
                {
                    if (_local_5 >= 0)
                    {
                        _local_4 = (_local_4 | _local_5);
                    }
                    else
                    {
                        _local_4 = (_local_4 | ((~(_local_5)) << 1));
                    };
                    if (_local_7 < _local_5)
                    {
                        _local_7 = _local_5;
                    };
                };
            };
            var _local_6:uint;
            if (_local_4 > 0)
            {
                _local_6 = _local_4.toString(2).length;
                if ((((_arg_1) && (_local_7 > 0)) && (_local_7.toString(2).length >= _local_6)))
                {
                    _local_6++;
                };
            };
            return (_local_6);
        }


    }
}
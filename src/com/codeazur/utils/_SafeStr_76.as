package com.codeazur.utils
{
    import com.codeazur.as3swf.SWFData;

    public class _SafeStr_76 
    {


        public static function write(_arg_1:Number, _arg_2:SWFData):void
        {
            var _local_5:uint;
            var _local_7:uint;
            var _local_10:uint;
            var _local_8:uint;
            var _local_9:uint;
            var _local_6:int;
            var _local_3:uint;
            var _local_4:uint;
            _arg_2.resetBitsPending();
            _local_4 = _arg_2.position;
            _arg_2.writeDouble(_arg_1);
            _arg_2.position = (_arg_2.position - 4);
            _local_5 = _arg_2.readUnsignedInt();
            _arg_2.position = _local_4;
            if ((_local_5 & 0x7FFFFFFF) == 0)
            {
                _local_3 = (_local_5 >> 16);
            }
            else
            {
                _local_7 = (_local_5 & 0x80000000);
                _local_10 = (_local_5 & 0x7FF00000);
                _local_8 = (_local_5 & 0x0FFFFF);
                if (_local_10 == 0)
                {
                    _local_3 = (_local_7 >> 16);
                }
                else
                {
                    if (_local_10 == 0x7FF00000)
                    {
                        if (_local_8 == 0)
                        {
                            _local_3 = ((_local_7 >> 16) | 0x7C00);
                        }
                        else
                        {
                            _local_3 = 0xFE00;
                        };
                    }
                    else
                    {
                        _local_7 = (_local_7 >> 16);
                        _local_6 = (((_local_10 >> 20) - 1023) + 15);
                        if (_local_6 >= 31)
                        {
                            _local_3 = ((_local_8 >> 16) | 0x7C00);
                        }
                        else
                        {
                            if (_local_6 <= 0)
                            {
                                if ((10 - _local_6) > 21)
                                {
                                    _local_9 = 0;
                                }
                                else
                                {
                                    _local_8 = (_local_8 | 0x100000);
                                    _local_9 = (_local_8 >> (11 - _local_6));
                                    if (((_local_8 >> (10 - _local_6)) & 0x01))
                                    {
                                        _local_9 = (_local_9 + 1);
                                    };
                                };
                                _local_3 = (_local_7 | _local_9);
                            }
                            else
                            {
                                _local_10 = (_local_6 << 10);
                                _local_9 = (_local_8 >> 10);
                                if ((_local_8 & 0x0200))
                                {
                                    _local_3 = (((_local_7 | _local_10) | _local_9) + 1);
                                }
                                else
                                {
                                    _local_3 = ((_local_7 | _local_10) | _local_9);
                                };
                            };
                        };
                    };
                };
            };
            _arg_2.writeShort(_local_3);
            _arg_2.length = (_local_4 + 2);
        }


    }
}


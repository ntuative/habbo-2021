package com.sulake.room.utils
{
    public class ColorConverter 
    {


        public static function rgbToHSL(_arg_1:int):int
        {
            var _local_10:Number = (((_arg_1 >> 16) & 0xFF) / 0xFF);
            var _local_6:Number = (((_arg_1 >> 8) & 0xFF) / 0xFF);
            var _local_4:Number = ((_arg_1 & 0xFF) / 0xFF);
            var _local_5:Number = Math.max(_local_10, _local_6, _local_4);
            var _local_11:Number = Math.min(_local_10, _local_6, _local_4);
            var _local_2:Number = (_local_5 - _local_11);
            var _local_14:Number = 0;
            var _local_13:Number = 0;
            var _local_9:Number = 0;
            if (_local_2 == 0)
            {
                _local_14 = 0;
            }
            else
            {
                if (_local_5 == _local_10)
                {
                    if (_local_6 > _local_4)
                    {
                        _local_14 = ((60 * (_local_6 - _local_4)) / _local_2);
                    }
                    else
                    {
                        _local_14 = (((60 * (_local_6 - _local_4)) / _local_2) + 360);
                    };
                }
                else
                {
                    if (_local_5 == _local_6)
                    {
                        _local_14 = (((60 * (_local_4 - _local_10)) / _local_2) + 120);
                    }
                    else
                    {
                        if (_local_5 == _local_4)
                        {
                            _local_14 = (((60 * (_local_10 - _local_6)) / _local_2) + 240);
                        };
                    };
                };
            };
            _local_13 = (0.5 * (_local_5 + _local_11));
            if (_local_2 == 0)
            {
                _local_9 = 0;
            }
            else
            {
                if (_local_13 <= 0.5)
                {
                    _local_9 = ((_local_2 / _local_13) * 0.5);
                }
                else
                {
                    _local_9 = ((_local_2 / (1 - _local_13)) * 0.5);
                };
            };
            var _local_7:int = int(Math.round(((_local_14 / 360) * 0xFF)));
            var _local_12:int = Math.round((_local_9 * 0xFF));
            var _local_8:int = Math.round((_local_13 * 0xFF));
            return (((_local_7 << 16) + (_local_12 << 8)) + _local_8);
        }

        public static function hslToRGB(_arg_1:int):int
        {
            var _local_12:Number;
            var _local_11:Number;
            var _local_6:Number;
            var _local_16:Number;
            var _local_8:Number;
            var _local_5:Number = (((_arg_1 >> 16) & 0xFF) / 0xFF);
            var _local_14:Number = (((_arg_1 >> 8) & 0xFF) / 0xFF);
            var _local_7:Number = ((_arg_1 & 0xFF) / 0xFF);
            var _local_10:Number = 0;
            var _local_3:Number = 0;
            var _local_15:Number = 0;
            if (_local_14 > 0)
            {
                _local_12 = 0;
                _local_11 = 0;
                if (_local_7 < 0.5)
                {
                    _local_12 = (_local_7 * (1 + _local_14));
                }
                else
                {
                    _local_12 = ((_local_7 + _local_14) - (_local_7 * _local_14));
                };
                _local_11 = ((2 * _local_7) - _local_12);
                _local_6 = (_local_5 + 0.333333333333333);
                _local_16 = _local_5;
                _local_8 = (_local_5 - 0.333333333333333);
                if (_local_6 < 0)
                {
                    _local_6 = (_local_6 + 1);
                }
                else
                {
                    if (_local_6 > 1)
                    {
                        _local_6 = (_local_6 - 1);
                    };
                };
                if (_local_16 < 0)
                {
                    _local_16 = (_local_16 + 1);
                }
                else
                {
                    if (_local_16 > 1)
                    {
                        _local_16 = (_local_16 - 1);
                    };
                };
                if (_local_8 < 0)
                {
                    _local_8 = (_local_8 + 1);
                }
                else
                {
                    if (_local_8 > 1)
                    {
                        _local_8 = (_local_8 - 1);
                    };
                };
                if ((_local_6 * 6) < 1)
                {
                    _local_10 = (_local_11 + (((_local_12 - _local_11) * 6) * _local_6));
                }
                else
                {
                    if ((_local_6 * 2) < 1)
                    {
                        _local_10 = _local_12;
                    }
                    else
                    {
                        if ((_local_6 * 3) < 2)
                        {
                            _local_10 = (_local_11 + (((_local_12 - _local_11) * 6) * (0.666666666666667 - _local_6)));
                        }
                        else
                        {
                            _local_10 = _local_11;
                        };
                    };
                };
                if ((_local_16 * 6) < 1)
                {
                    _local_3 = (_local_11 + (((_local_12 - _local_11) * 6) * _local_16));
                }
                else
                {
                    if ((_local_16 * 2) < 1)
                    {
                        _local_3 = _local_12;
                    }
                    else
                    {
                        if ((_local_16 * 3) < 2)
                        {
                            _local_3 = (_local_11 + (((_local_12 - _local_11) * 6) * (0.666666666666667 - _local_16)));
                        }
                        else
                        {
                            _local_3 = _local_11;
                        };
                    };
                };
                if ((_local_8 * 6) < 1)
                {
                    _local_15 = (_local_11 + (((_local_12 - _local_11) * 6) * _local_8));
                }
                else
                {
                    if ((_local_8 * 2) < 1)
                    {
                        _local_15 = _local_12;
                    }
                    else
                    {
                        if ((_local_8 * 3) < 2)
                        {
                            _local_15 = (_local_11 + (((_local_12 - _local_11) * 6) * (0.666666666666667 - _local_8)));
                        }
                        else
                        {
                            _local_15 = _local_11;
                        };
                    };
                };
            }
            else
            {
                _local_10 = _local_7;
                _local_3 = _local_7;
                _local_15 = _local_7;
            };
            var _local_13:int = Math.round((_local_10 * 0xFF));
            var _local_4:int = Math.round((_local_3 * 0xFF));
            var _local_2:int = Math.round((_local_15 * 0xFF));
            var _local_9:int = (((_local_13 << 16) + (_local_4 << 8)) + _local_2);
            return (_local_9);
        }

        public static function rgb2xyz(_arg_1:int):IVector3d
        {
            var _local_2:Number = (((_arg_1 >> 16) & 0xFF) / 0xFF);
            var _local_4:Number = (((_arg_1 >> 8) & 0xFF) / 0xFF);
            var _local_3:Number = (((_arg_1 >> 0) & 0xFF) / 0xFF);
            if (_local_2 > 0.04045)
            {
                _local_2 = Math.pow(((_local_2 + 0.055) / 1.055), 2.4);
            }
            else
            {
                _local_2 = (_local_2 / 12.92);
            };
            if (_local_4 > 0.04045)
            {
                _local_4 = Math.pow(((_local_4 + 0.055) / 1.055), 2.4);
            }
            else
            {
                _local_4 = (_local_4 / 12.92);
            };
            if (_local_3 > 0.04045)
            {
                _local_3 = Math.pow(((_local_3 + 0.055) / 1.055), 2.4);
            }
            else
            {
                _local_3 = (_local_3 / 12.92);
            };
            _local_2 = (_local_2 * 100);
            _local_4 = (_local_4 * 100);
            _local_3 = (_local_3 * 100);
            return (new Vector3d((((_local_2 * 0.4124) + (_local_4 * 0.3576)) + (_local_3 * 0.1805)), (((_local_2 * 0.2126) + (_local_4 * 0.7152)) + (_local_3 * 0.0722)), (((_local_2 * 0.0193) + (_local_4 * 0.1192)) + (_local_3 * 0.9505))));
        }

        public static function xyz2CieLab(_arg_1:IVector3d):IVector3d
        {
            var _local_2:Number = (_arg_1.x / 95.047);
            var _local_3:Number = (_arg_1.y / 100);
            var _local_4:Number = (_arg_1.z / 108.883);
            if (_local_2 > 0.008856)
            {
                _local_2 = Math.pow(_local_2, 0.333333333333333);
            }
            else
            {
                _local_2 = ((7.787 * _local_2) + 0.137931034482759);
            };
            if (_local_3 > 0.008856)
            {
                _local_3 = Math.pow(_local_3, 0.333333333333333);
            }
            else
            {
                _local_3 = ((7.787 * _local_3) + 0.137931034482759);
            };
            if (_local_4 > 0.008856)
            {
                _local_4 = Math.pow(_local_4, 0.333333333333333);
            }
            else
            {
                _local_4 = ((7.787 * _local_4) + 0.137931034482759);
            };
            return (new Vector3d(((116 * _local_3) - 16), (500 * (_local_2 - _local_3)), (200 * (_local_3 - _local_4))));
        }

        public static function rgb2CieLab(_arg_1:int):IVector3d
        {
            return (ColorConverter.xyz2CieLab(ColorConverter.rgb2xyz(_arg_1)));
        }


    }
}
package com.hurlant.math
{
    import com.hurlant.util._SafeStr_15;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.prng.Random;
    import flash.system.System;
    import com.hurlant.math.bi_internal;

    use namespace bi_internal;

    public class BigInteger 
    {

        public static const _SafeStr_766:int = 30;
        public static const _SafeStr_767:int = 0x40000000;
        public static const DM:int = 1073741823;
        public static const BI_FP:int = 52;
        public static const _SafeStr_268:Number = Math.pow(2, 52);
        public static const F1:int = 22;
        public static const F2:int = 8;
        public static const ZERO:BigInteger = nbv(0);
        public static const _SafeStr_269:BigInteger = nbv(1);
        public static const lowprimes:Array = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 0x0101, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509];
        public static const _SafeStr_270:int = (0x4000000 / lowprimes[(lowprimes.length - 1)]);

        public var t:int;
        bi_internal var s:int;
        bi_internal var a:Array;

        public function BigInteger(_arg_1:*=null, _arg_2:int=0, _arg_3:Boolean=false)
        {
            var _local_4:* = null;
            var _local_5:int;
            super();
            a = [];
            if ((_arg_1 is String))
            {
                if (((_arg_2) && (!(_arg_2 == 16))))
                {
                    fromRadix((_arg_1 as String), _arg_2);
                }
                else
                {
                    _arg_1 = _SafeStr_15.toArray(_arg_1);
                    _arg_2 = 0;
                };
            };
            if ((_arg_1 is ByteArray))
            {
                _local_4 = (_arg_1 as ByteArray);
                _local_5 = ((_arg_2) || (_local_4.length - _local_4.position));
                fromArray(_local_4, _local_5, _arg_3);
            };
        }

        public static function nbv(_arg_1:int):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            _local_2.fromInt(_arg_1);
            return (_local_2);
        }


        public function dispose():void
        {
            var _local_2:uint;
            var _local_1:Random = new Random();
            _local_2 = 0;
            while (_local_2 < a.length)
            {
                a[_local_2] = _local_1.nextByte();
                delete a[_local_2];
                _local_2++;
            };
            a = null;
            t = 0;
            s = 0;
            System.pauseForGCIfCollectionImminent();
        }

        public function toString(_arg_1:Number=16):String
        {
            var _local_7:int;
            if (s < 0)
            {
                return ("-" + negate().toString(_arg_1));
            };
            switch (_arg_1)
            {
                case 2:
                    _local_7 = 1;
                    break;
                case 4:
                    _local_7 = 2;
                    break;
                case 8:
                    _local_7 = 3;
                    break;
                case 16:
                    _local_7 = 4;
                    break;
                case 32:
                    _local_7 = 5;
                    break;
                default:
                    return (toRadix(_arg_1));
            };
            var _local_3:int = ((1 << _local_7) - 1);
            var _local_5:int;
            var _local_8:Boolean;
            var _local_4:String = "";
            var _local_6:int = t;
            var _local_2:int = (30 - ((_local_6 * 30) % _local_7));
            if (_local_6-- > 0)
            {
                if (((_local_2 < 30) && ((_local_5 = (a[_local_6] >> _local_2)) > 0)))
                {
                    _local_8 = true;
                    _local_4 = _local_5.toString(36);
                };
                while (_local_6 >= 0)
                {
                    if (_local_2 < _local_7)
                    {
                        _local_5 = ((a[_local_6] & ((1 << _local_2) - 1)) << (_local_7 - _local_2));
                        var _temp_1:* = _local_5;
                        _local_2 = (_local_2 + (30 - _local_7));
                        _local_5 = (_temp_1 | (a[--_local_6] >> _local_2));
                    }
                    else
                    {
                        _local_2 = (_local_2 - _local_7);
                        _local_5 = ((a[_local_6] >> _local_2) & _local_3);
                        if (_local_2 <= 0)
                        {
                            _local_2 = (_local_2 + 30);
                            _local_6--;
                        };
                    };
                    if (_local_5 > 0)
                    {
                        _local_8 = true;
                    };
                    if (_local_8)
                    {
                        _local_4 = (_local_4 + _local_5.toString(36));
                    };
                };
            };
            return ((_local_8) ? _local_4 : "0");
        }

        public function toArray(_arg_1:ByteArray):uint
        {
            var _local_7:int;
            _local_7 = 8;
            var _local_3:int;
            _local_3 = 0xFF;
            var _local_5:int;
            var _local_6:int = t;
            var _local_2:int = (30 - ((_local_6 * 30) % 8));
            var _local_8:Boolean;
            var _local_4:int;
            if (_local_6-- > 0)
            {
                if (((_local_2 < 30) && ((_local_5 = (a[_local_6] >> _local_2)) > 0)))
                {
                    _local_8 = true;
                    _arg_1.writeByte(_local_5);
                    _local_4++;
                };
                while (_local_6 >= 0)
                {
                    if (_local_2 < 8)
                    {
                        _local_5 = ((a[_local_6] & ((1 << _local_2) - 1)) << (8 - _local_2));
                        var _temp_1:* = _local_5;
                        _local_2 = (_local_2 + (30 - 8));
                        _local_5 = (_temp_1 | (a[--_local_6] >> _local_2));
                    }
                    else
                    {
                        _local_2 = (_local_2 - 8);
                        _local_5 = ((a[_local_6] >> _local_2) & 0xFF);
                        if (_local_2 <= 0)
                        {
                            _local_2 = (_local_2 + 30);
                            _local_6--;
                        };
                    };
                    if (_local_5 > 0)
                    {
                        _local_8 = true;
                    };
                    if (_local_8)
                    {
                        _arg_1.writeByte(_local_5);
                        _local_4++;
                    };
                };
            };
            return (_local_4);
        }

        public function valueOf():Number
        {
            var _local_2:uint;
            if (s == -1)
            {
                return (-(negate().valueOf()));
            };
            var _local_1:* = 1;
            var _local_3:* = 0;
            _local_2 = 0;
            while (_local_2 < t)
            {
                _local_3 = (_local_3 + (a[_local_2] * _local_1));
                _local_1 = (_local_1 * 0x40000000);
                _local_2++;
            };
            return (_local_3);
        }

        public function negate():BigInteger
        {
            var _local_1:BigInteger = nbi();
            ZERO.subTo(this, _local_1);
            return (_local_1);
        }

        public function abs():BigInteger
        {
            return ((s < 0) ? negate() : this);
        }

        public function compareTo(_arg_1:BigInteger):int
        {
            var _local_2:int = (s - _arg_1.s);
            if (_local_2 != 0)
            {
                return (_local_2);
            };
            var _local_3:int = t;
            _local_2 = (_local_3 - _arg_1.t);
            if (_local_2 != 0)
            {
                return ((s < 0) ? (_local_2 * -1) : _local_2);
            };
            while (--_local_3 >= 0)
            {
                _local_2 = (a[_local_3] - _arg_1.a[_local_3]);
                if (_local_2 != 0)
                {
                    return (_local_2);
                };
            };
            return (0);
        }

        bi_internal function nbits(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int = 1;
            _local_3 = (_arg_1 >>> 16);
            if (_local_3 != 0)
            {
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 16);
            };
            _local_3 = (_arg_1 >> 8);
            if (_local_3 != 0)
            {
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 8);
            };
            _local_3 = (_arg_1 >> 4);
            if (_local_3 != 0)
            {
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 4);
            };
            _local_3 = (_arg_1 >> 2);
            if (_local_3 != 0)
            {
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 2);
            };
            _local_3 = (_arg_1 >> 1);
            if (_local_3 != 0)
            {
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 1);
            };
            return (_local_2);
        }

        public function bitLength():int
        {
            if (t <= 0)
            {
                return (0);
            };
            return ((30 * (t - 1)) + nbits((a[(t - 1)] ^ (s & 0x3FFFFFFF))));
        }

        public function mod(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = nbi();
            abs().divRemTo(_arg_1, null, _local_2);
            if (((s < 0) && (_local_2.compareTo(ZERO) > 0)))
            {
                _arg_1.subTo(_local_2, _local_2);
            };
            return (_local_2);
        }

        public function modPowInt(_arg_1:int, _arg_2:BigInteger):BigInteger
        {
            var _local_3:IReduction;
            if (((_arg_1 < 0x0100) || (_arg_2.isEven())))
            {
                _local_3 = new ClassicReduction(_arg_2);
            }
            else
            {
                _local_3 = new MontgomeryReduction(_arg_2);
            };
            return (exp(_arg_1, _local_3));
        }

        bi_internal function copyTo(_arg_1:BigInteger):void
        {
            var _local_2:int;
            _local_2 = (t - 1);
            while (_local_2 >= 0)
            {
                _arg_1.a[_local_2] = a[_local_2];
                _local_2--;
            };
            _arg_1.t = t;
            _arg_1.s = s;
        }

        bi_internal function fromInt(_arg_1:int):void
        {
            t = 1;
            s = ((_arg_1 < 0) ? -1 : 0);
            if (_arg_1 > 0)
            {
                a[0] = _arg_1;
            }
            else
            {
                if (_arg_1 < -1)
                {
                    a[0] = (_arg_1 + 0x40000000);
                }
                else
                {
                    t = 0;
                };
            };
        }

        bi_internal function fromArray(_arg_1:ByteArray, _arg_2:int, _arg_3:Boolean=false):void
        {
            var _local_8:int;
            _local_8 = 8;
            var _local_6:int;
            var _local_4:int = _arg_1.position;
            var _local_7:int = (_local_4 + _arg_2);
            var _local_5:int;
            t = 0;
            s = 0;
            while (--_local_7 >= _local_4)
            {
                _local_6 = ((_local_7 < _arg_1.length) ? _arg_1[_local_7] : 0);
                if (_local_5 == 0)
                {
                    a[t++] = _local_6;
                }
                else
                {
                    if ((_local_5 + 8) > 30)
                    {
                        var _local_9:* = (t - 1);
                        var _local_10:* = (a[_local_9] | ((_local_6 & ((1 << (30 - _local_5)) - 1)) << _local_5));
                        a[_local_9] = _local_10;
                        a[t++] = (_local_6 >> (30 - _local_5));
                    }
                    else
                    {
                        _local_10 = (t - 1);
                        _local_9 = (a[_local_10] | (_local_6 << _local_5));
                        a[_local_10] = _local_9;
                    };
                };
                _local_5 = (_local_5 + 8);
                if (_local_5 >= 30)
                {
                    _local_5 = (_local_5 - 30);
                };
            };
            if (((!(_arg_3)) && ((_arg_1[0] & 0x80) == 128)))
            {
                s = -1;
                if (_local_5 > 0)
                {
                    _local_9 = (t - 1);
                    _local_10 = (a[_local_9] | (((1 << (30 - _local_5)) - 1) << _local_5));
                    a[_local_9] = _local_10;
                };
            };
            clamp();
            _arg_1.position = Math.min((_local_4 + _arg_2), _arg_1.length);
        }

        bi_internal function clamp():void
        {
            var _local_1:* = (s & 0x3FFFFFFF);
            while (((t > 0) && (a[(t - 1)] == _local_1)))
            {
                t--;
            };
        }

        bi_internal function dlShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_3:int;
            _local_3 = (t - 1);
            while (_local_3 >= 0)
            {
                _arg_2.a[(_local_3 + _arg_1)] = a[_local_3];
                _local_3--;
            };
            _local_3 = (_arg_1 - 1);
            while (_local_3 >= 0)
            {
                _arg_2.a[_local_3] = 0;
                _local_3--;
            };
            _arg_2.t = (t + _arg_1);
            _arg_2.s = s;
        }

        bi_internal function drShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_3:int;
            _local_3 = _arg_1;
            while (_local_3 < t)
            {
                _arg_2.a[(_local_3 - _arg_1)] = a[_local_3];
                _local_3++;
            };
            _arg_2.t = Math.max((t - _arg_1), 0);
            _arg_2.s = s;
        }

        bi_internal function lShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_6:int;
            var _local_3:int = (_arg_1 % 30);
            var _local_5:int = (30 - _local_3);
            var _local_7:int = ((1 << _local_5) - 1);
            var _local_8:int = int((_arg_1 / 30));
            var _local_4:* = ((s << _local_3) & 0x3FFFFFFF);
            _local_6 = (t - 1);
            while (_local_6 >= 0)
            {
                _arg_2.a[((_local_6 + _local_8) + 1)] = ((a[_local_6] >> _local_5) | _local_4);
                _local_4 = ((a[_local_6] & _local_7) << _local_3);
                _local_6--;
            };
            _local_6 = (_local_8 - 1);
            while (_local_6 >= 0)
            {
                _arg_2.a[_local_6] = 0;
                _local_6--;
            };
            _arg_2.a[_local_8] = _local_4;
            _arg_2.t = ((t + _local_8) + 1);
            _arg_2.s = s;
            _arg_2.clamp();
        }

        bi_internal function rShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_5:int;
            _arg_2.s = s;
            var _local_7:int = int((_arg_1 / 30));
            if (_local_7 >= t)
            {
                _arg_2.t = 0;
                return;
            };
            var _local_3:int = (_arg_1 % 30);
            var _local_4:int = (30 - _local_3);
            var _local_6:int = ((1 << _local_3) - 1);
            _arg_2.a[0] = (a[_local_7] >> _local_3);
            _local_5 = (_local_7 + 1);
            while (_local_5 < t)
            {
                var _local_8:* = ((_local_5 - _local_7) - 1);
                var _local_9:* = (_arg_2.a[_local_8] | ((a[_local_5] & _local_6) << _local_4));
                _arg_2.a[_local_8] = _local_9;
                _arg_2.a[(_local_5 - _local_7)] = (a[_local_5] >> _local_3);
                _local_5++;
            };
            if (_local_3 > 0)
            {
                _local_9 = ((t - _local_7) - 1);
                _local_8 = (_arg_2.a[_local_9] | ((s & _local_6) << _local_4));
                _arg_2.a[_local_9] = _local_8;
            };
            _arg_2.t = (t - _local_7);
            _arg_2.clamp();
        }

        bi_internal function subTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            var _local_4:int;
            var _local_3:int;
            var _local_5:int = Math.min(_arg_1.t, t);
            while (_local_4 < _local_5)
            {
                _local_3 = (_local_3 + (a[_local_4] - _arg_1.a[_local_4]));
                _arg_2.a[_local_4++] = (_local_3 & 0x3FFFFFFF);
                _local_3 = (_local_3 >> 30);
            };
            if (_arg_1.t < t)
            {
                _local_3 = (_local_3 - _arg_1.s);
                while (_local_4 < t)
                {
                    _local_3 = (_local_3 + a[_local_4]);
                    _arg_2.a[_local_4++] = (_local_3 & 0x3FFFFFFF);
                    _local_3 = (_local_3 >> 30);
                };
                _local_3 = (_local_3 + s);
            }
            else
            {
                _local_3 = (_local_3 + s);
                while (_local_4 < _arg_1.t)
                {
                    _local_3 = (_local_3 - _arg_1.a[_local_4]);
                    _arg_2.a[_local_4++] = (_local_3 & 0x3FFFFFFF);
                    _local_3 = (_local_3 >> 30);
                };
                _local_3 = (_local_3 - _arg_1.s);
            };
            _arg_2.s = ((_local_3 < 0) ? -1 : 0);
            if (_local_3 < -1)
            {
                _arg_2.a[_local_4++] = (0x40000000 + _local_3);
            }
            else
            {
                if (_local_3 > 0)
                {
                    _arg_2.a[_local_4++] = _local_3;
                };
            };
            _arg_2.t = _local_4;
            _arg_2.clamp();
        }

        bi_internal function am(_arg_1:int, _arg_2:int, _arg_3:BigInteger, _arg_4:int, _arg_5:int, _arg_6:int):int
        {
            var _local_10:int;
            var _local_9:int;
            var _local_11:int;
            var _local_8:* = (_arg_2 & 0x7FFF);
            var _local_7:* = (_arg_2 >> 15);
            while (--_arg_6 >= 0)
            {
                _local_10 = (a[_arg_1] & 0x7FFF);
                _local_9 = (a[_arg_1++] >> 15);
                _local_11 = ((_local_7 * _local_10) + (_local_9 * _local_8));
                _local_10 = ((((_local_8 * _local_10) + ((_local_11 & 0x7FFF) << 15)) + _arg_3.a[_arg_4]) + (_arg_5 & 0x3FFFFFFF));
                _arg_5 = ((((_local_10 >>> 30) + (_local_11 >>> 15)) + (_local_7 * _local_9)) + (_arg_5 >>> 30));
                _arg_3.a[_arg_4++] = (_local_10 & 0x3FFFFFFF);
            };
            return (_arg_5);
        }

        bi_internal function multiplyTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            var _local_3:BigInteger = abs();
            var _local_4:BigInteger = _arg_1.abs();
            var _local_5:int = _local_3.t;
            _arg_2.t = (_local_5 + _local_4.t);
            while (--_local_5 >= 0)
            {
                _arg_2.a[_local_5] = 0;
            };
            _local_5 = 0;
            while (_local_5 < _local_4.t)
            {
                _arg_2.a[(_local_5 + _local_3.t)] = _local_3.am(0, _local_4.a[_local_5], _arg_2, _local_5, 0, _local_3.t);
                _local_5++;
            };
            _arg_2.s = 0;
            _arg_2.clamp();
            if (s != _arg_1.s)
            {
                ZERO.subTo(_arg_2, _arg_2);
            };
        }

        bi_internal function squareTo(_arg_1:BigInteger):void
        {
            var _local_2:int;
            var _local_3:BigInteger = abs();
            var _local_5:* = (2 * _local_3.t);
            _arg_1.t = _local_5;
            var _local_4:* = _local_5;
            while (--_local_4 >= 0)
            {
                _arg_1.a[_local_4] = 0;
            };
            _local_4 = 0;
            while (_local_4 < (_local_3.t - 1))
            {
                _local_2 = _local_3.am(_local_4, _local_3.a[_local_4], _arg_1, (2 * _local_4), 0, 1);
                _local_5 = (_local_4 + _local_3.t);
                var _local_6:* = (_arg_1.a[_local_5] + _local_3.am((_local_4 + 1), (2 * _local_3.a[_local_4]), _arg_1, ((2 * _local_4) + 1), _local_2, ((_local_3.t - _local_4) - 1)));
                _arg_1.a[_local_5] = _local_6;
                if (_local_6 >= 0x40000000)
                {
                    _local_6 = (_local_4 + _local_3.t);
                    _local_5 = (_arg_1.a[_local_6] - 0x40000000);
                    _arg_1.a[_local_6] = _local_5;
                    _arg_1.a[((_local_4 + _local_3.t) + 1)] = 1;
                };
                _local_4++;
            };
            if (_arg_1.t > 0)
            {
                _local_5 = (_arg_1.t - 1);
                _local_6 = (_arg_1.a[_local_5] + _local_3.am(_local_4, _local_3.a[_local_4], _arg_1, (2 * _local_4), 0, 1));
                _arg_1.a[_local_5] = _local_6;
            };
            _arg_1.s = 0;
            _arg_1.clamp();
        }

        bi_internal function divRemTo(_arg_1:BigInteger, _arg_2:BigInteger=null, _arg_3:BigInteger=null):void
        {
            var _local_12:int;
            var _local_18:BigInteger = _arg_1.abs();
            if (_local_18.t <= 0)
            {
                return;
            };
            var _local_5:BigInteger = abs();
            if (_local_5.t < _local_18.t)
            {
                if (_arg_2 != null)
                {
                    _arg_2.fromInt(0);
                };
                if (_arg_3 != null)
                {
                    copyTo(_arg_3);
                };
                return;
            };
            if (_arg_3 == null)
            {
                _arg_3 = nbi();
            };
            var _local_15:BigInteger = nbi();
            var _local_19:int = s;
            var _local_7:int = _arg_1.s;
            var _local_4:int = (30 - nbits(_local_18.a[(_local_18.t - 1)]));
            if (_local_4 > 0)
            {
                _local_18.lShiftTo(_local_4, _local_15);
                _local_5.lShiftTo(_local_4, _arg_3);
            }
            else
            {
                _local_18.copyTo(_local_15);
                _local_5.copyTo(_arg_3);
            };
            var _local_16:int = _local_15.t;
            var _local_14:int = _local_15.a[(_local_16 - 1)];
            if (_local_14 == 0)
            {
                return;
            };
            var _local_17:Number = ((_local_14 * (1 << 22)) + ((_local_16 > 1) ? (_local_15.a[(_local_16 - 2)] >> 8) : 0));
            var _local_10:Number = (_SafeStr_268 / _local_17);
            var _local_11:Number = ((1 << 22) / _local_17);
            var _local_6:Number = 0x0100;
            var _local_8:int = _arg_3.t;
            var _local_9:int = (_local_8 - _local_16);
            var _local_13:BigInteger = ((_arg_2 == null) ? nbi() : _arg_2);
            _local_15.dlShiftTo(_local_9, _local_13);
            if (_arg_3.compareTo(_local_13) >= 0)
            {
                _arg_3.a[_arg_3.t++] = 1;
                _arg_3.subTo(_local_13, _arg_3);
            };
            _SafeStr_269.dlShiftTo(_local_16, _local_13);
            _local_13.subTo(_local_15, _local_15);
            while (_local_15.t < _local_16)
            {
                var _local_21:* = _local_15;
                var _local_22:int = 0;
                var _local_23:* = new (XMLList)("");
                for each (var _local_20:* in _local_15)
                {
                    with (_local_20)
                    {
                        _local_15.t++;
                    };
                };
                _local_23;
            };
            while (--_local_9 >= 0)
            {
                _local_12 = ((_arg_3.a[--_local_8] == _local_14) ? 1073741823 : ((_arg_3.a[_local_8] * _local_10) + ((_arg_3.a[(_local_8 - 1)] + _local_6) * _local_11)));
                _local_22 = _local_8;
                _local_21 = (_arg_3.a[_local_22] + _local_15.am(0, _local_12, _arg_3, _local_9, 0, _local_16));
                _arg_3.a[_local_22] = _local_21;
                if (_local_21 < _local_12)
                {
                    _local_15.dlShiftTo(_local_9, _local_13);
                    _arg_3.subTo(_local_13, _arg_3);
                    while (_arg_3.a[_local_8] < --_local_12)
                    {
                        _arg_3.subTo(_local_13, _arg_3);
                    };
                };
            };
            if (_arg_2 != null)
            {
                _arg_3.drShiftTo(_local_16, _arg_2);
                if (_local_19 != _local_7)
                {
                    ZERO.subTo(_arg_2, _arg_2);
                };
            };
            _arg_3.t = _local_16;
            _arg_3.clamp();
            if (_local_4 > 0)
            {
                _arg_3.rShiftTo(_local_4, _arg_3);
            };
            if (_local_19 < 0)
            {
                ZERO.subTo(_arg_3, _arg_3);
            };
        }

        bi_internal function invDigit():int
        {
            if (t < 1)
            {
                return (0);
            };
            var _local_1:int = a[0];
            if ((_local_1 & 0x01) == 0)
            {
                return (0);
            };
            var _local_2:* = (_local_1 & 0x03);
            _local_2 = ((_local_2 * (2 - ((_local_1 & 0x0F) * _local_2))) & 0x0F);
            _local_2 = ((_local_2 * (2 - ((_local_1 & 0xFF) * _local_2))) & 0xFF);
            _local_2 = ((_local_2 * (2 - (((_local_1 & 0xFFFF) * _local_2) & 0xFFFF))) & 0xFFFF);
            _local_2 = ((_local_2 * (2 - ((_local_1 * _local_2) % 0x40000000))) % 0x40000000);
            return ((_local_2 > 0) ? (0x40000000 - _local_2) : -(_local_2));
        }

        bi_internal function isEven():Boolean
        {
            return (((t > 0) ? (a[0] & 0x01) : s) == 0);
        }

        bi_internal function exp(_arg_1:int, _arg_2:IReduction):BigInteger
        {
            var _local_5:* = null;
            if (((_arg_1 > 0xFFFFFFFF) || (_arg_1 < 1)))
            {
                return (_SafeStr_269);
            };
            var _local_4:BigInteger = nbi();
            var _local_3:BigInteger = nbi();
            var _local_6:BigInteger = _arg_2.convert(this);
            var _local_7:int = (nbits(_arg_1) - 1);
            _local_6.copyTo(_local_4);
            while (--_local_7 >= 0)
            {
                _arg_2.sqrTo(_local_4, _local_3);
                if ((_arg_1 & (1 << _local_7)) > 0)
                {
                    _arg_2.mulTo(_local_3, _local_6, _local_4);
                }
                else
                {
                    _local_5 = _local_4;
                    _local_4 = _local_3;
                    _local_3 = _local_5;
                };
            };
            return (_arg_2.revert(_local_4));
        }

        bi_internal function intAt(_arg_1:String, _arg_2:int):int
        {
            var _local_3:Number = parseInt(_arg_1.charAt(_arg_2), 36);
            return ((isNaN(_local_3)) ? -1 : _local_3);
        }

        protected function nbi():*
        {
            return (new BigInteger());
        }

        public function clone():BigInteger
        {
            var _local_1:BigInteger = new BigInteger();
            this.copyTo(_local_1);
            return (_local_1);
        }

        public function intValue():int
        {
            if (s < 0)
            {
                if (t == 1)
                {
                    return (a[0] - 0x40000000);
                };
                if (t == 0)
                {
                    return (-1);
                };
            }
            else
            {
                if (t == 1)
                {
                    return (a[0]);
                };
                if (t == 0)
                {
                    return (0);
                };
            };
            return (((a[1] & 0x03) << 30) | a[0]);
        }

        public function byteValue():int
        {
            return ((t == 0) ? s : ((a[0] << 24) >> 24));
        }

        public function shortValue():int
        {
            return ((t == 0) ? s : ((a[0] << 16) >> 16));
        }

        protected function chunkSize(_arg_1:Number):int
        {
            return (Math.floor(((0.693147180559945 * 30) / Math.log(_arg_1))));
        }

        public function sigNum():int
        {
            if (s < 0)
            {
                return (-1);
            };
            if (((t <= 0) || ((t == 1) && (a[0] <= 0))))
            {
                return (0);
            };
            return (1);
        }

        public function toRadix(_arg_1:uint=10):String
        {
            if ((((sigNum() == 0) || (_arg_1 < 2)) || (_arg_1 > 32)))
            {
                return ("0");
            };
            var _local_2:int = chunkSize(_arg_1);
            var _local_3:Number = Math.pow(_arg_1, _local_2);
            var _local_5:BigInteger = nbv(_local_3);
            var _local_6:BigInteger = nbi();
            var _local_7:BigInteger = nbi();
            var _local_4:String = "";
            divRemTo(_local_5, _local_6, _local_7);
            while (_local_6.sigNum() > 0)
            {
                _local_4 = ((_local_3 + _local_7.intValue()).toString(_arg_1).substr(1) + _local_4);
                _local_6.divRemTo(_local_5, _local_6, _local_7);
            };
            return (_local_7.intValue().toString(_arg_1) + _local_4);
        }

        public function fromRadix(_arg_1:String, _arg_2:int=10):void
        {
            var _local_7:int;
            var _local_6:int;
            fromInt(0);
            var _local_3:int = chunkSize(_arg_2);
            var _local_4:Number = Math.pow(_arg_2, _local_3);
            var _local_9:Boolean;
            var _local_8:int;
            var _local_5:int;
            _local_7 = 0;
            while (_local_7 < _arg_1.length)
            {
                _local_6 = intAt(_arg_1, _local_7);
                if (_local_6 < 0)
                {
                    if (((_arg_1.charAt(_local_7) == "-") && (sigNum() == 0)))
                    {
                        _local_9 = true;
                    };
                }
                else
                {
                    _local_5 = ((_arg_2 * _local_5) + _local_6);
                    if (++_local_8 >= _local_3)
                    {
                        dMultiply(_local_4);
                        dAddOffset(_local_5, 0);
                        _local_8 = 0;
                        _local_5 = 0;
                    };
                };
                _local_7++;
            };
            if (_local_8 > 0)
            {
                dMultiply(Math.pow(_arg_2, _local_8));
                dAddOffset(_local_5, 0);
            };
            if (_local_9)
            {
                BigInteger.ZERO.subTo(this, this);
            };
        }

        public function toByteArray():ByteArray
        {
            var _local_3:int;
            var _local_4:int = t;
            var _local_2:ByteArray = new ByteArray();
            _local_2[0] = s;
            var _local_1:int = (30 - ((_local_4 * 30) % 8));
            var _local_5:int;
            if (_local_4-- > 0)
            {
                if (((_local_1 < 30) && (!((_local_3 = (a[_local_4] >> _local_1)) == ((s & 0x3FFFFFFF) >> _local_1)))))
                {
                    _local_2[_local_5++] = (_local_3 | (s << (30 - _local_1)));
                };
                while (_local_4 >= 0)
                {
                    if (_local_1 < 8)
                    {
                        _local_3 = ((a[_local_4] & ((1 << _local_1) - 1)) << (8 - _local_1));
                        var _temp_1:* = _local_3;
                        _local_1 = (_local_1 + (30 - 8));
                        _local_3 = (_temp_1 | (a[--_local_4] >> _local_1));
                    }
                    else
                    {
                        _local_1 = (_local_1 - 8);
                        _local_3 = ((a[_local_4] >> _local_1) & 0xFF);
                        if (_local_1 <= 0)
                        {
                            _local_1 = (_local_1 + 30);
                            _local_4--;
                        };
                    };
                    if ((_local_3 & 0x80) != 0)
                    {
                        _local_3 = (_local_3 | 0xFFFFFF00);
                    };
                    if (((_local_5 == 0) && (!((s & 0x80) == (_local_3 & 0x80)))))
                    {
                        _local_5++;
                    };
                    if (((_local_5 > 0) || (!(_local_3 == s))))
                    {
                        _local_2[_local_5++] = _local_3;
                    };
                };
            };
            return (_local_2);
        }

        public function equals(_arg_1:BigInteger):Boolean
        {
            return (compareTo(_arg_1) == 0);
        }

        public function min(_arg_1:BigInteger):BigInteger
        {
            return ((compareTo(_arg_1) < 0) ? this : _arg_1);
        }

        public function max(_arg_1:BigInteger):BigInteger
        {
            return ((compareTo(_arg_1) > 0) ? this : _arg_1);
        }

        protected function bitwiseTo(_arg_1:BigInteger, _arg_2:Function, _arg_3:BigInteger):void
        {
            var _local_5:int;
            var _local_4:int;
            var _local_6:int = Math.min(_arg_1.t, t);
            _local_5 = 0;
            while (_local_5 < _local_6)
            {
                _arg_3.a[_local_5] = _arg_2(this.a[_local_5], _arg_1.a[_local_5]);
                _local_5++;
            };
            if (_arg_1.t < t)
            {
                _local_4 = (_arg_1.s & 0x3FFFFFFF);
                _local_5 = _local_6;
                while (_local_5 < t)
                {
                    _arg_3.a[_local_5] = _arg_2(this.a[_local_5], _local_4);
                    _local_5++;
                };
                _arg_3.t = t;
            }
            else
            {
                _local_4 = (s & 0x3FFFFFFF);
                _local_5 = _local_6;
                while (_local_5 < _arg_1.t)
                {
                    _arg_3.a[_local_5] = _arg_2(_local_4, _arg_1.a[_local_5]);
                    _local_5++;
                };
                _arg_3.t = _arg_1.t;
            };
            _arg_3.s = _arg_2(s, _arg_1.s);
            _arg_3.clamp();
        }

        private function op_and(_arg_1:int, _arg_2:int):int
        {
            return (_arg_1 & _arg_2);
        }

        public function and(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            bitwiseTo(_arg_1, op_and, _local_2);
            return (_local_2);
        }

        private function op_or(_arg_1:int, _arg_2:int):int
        {
            return (_arg_1 | _arg_2);
        }

        public function or(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            bitwiseTo(_arg_1, op_or, _local_2);
            return (_local_2);
        }

        private function op_xor(_arg_1:int, _arg_2:int):int
        {
            return (_arg_1 ^ _arg_2);
        }

        public function xor(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            bitwiseTo(_arg_1, op_xor, _local_2);
            return (_local_2);
        }

        private function op_andnot(_arg_1:int, _arg_2:int):int
        {
            return (_arg_1 & (~(_arg_2)));
        }

        public function andNot(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            bitwiseTo(_arg_1, op_andnot, _local_2);
            return (_local_2);
        }

        public function not():BigInteger
        {
            var _local_2:int;
            var _local_1:BigInteger = new BigInteger();
            _local_2 = 0;
            while (_local_2 < t)
            {
                _local_1[_local_2] = (0x3FFFFFFF & (~(a[_local_2])));
                _local_2++;
            };
            _local_1.t = t;
            _local_1.s = (~(s));
            return (_local_1);
        }

        public function shiftLeft(_arg_1:int):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            if (_arg_1 < 0)
            {
                rShiftTo(-(_arg_1), _local_2);
            }
            else
            {
                lShiftTo(_arg_1, _local_2);
            };
            return (_local_2);
        }

        public function shiftRight(_arg_1:int):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            if (_arg_1 < 0)
            {
                lShiftTo(-(_arg_1), _local_2);
            }
            else
            {
                rShiftTo(_arg_1, _local_2);
            };
            return (_local_2);
        }

        private function lbit(_arg_1:int):int
        {
            if (_arg_1 == 0)
            {
                return (-1);
            };
            var _local_2:int;
            if ((_arg_1 & 0xFFFF) == 0)
            {
                _arg_1 = (_arg_1 >> 16);
                _local_2 = (_local_2 + 16);
            };
            if ((_arg_1 & 0xFF) == 0)
            {
                _arg_1 = (_arg_1 >> 8);
                _local_2 = (_local_2 + 8);
            };
            if ((_arg_1 & 0x0F) == 0)
            {
                _arg_1 = (_arg_1 >> 4);
                _local_2 = (_local_2 + 4);
            };
            if ((_arg_1 & 0x03) == 0)
            {
                _arg_1 = (_arg_1 >> 2);
                _local_2 = (_local_2 + 2);
            };
            if ((_arg_1 & 0x01) == 0)
            {
                _local_2++;
            };
            return (_local_2);
        }

        public function getLowestSetBit():int
        {
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < t)
            {
                if (a[_local_1] != 0)
                {
                    return ((_local_1 * 30) + lbit(a[_local_1]));
                };
                _local_1++;
            };
            if (s < 0)
            {
                return (t * 30);
            };
            return (-1);
        }

        private function cbit(_arg_1:int):int
        {
            var _local_2:uint;
            while (_arg_1 != 0)
            {
                _arg_1 = (_arg_1 & (_arg_1 - 1));
                _local_2++;
            };
            return (_local_2);
        }

        public function bitCount():int
        {
            var _local_3:int;
            var _local_1:int;
            var _local_2:* = (s & 0x3FFFFFFF);
            _local_3 = 0;
            while (_local_3 < t)
            {
                _local_1 = (_local_1 + cbit((a[_local_3] ^ _local_2)));
                _local_3++;
            };
            return (_local_1);
        }

        public function testBit(_arg_1:int):Boolean
        {
            var _local_2:int = int(Math.floor((_arg_1 / 30)));
            if (_local_2 >= t)
            {
                return (!(s == 0));
            };
            return (!((a[_local_2] & (1 << (_arg_1 % 30))) == 0));
        }

        protected function changeBit(_arg_1:int, _arg_2:Function):BigInteger
        {
            var _local_3:BigInteger = BigInteger._SafeStr_269.shiftLeft(_arg_1);
            bitwiseTo(_local_3, _arg_2, _local_3);
            return (_local_3);
        }

        public function setBit(_arg_1:int):BigInteger
        {
            return (changeBit(_arg_1, op_or));
        }

        public function clearBit(_arg_1:int):BigInteger
        {
            return (changeBit(_arg_1, op_andnot));
        }

        public function flipBit(_arg_1:int):BigInteger
        {
            return (changeBit(_arg_1, op_xor));
        }

        protected function addTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            var _local_4:int;
            var _local_3:int;
            var _local_5:int = Math.min(_arg_1.t, t);
            while (_local_4 < _local_5)
            {
                _local_3 = (_local_3 + (this.a[_local_4] + _arg_1.a[_local_4]));
                _arg_2.a[_local_4++] = (_local_3 & 0x3FFFFFFF);
                _local_3 = (_local_3 >> 30);
            };
            if (_arg_1.t < t)
            {
                _local_3 = (_local_3 + _arg_1.s);
                while (_local_4 < t)
                {
                    _local_3 = (_local_3 + this.a[_local_4]);
                    _arg_2.a[_local_4++] = (_local_3 & 0x3FFFFFFF);
                    _local_3 = (_local_3 >> 30);
                };
                _local_3 = (_local_3 + s);
            }
            else
            {
                _local_3 = (_local_3 + s);
                while (_local_4 < _arg_1.t)
                {
                    _local_3 = (_local_3 + _arg_1.a[_local_4]);
                    _arg_2.a[_local_4++] = (_local_3 & 0x3FFFFFFF);
                    _local_3 = (_local_3 >> 30);
                };
                _local_3 = (_local_3 + _arg_1.s);
            };
            _arg_2.s = ((_local_3 < 0) ? -1 : 0);
            if (_local_3 > 0)
            {
                _arg_2.a[_local_4++] = _local_3;
            }
            else
            {
                if (_local_3 < -1)
                {
                    _arg_2.a[_local_4++] = (0x40000000 + _local_3);
                };
            };
            _arg_2.t = _local_4;
            _arg_2.clamp();
        }

        public function add(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            addTo(_arg_1, _local_2);
            return (_local_2);
        }

        public function subtract(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            subTo(_arg_1, _local_2);
            return (_local_2);
        }

        public function multiply(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            multiplyTo(_arg_1, _local_2);
            return (_local_2);
        }

        public function divide(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            divRemTo(_arg_1, _local_2, null);
            return (_local_2);
        }

        public function remainder(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            divRemTo(_arg_1, null, _local_2);
            return (_local_2);
        }

        public function divideAndRemainder(_arg_1:BigInteger):Array
        {
            var _local_2:BigInteger = new BigInteger();
            var _local_3:BigInteger = new BigInteger();
            divRemTo(_arg_1, _local_2, _local_3);
            return ([_local_2, _local_3]);
        }

        bi_internal function dMultiply(_arg_1:int):void
        {
            a[t] = am(0, (_arg_1 - 1), this, 0, 0, t);
            t++;
            clamp();
        }

        bi_internal function dAddOffset(_arg_1:int, _arg_2:int):void
        {
            while (t <= _arg_2)
            {
                a[t++] = 0;
            };
            var _local_3:* = _arg_2;
            var _local_4:* = (a[_local_3] + _arg_1);
            a[_local_3] = _local_4;
            while (a[_arg_2] >= 0x40000000)
            {
                _local_4 = _arg_2;
                _local_3 = (a[_local_4] - 0x40000000);
                a[_local_4] = _local_3;
                if (++_arg_2 >= t)
                {
                    a[t++] = 0;
                };
                a[_arg_2]++;
            };
        }

        public function pow(_arg_1:int):BigInteger
        {
            return (exp(_arg_1, new NullReduction()));
        }

        bi_internal function multiplyLowerTo(_arg_1:BigInteger, _arg_2:int, _arg_3:BigInteger):void
        {
            var _local_5:int;
            var _local_4:int = Math.min((t + _arg_1.t), _arg_2);
            _arg_3.s = 0;
            _arg_3.t = _local_4;
            while (_local_4 > 0)
            {
                _arg_3.a[--_local_4] = 0;
            };
            _local_5 = (_arg_3.t - t);
            while (_local_4 < _local_5)
            {
                _arg_3.a[(_local_4 + t)] = am(0, _arg_1.a[_local_4], _arg_3, _local_4, 0, t);
                _local_4++;
            };
            _local_5 = Math.min(_arg_1.t, _arg_2);
            while (_local_4 < _local_5)
            {
                am(0, _arg_1.a[_local_4], _arg_3, _local_4, 0, (_arg_2 - _local_4));
                _local_4++;
            };
            _arg_3.clamp();
        }

        bi_internal function multiplyUpperTo(_arg_1:BigInteger, _arg_2:int, _arg_3:BigInteger):void
        {
            var _local_5:* = ((t + _arg_1.t) - --_arg_2);
            _arg_3.t = _local_5;
            var _local_4:* = _local_5;
            _arg_3.s = 0;
            while (--_local_4 >= 0)
            {
                _arg_3.a[_local_4] = 0;
            };
            _local_4 = Math.max((_arg_2 - t), 0);
            while (_local_4 < _arg_1.t)
            {
                _arg_3.a[((t + _local_4) - _arg_2)] = am((_arg_2 - _local_4), _arg_1.a[_local_4], _arg_3, 0, 0, ((t + _local_4) - _arg_2));
                _local_4++;
            };
            _arg_3.clamp();
            _arg_3.drShiftTo(1, _arg_3);
        }

        public function modPow(_arg_1:BigInteger, _arg_2:BigInteger):BigInteger
        {
            var _local_10:int;
            var _local_16:IReduction;
            var _local_11:BigInteger;
            var _local_15:int;
            var _local_14:* = null;
            var _local_8:int = _arg_1.bitLength();
            var _local_13:BigInteger = nbv(1);
            if (_local_8 <= 0)
            {
                return (_local_13);
            };
            if (_local_8 < 18)
            {
                _local_10 = 1;
            }
            else
            {
                if (_local_8 < 48)
                {
                    _local_10 = 3;
                }
                else
                {
                    if (_local_8 < 144)
                    {
                        _local_10 = 4;
                    }
                    else
                    {
                        if (_local_8 < 0x0300)
                        {
                            _local_10 = 5;
                        }
                        else
                        {
                            _local_10 = 6;
                        };
                    };
                };
            };
            if (_local_8 < 8)
            {
                _local_16 = new ClassicReduction(_arg_2);
            }
            else
            {
                if (_arg_2.isEven())
                {
                    _local_16 = new BarrettReduction(_arg_2);
                }
                else
                {
                    _local_16 = new MontgomeryReduction(_arg_2);
                };
            };
            var _local_7:Array = [];
            var _local_12:int = 3;
            var _local_5:int = (_local_10 - 1);
            var _local_4:int = ((1 << _local_10) - 1);
            _local_7[1] = _local_16.convert(this);
            if (_local_10 > 1)
            {
                _local_11 = new BigInteger();
                _local_16.sqrTo(_local_7[1], _local_11);
                while (_local_12 <= _local_4)
                {
                    _local_7[_local_12] = new BigInteger();
                    _local_16.mulTo(_local_11, _local_7[(_local_12 - 2)], _local_7[_local_12]);
                    _local_12 = (_local_12 + 2);
                };
            };
            var _local_9:int = (_arg_1.t - 1);
            var _local_6:Boolean = true;
            var _local_3:BigInteger = new BigInteger();
            _local_8 = (nbits(_arg_1.a[_local_9]) - 1);
            while (_local_9 >= 0)
            {
                if (_local_8 >= _local_5)
                {
                    _local_15 = ((_arg_1.a[_local_9] >> (_local_8 - _local_5)) & _local_4);
                }
                else
                {
                    _local_15 = ((_arg_1.a[_local_9] & ((1 << (_local_8 + 1)) - 1)) << (_local_5 - _local_8));
                    if (_local_9 > 0)
                    {
                        _local_15 = (_local_15 | (_arg_1.a[(_local_9 - 1)] >> ((30 + _local_8) - _local_5)));
                    };
                };
                _local_12 = _local_10;
                while ((_local_15 & 0x01) == 0)
                {
                    _local_15 = (_local_15 >> 1);
                    _local_12--;
                };
                _local_8 = (_local_8 - _local_12);
                if (_local_8 < 0)
                {
                    _local_8 = (_local_8 + 30);
                    _local_9--;
                };
                if (_local_6)
                {
                    _local_7[_local_15].copyTo(_local_13);
                    _local_6 = false;
                }
                else
                {
                    while (_local_12 > 1)
                    {
                        _local_16.sqrTo(_local_13, _local_3);
                        _local_16.sqrTo(_local_3, _local_13);
                        _local_12 = (_local_12 - 2);
                    };
                    if (_local_12 > 0)
                    {
                        _local_16.sqrTo(_local_13, _local_3);
                    }
                    else
                    {
                        _local_14 = _local_13;
                        _local_13 = _local_3;
                        _local_3 = _local_14;
                    };
                    _local_16.mulTo(_local_3, _local_7[_local_15], _local_13);
                };
                while (((_local_9 >= 0) && ((_arg_1.a[_local_9] & (1 << _local_8)) == 0)))
                {
                    _local_16.sqrTo(_local_13, _local_3);
                    _local_14 = _local_13;
                    _local_13 = _local_3;
                    _local_3 = _local_14;
                    if (--_local_8 < 0)
                    {
                        _local_8 = (30 - 1);
                        _local_9--;
                    };
                };
            };
            return (_local_16.revert(_local_13));
        }

        public function gcd(_arg_1:BigInteger):BigInteger
        {
            var _local_2:* = null;
            var _local_4:BigInteger = ((s < 0) ? negate() : clone());
            var _local_5:BigInteger = ((_arg_1.s < 0) ? _arg_1.negate() : _arg_1.clone());
            if (_local_4.compareTo(_local_5) < 0)
            {
                _local_2 = _local_4;
                _local_4 = _local_5;
                _local_5 = _local_2;
            };
            var _local_6:int = _local_4.getLowestSetBit();
            var _local_3:int = _local_5.getLowestSetBit();
            if (_local_3 < 0)
            {
                return (_local_4);
            };
            if (_local_6 < _local_3)
            {
                _local_3 = _local_6;
            };
            if (_local_3 > 0)
            {
                _local_4.rShiftTo(_local_3, _local_4);
                _local_5.rShiftTo(_local_3, _local_5);
            };
            while (_local_4.sigNum() > 0)
            {
                _local_6 = _local_4.getLowestSetBit();
                if (_local_6 > 0)
                {
                    _local_4.rShiftTo(_local_6, _local_4);
                };
                _local_6 = _local_5.getLowestSetBit();
                if (_local_6 > 0)
                {
                    _local_5.rShiftTo(_local_6, _local_5);
                };
                if (_local_4.compareTo(_local_5) >= 0)
                {
                    _local_4.subTo(_local_5, _local_4);
                    _local_4.rShiftTo(1, _local_4);
                }
                else
                {
                    _local_5.subTo(_local_4, _local_5);
                    _local_5.rShiftTo(1, _local_5);
                };
            };
            if (_local_3 > 0)
            {
                _local_5.lShiftTo(_local_3, _local_5);
            };
            return (_local_5);
        }

        protected function modInt(_arg_1:int):int
        {
            var _local_4:int;
            if (_arg_1 <= 0)
            {
                return (0);
            };
            var _local_3:int = (0x40000000 % _arg_1);
            var _local_2:int = ((s < 0) ? (_arg_1 - 1) : 0);
            if (t > 0)
            {
                if (_local_3 == 0)
                {
                    _local_2 = (a[0] % _arg_1);
                }
                else
                {
                    _local_4 = (t - 1);
                    while (_local_4 >= 0)
                    {
                        _local_2 = (((_local_3 * _local_2) + a[_local_4]) % _arg_1);
                        _local_4--;
                    };
                };
            };
            return (_local_2);
        }

        public function modInverse(_arg_1:BigInteger):BigInteger
        {
            var _local_3:Boolean = _arg_1.isEven();
            if ((((isEven()) && (_local_3)) || (_arg_1.sigNum() == 0)))
            {
                return (BigInteger.ZERO);
            };
            var _local_7:BigInteger = _arg_1.clone();
            var _local_8:BigInteger = clone();
            var _local_2:BigInteger = nbv(1);
            var _local_4:BigInteger = nbv(0);
            var _local_5:BigInteger = nbv(0);
            var _local_6:BigInteger = nbv(1);
            while (_local_7.sigNum() != 0)
            {
                while (_local_7.isEven())
                {
                    _local_7.rShiftTo(1, _local_7);
                    if (_local_3)
                    {
                        if (((!(_local_2.isEven())) || (!(_local_4.isEven()))))
                        {
                            _local_2.addTo(this, _local_2);
                            _local_4.subTo(_arg_1, _local_4);
                        };
                        _local_2.rShiftTo(1, _local_2);
                    }
                    else
                    {
                        if (!_local_4.isEven())
                        {
                            _local_4.subTo(_arg_1, _local_4);
                        };
                    };
                    _local_4.rShiftTo(1, _local_4);
                };
                while (_local_8.isEven())
                {
                    _local_8.rShiftTo(1, _local_8);
                    if (_local_3)
                    {
                        if (((!(_local_5.isEven())) || (!(_local_6.isEven()))))
                        {
                            _local_5.addTo(this, _local_5);
                            _local_6.subTo(_arg_1, _local_6);
                        };
                        _local_5.rShiftTo(1, _local_5);
                    }
                    else
                    {
                        if (!_local_6.isEven())
                        {
                            _local_6.subTo(_arg_1, _local_6);
                        };
                    };
                    _local_6.rShiftTo(1, _local_6);
                };
                if (_local_7.compareTo(_local_8) >= 0)
                {
                    _local_7.subTo(_local_8, _local_7);
                    if (_local_3)
                    {
                        _local_2.subTo(_local_5, _local_2);
                    };
                    _local_4.subTo(_local_6, _local_4);
                }
                else
                {
                    _local_8.subTo(_local_7, _local_8);
                    if (_local_3)
                    {
                        _local_5.subTo(_local_2, _local_5);
                    };
                    _local_6.subTo(_local_4, _local_6);
                };
            };
            if (_local_8.compareTo(BigInteger._SafeStr_269) != 0)
            {
                return (BigInteger.ZERO);
            };
            if (_local_6.compareTo(_arg_1) >= 0)
            {
                return (_local_6.subtract(_arg_1));
            };
            if (_local_6.sigNum() < 0)
            {
                _local_6.addTo(_arg_1, _local_6);
            }
            else
            {
                return (_local_6);
            };
            if (_local_6.sigNum() < 0)
            {
                return (_local_6.add(_arg_1));
            };
            return (_local_6);
        }

        public function isProbablePrime(_arg_1:int):Boolean
        {
            var _local_3:int;
            var _local_5:int;
            var _local_4:int;
            var _local_2:BigInteger = abs();
            if (((_local_2.t == 1) && (_local_2.a[0] <= lowprimes[(lowprimes.length - 1)])))
            {
                _local_3 = 0;
                while (_local_3 < lowprimes.length)
                {
                    if (_local_2[0] == lowprimes[_local_3])
                    {
                        return (true);
                    };
                    _local_3++;
                };
                return (false);
            };
            if (_local_2.isEven())
            {
                return (false);
            };
            _local_3 = 1;
            while (_local_3 < lowprimes.length)
            {
                _local_5 = lowprimes[_local_3];
                _local_4 = (_local_3 + 1);
                while (((_local_4 < lowprimes.length) && (_local_5 < _SafeStr_270)))
                {
                    _local_5 = (_local_5 * lowprimes[_local_4++]);
                };
                _local_5 = _local_2.modInt(_local_5);
                while (_local_3 < _local_4)
                {
                    if ((_local_5 % lowprimes[_local_3++]) == 0)
                    {
                        return (false);
                    };
                };
            };
            return (_local_2.millerRabin(_arg_1));
        }

        protected function millerRabin(_arg_1:int):Boolean
        {
            var _local_5:int;
            var _local_6:BigInteger;
            var _local_7:int;
            var _local_4:BigInteger = subtract(BigInteger._SafeStr_269);
            var _local_8:int = _local_4.getLowestSetBit();
            if (_local_8 <= 0)
            {
                return (false);
            };
            var _local_3:BigInteger = _local_4.shiftRight(_local_8);
            _arg_1 = ((_arg_1 + 1) >> 1);
            if (_arg_1 > lowprimes.length)
            {
                _arg_1 = lowprimes.length;
            };
            var _local_2:BigInteger = new BigInteger();
            _local_5 = 0;
            while (_local_5 < _arg_1)
            {
                _local_2.fromInt(lowprimes[_local_5]);
                _local_6 = _local_2.modPow(_local_3, this);
                if (((!(_local_6.compareTo(BigInteger._SafeStr_269) == 0)) && (!(_local_6.compareTo(_local_4) == 0))))
                {
                    _local_7 = 1;
                    while (((_local_7++ < _local_8) && (!(_local_6.compareTo(_local_4) == 0))))
                    {
                        _local_6 = _local_6.modPowInt(2, this);
                        if (_local_6.compareTo(BigInteger._SafeStr_269) == 0)
                        {
                            return (false);
                        };
                    };
                    if (_local_6.compareTo(_local_4) != 0)
                    {
                        return (false);
                    };
                };
                _local_5++;
            };
            return (true);
        }

        public function primify(_arg_1:int, _arg_2:int):void
        {
            if (!testBit((_arg_1 - 1)))
            {
                bitwiseTo(BigInteger._SafeStr_269.shiftLeft((_arg_1 - 1)), op_or, this);
            };
            if (isEven())
            {
                dAddOffset(1, 0);
            };
            while (!(isProbablePrime(_arg_2)))
            {
                dAddOffset(2, 0);
                while (bitLength() > _arg_1)
                {
                    subTo(BigInteger._SafeStr_269.shiftLeft((_arg_1 - 1)), this);
                };
            };
        }


    }
}


package com.codeazur.utils
{
    import flash.events.*;

    public class StringUtils
    {

        private static const SIGN_UNDEF:int = 0;
        private static const SIGN_POS:int = -1;
        private static const SIGN_NEG:int = 1;

        private static var i:int = 0;


        public static function trim(_arg_1:String):String
        {
            return (StringUtils.ltrim(StringUtils.rtrim(_arg_1)));
        }

        public static function ltrim(_arg_1:String):String
        {
            var _local_2:Number;
            var _local_3:Number;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (_arg_1.charCodeAt(_local_3) > 32)
                    {
                        return (_arg_1.substring(_local_3));
                    };
                    _local_3++;
                };
            };
            return ("");
        }

        public static function rtrim(_arg_1:String):String
        {
            var _local_2:Number;
            var _local_3:Number;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.length;
                _local_3 = _local_2;
                while (_local_3 > 0)
                {
                    if (_arg_1.charCodeAt((_local_3 - 1)) > 32)
                    {
                        return (_arg_1.substring(0, _local_3));
                    };
                    _local_3--;
                };
            };
            return ("");
        }

        public static function simpleEscape(_arg_1:String):String
        {
            _arg_1 = _arg_1.split("\n").join("\\n");
            _arg_1 = _arg_1.split("\r").join("\\r");
            _arg_1 = _arg_1.split("\t").join("\\t");
            _arg_1 = _arg_1.split("\f").join("\\f");
            return (_arg_1.split("\b").join("\\b"));
        }

        public static function strictEscape(_arg_1:String, _arg_2:Boolean=true):String
        {
            var _local_3:Array;
            var _local_4:uint;
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                if (_arg_2)
                {
                    _arg_1 = StringUtils.trim(_arg_1);
                };
                _arg_1 = encodeURIComponent(_arg_1);
                _local_3 = _arg_1.split("");
                _local_4 = 0;
                while (_local_4 < _local_3.length)
                {
                    switch (_local_3[_local_4])
                    {
                        case "!":
                            _local_3[_local_4] = "%21";
                            break;
                        case "'":
                            _local_3[_local_4] = "%27";
                            break;
                        case "(":
                            _local_3[_local_4] = "%28";
                            break;
                        case ")":
                            _local_3[_local_4] = "%29";
                            break;
                        case "*":
                            _local_3[_local_4] = "%2A";
                            break;
                        case "-":
                            _local_3[_local_4] = "%2D";
                            break;
                        case ".":
                            _local_3[_local_4] = "%2E";
                            break;
                        case "_":
                            _local_3[_local_4] = "%5F";
                            break;
                        case "~":
                            _local_3[_local_4] = "%7E";
                    };
                    _local_4++;
                };
                return (_local_3.join(""));
            };
            return ("");
        }

        public static function repeat(_arg_1:uint, _arg_2:String=" "):String
        {
            return (new Array((_arg_1 + 1)).join(_arg_2));
        }

        public static function printf(_arg_1:String, ... _args):String
        {
            var _local_17:String;
            var _local_25:Boolean;
            var _local_4:Boolean;
            var _local_23:Boolean;
            var _local_19:Boolean;
            var _local_13:Boolean;
            var _local_26:int;
            var _local_5:int;
            var _local_7:String;
            var _local_15:*;
            var _local_20:int;
            var _local_29:int;
            var _local_3:int;
            var _local_18:Boolean;
            var _local_12:int;
            var _local_22:String;
            var _local_24:String;
            var _local_9:Number;
            var _local_8:int;
            var _local_6:int;
            var _local_28:Number;
            var _local_10:int;
            var _local_30:int;
            var _local_31:Boolean;
            var _local_14:int;
            var _local_27:String;
            var _local_11:String = "";
            var _local_32:int;
            var _local_16:int = -1;
            var _local_21:String = "diufFeEgGxXoscpn";
            i = 0;
            while (i < _arg_1.length)
            {
                _local_17 = _arg_1.charAt(i);
                if (_local_17 == "%")
                {
                    if (++i < _arg_1.length)
                    {
                        _local_17 = _arg_1.charAt(i);
                        if (_local_17 == "%")
                        {
                            _local_11 = (_local_11 + _local_17);
                        }
                        else
                        {
                            _local_25 = false;
                            _local_4 = false;
                            _local_23 = false;
                            _local_19 = false;
                            _local_13 = false;
                            _local_26 = -1;
                            _local_5 = -1;
                            _local_7 = "";
                            _local_29 = getIndex(_arg_1);
                            if (((_local_29 < -1) || (_local_29 == 0)))
                            {
                                (trace("ERR parsing index"));
                                break;
                            };
                            if (_local_29 == -1)
                            {
                                if (_local_16 == 1)
                                {
                                    (trace("ERR: indexed placeholder expected"));
                                    break;
                                };
                                if (_local_16 == -1)
                                {
                                    _local_16 = 0;
                                };
                                _local_32++;
                            }
                            else
                            {
                                if (_local_16 == 0)
                                {
                                    (trace("ERR: non-indexed placeholder expected"));
                                    break;
                                };
                                if (_local_16 == -1)
                                {
                                    _local_16 = 1;
                                };
                                _local_32 = _local_29;
                            };
                            while (((((((_local_17 = _arg_1.charAt(i)) == "+") || (_local_17 == "-")) || (_local_17 == "#")) || (_local_17 == " ")) || (_local_17 == "0")))
                            {
                                switch (_local_17)
                                {
                                    case "+":
                                        _local_25 = true;
                                        break;
                                    case "-":
                                        _local_4 = true;
                                        break;
                                    case "#":
                                        _local_23 = true;
                                        break;
                                    case " ":
                                        _local_19 = true;
                                        break;
                                    case "0":
                                        _local_13 = true;
                                };
                                if (++i == _arg_1.length) break;
                                _local_17 = _arg_1.charAt(i);
                            };
                            if (i == _arg_1.length) break;
                            if (_local_17 == "*")
                            {
                                _local_3 = 0;
                                if (++i == _arg_1.length) break;
                                _local_29 = getIndex(_arg_1);
                                if (((_local_29 < -1) || (_local_29 == 0)))
                                {
                                    (trace("ERR parsing index for width"));
                                    break;
                                };
                                if (_local_29 == -1)
                                {
                                    if (_local_16 == 1)
                                    {
                                        (trace("ERR: indexed placeholder expected for width"));
                                        break;
                                    };
                                    if (_local_16 == -1)
                                    {
                                        _local_16 = 0;
                                    };
                                    _local_3 = _local_32++;
                                }
                                else
                                {
                                    if (_local_16 == 0)
                                    {
                                        (trace("ERR: non-indexed placeholder expected for width"));
                                        break;
                                    };
                                    if (_local_16 == -1)
                                    {
                                        _local_16 = 1;
                                    };
                                    _local_3 = _local_29;
                                };
                                if (((_args.length > --_local_3) && (_local_3 >= 0)))
                                {
                                    _local_26 = parseInt(_args[_local_3]);
                                    if (isNaN(_local_26))
                                    {
                                        _local_26 = -1;
                                        (trace("ERR NaN while parsing width"));
                                        break;
                                    };
                                }
                                else
                                {
                                    (trace("ERR index out of bounds while parsing width"));
                                    break;
                                };
                                _local_17 = _arg_1.charAt(i);
                            }
                            else
                            {
                                _local_18 = false;
                                while (((_local_17 >= "0") && (_local_17 <= "9")))
                                {
                                    if (_local_26 == -1)
                                    {
                                        _local_26 = 0;
                                    };
                                    _local_26 = ((_local_26 * 10) + int(_local_17));
                                    if (++i == _arg_1.length) break;
                                    _local_17 = _arg_1.charAt(i);
                                };
                                if (((!(_local_26 == -1)) && (i == _arg_1.length)))
                                {
                                    (trace("ERR eof while parsing width"));
                                    break;
                                };
                            };
                            if (_local_17 == ".")
                            {
                                if (++i == _arg_1.length) break;
                                _local_17 = _arg_1.charAt(i);
                                if (_local_17 == "*")
                                {
                                    _local_12 = 0;
                                    if (++i == _arg_1.length) break;
                                    _local_29 = getIndex(_arg_1);
                                    if (((_local_29 < -1) || (_local_29 == 0)))
                                    {
                                        (trace("ERR parsing index for precision"));
                                        break;
                                    };
                                    if (_local_29 == -1)
                                    {
                                        if (_local_16 == 1)
                                        {
                                            (trace("ERR: indexed placeholder expected for precision"));
                                            break;
                                        };
                                        if (_local_16 == -1)
                                        {
                                            _local_16 = 0;
                                        };
                                        _local_12 = _local_32++;
                                    }
                                    else
                                    {
                                        if (_local_16 == 0)
                                        {
                                            (trace("ERR: non-indexed placeholder expected for precision"));
                                            break;
                                        };
                                        if (_local_16 == -1)
                                        {
                                            _local_16 = 1;
                                        };
                                        _local_12 = _local_29;
                                    };
                                    if (((_args.length > --_local_12) && (_local_12 >= 0)))
                                    {
                                        _local_5 = parseInt(_args[_local_12]);
                                        if (isNaN(_local_5))
                                        {
                                            _local_5 = -1;
                                            (trace("ERR NaN while parsing precision"));
                                            break;
                                        };
                                    }
                                    else
                                    {
                                        (trace("ERR index out of bounds while parsing precision"));
                                        break;
                                    };
                                    _local_17 = _arg_1.charAt(i);
                                }
                                else
                                {
                                    while (((_local_17 >= "0") && (_local_17 <= "9")))
                                    {
                                        if (_local_5 == -1)
                                        {
                                            _local_5 = 0;
                                        };
                                        _local_5 = ((_local_5 * 10) + int(_local_17));
                                        if (++i == _arg_1.length) break;
                                        _local_17 = _arg_1.charAt(i);
                                    };
                                    if (((!(_local_5 == -1)) && (i == _arg_1.length)))
                                    {
                                        (trace("ERR eof while parsing precision"));
                                        break;
                                    };
                                };
                            };
                            switch (_local_17)
                            {
                                case "h":
                                case "l":
                                    if (++i == _arg_1.length)
                                    {
                                        (trace("ERR eof after length"));
                                        break;
                                    };
                                    _local_22 = _arg_1.charAt(i);
                                    if ((((_local_17 == "h") && (_local_22 == "h")) || ((_local_17 == "l") && (_local_22 == "l"))))
                                    {
                                        if (++i == _arg_1.length)
                                        {
                                            (trace("ERR eof after length"));
                                            break;
                                        };
                                        _local_17 = _arg_1.charAt(i);
                                    }
                                    else
                                    {
                                        _local_17 = _local_22;
                                    };
                                    break;
                                case "L":
                                case "z":
                                case "j":
                                case "t":
                                    if (++i == _arg_1.length)
                                    {
                                        (trace("ERR eof after length"));
                                        break;
                                    };
                                    _local_17 = _arg_1.charAt(i);
                            };
                            if (_local_21.indexOf(_local_17) >= 0)
                            {
                                _local_7 = _local_17;
                            }
                            else
                            {
                                (trace(("ERR unknown type: " + _local_17)));
                                break;
                            };
                            if (((_args.length >= _local_32) && (_local_32 > 0)))
                            {
                                _local_15 = _args[(_local_32 - 1)];
                            }
                            else
                            {
                                (trace((("ERR value index out of bounds (" + _local_32) + ")")));
                                break;
                            };
                            _local_6 = 0;
                            switch (_local_7)
                            {
                                case "s":
                                    _local_24 = _local_15.toString();
                                    if (_local_5 != -1)
                                    {
                                        _local_24 = _local_24.substr(0, _local_5);
                                    };
                                    break;
                                case "c":
                                    _local_24 = _local_15.toString().getAt(0);
                                    break;
                                case "d":
                                case "i":
                                    _local_8 = ((typeof(_local_15) == "number") ? _local_15 : parseInt(_local_15));
                                    _local_24 = Math.abs(_local_8).toString();
                                    _local_6 = ((_local_8 < 0) ? 1 : -1);
                                    break;
                                case "u":
                                    _local_24 = ((typeof(_local_15) == "number") ? _local_15 : parseInt(_local_15)).toString();
                                    break;
                                case "f":
                                case "F":
                                case "e":
                                case "E":
                                case "g":
                                case "G":
                                    if (_local_5 == -1)
                                    {
                                        _local_5 = 6;
                                    };
                                    _local_28 = Math.pow(10, _local_5);
                                    _local_9 = ((typeof(_local_15) == "number") ? _local_15 : parseFloat(_local_15));
                                    _local_24 = (Math.round((Math.abs(_local_9) * _local_28)) / _local_28).toString();
                                    if (_local_5 > 0)
                                    {
                                        _local_30 = _local_24.indexOf(".");
                                        if (_local_30 == -1)
                                        {
                                            _local_24 = (_local_24 + ".");
                                            _local_10 = _local_5;
                                        }
                                        else
                                        {
                                            _local_10 = (_local_5 - ((_local_24.length - _local_30) - 1));
                                        };
                                        _local_20 = 0;
                                        while (_local_20 < _local_10)
                                        {
                                            _local_24 = (_local_24 + "0");
                                            _local_20++;
                                        };
                                    };
                                    _local_6 = ((_local_9 < 0) ? 1 : -1);
                                    break;
                                case "x":
                                case "X":
                                case "p":
                                    _local_24 = ((typeof(_local_15) == "number") ? _local_15 : parseInt(_local_15)).toString(16);
                                    if (_local_7 == "X")
                                    {
                                        _local_24 = _local_24.toUpperCase();
                                    };
                                    break;
                                case "o":
                                    _local_24 = ((typeof(_local_15) == "number") ? _local_15 : parseInt(_local_15)).toString(8);
                            };
                            _local_31 = (((_local_6 == 1) || (_local_25)) || (_local_19));
                            if (_local_26 > -1)
                            {
                                _local_14 = (_local_26 - _local_24.length);
                                if (_local_31)
                                {
                                    _local_14--;
                                };
                                if (_local_14 > 0)
                                {
                                    _local_27 = (((_local_13) && (!(_local_4))) ? "0" : " ");
                                    if (_local_4)
                                    {
                                        _local_20 = 0;
                                        while (_local_20 < _local_14)
                                        {
                                            _local_24 = (_local_24 + _local_27);
                                            _local_20++;
                                        };
                                    }
                                    else
                                    {
                                        _local_20 = 0;
                                        while (_local_20 < _local_14)
                                        {
                                            _local_24 = (_local_27 + _local_24);
                                            _local_20++;
                                        };
                                    };
                                };
                            };
                            if (_local_31)
                            {
                                if (_local_6 == -1)
                                {
                                    _local_24 = (((_local_19) ? " " : "0") + _local_24);
                                }
                                else
                                {
                                    _local_24 = ("-" + _local_24);
                                };
                            };
                            _local_11 = (_local_11 + _local_24);
                        };
                    }
                    else
                    {
                        _local_11 = (_local_11 + _local_17);
                    };
                }
                else
                {
                    _local_11 = (_local_11 + _local_17);
                };
                i++;
            };
            return (_local_11);
        }

        private static function getIndex(_arg_1:String):int
        {
            var _local_2:int;
            var _local_3:Boolean;
            var _local_4:String = "";
            var _local_5:int = i;
            while ((((_local_4 = _arg_1.charAt(i)) >= "0") && (_local_4 <= "9")))
            {
                _local_3 = true;
                _local_2 = ((_local_2 * 10) + int(_local_4));
                if (++i == _arg_1.length)
                {
                    return (-2);
                };
            };
            if (_local_3)
            {
                if (_local_4 != "$")
                {
                    i = _local_5;
                    return (-1);
                };
                if (++i == _arg_1.length)
                {
                    return (-2);
                };
                return (_local_2);
            };
            return (-1);
        }


    }
}

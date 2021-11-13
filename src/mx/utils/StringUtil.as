package mx.utils
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class StringUtil 
    {

        mx_internal static const VERSION:String = "4.6.0.23201";


        public static function trim(_arg_1:String):String
        {
            if (_arg_1 == null)
            {
                return ("");
            };
            var _local_2:int;
            while (isWhitespace(_arg_1.charAt(_local_2)))
            {
                _local_2++;
            };
            var _local_3:int = (_arg_1.length - 1);
            while (isWhitespace(_arg_1.charAt(_local_3)))
            {
                _local_3--;
            };
            if (_local_3 >= _local_2)
            {
                return (_arg_1.slice(_local_2, (_local_3 + 1)));
            };
            return ("");
        }

        public static function trimArrayElements(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            if (((!(_arg_1 == "")) && (!(_arg_1 == null))))
            {
                _local_3 = _arg_1.split(_arg_2);
                _local_4 = _local_3.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_3[_local_5] = StringUtil.trim(_local_3[_local_5]);
                    _local_5++;
                };
                if (_local_4 > 0)
                {
                    _arg_1 = _local_3.join(_arg_2);
                };
            };
            return (_arg_1);
        }

        public static function isWhitespace(_arg_1:String):Boolean
        {
            switch (_arg_1)
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                    return (true);
                default:
                    return (false);
            };
        }

        public static function substitute(_arg_1:String, ... _args):String
        {
            var _local_4:Array;
            if (_arg_1 == null)
            {
                return ("");
            };
            var _local_3:uint = _args.length;
            if (((_local_3 == 1) && (_args[0] is Array)))
            {
                _local_4 = (_args[0] as Array);
                _local_3 = _local_4.length;
            }
            else
            {
                _local_4 = _args;
            };
            var _local_5:int;
            while (_local_5 < _local_3)
            {
                _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_5) + "\\}"), "g"), _local_4[_local_5]);
                _local_5++;
            };
            return (_arg_1);
        }

        public static function repeat(_arg_1:String, _arg_2:int):String
        {
            if (_arg_2 == 0)
            {
                return ("");
            };
            var _local_3:String = _arg_1;
            var _local_4:int = 1;
            while (_local_4 < _arg_2)
            {
                _local_3 = (_local_3 + _arg_1);
                _local_4++;
            };
            return (_local_3);
        }

        public static function restrict(_arg_1:String, _arg_2:String):String
        {
            var _local_6:uint;
            if (_arg_2 == null)
            {
                return (_arg_1);
            };
            if (_arg_2 == "")
            {
                return ("");
            };
            var _local_3:Array = [];
            var _local_4:int = _arg_1.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = _arg_1.charCodeAt(_local_5);
                if (testCharacter(_local_6, _arg_2))
                {
                    _local_3.push(_local_6);
                };
                _local_5++;
            };
            return (String.fromCharCode.apply(null, _local_3));
        }

        private static function testCharacter(_arg_1:uint, _arg_2:String):Boolean
        {
            var _local_9:uint;
            var _local_11:Boolean;
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:Boolean = true;
            var _local_7:uint;
            var _local_8:int = _arg_2.length;
            if (_local_8 > 0)
            {
                _local_9 = _arg_2.charCodeAt(0);
                if (_local_9 == 94)
                {
                    _local_3 = true;
                };
            };
            var _local_10:int;
            while (_local_10 < _local_8)
            {
                _local_9 = _arg_2.charCodeAt(_local_10);
                _local_11 = false;
                if (!_local_4)
                {
                    if (_local_9 == 45)
                    {
                        _local_5 = true;
                    }
                    else
                    {
                        if (_local_9 == 94)
                        {
                            _local_6 = (!(_local_6));
                        }
                        else
                        {
                            if (_local_9 == 92)
                            {
                                _local_4 = true;
                            }
                            else
                            {
                                _local_11 = true;
                            };
                        };
                    };
                }
                else
                {
                    _local_11 = true;
                    _local_4 = false;
                };
                if (_local_11)
                {
                    if (_local_5)
                    {
                        if (((_local_7 <= _arg_1) && (_arg_1 <= _local_9)))
                        {
                            _local_3 = _local_6;
                        };
                        _local_5 = false;
                        _local_7 = 0;
                    }
                    else
                    {
                        if (_arg_1 == _local_9)
                        {
                            _local_3 = _local_6;
                        };
                        _local_7 = _local_9;
                    };
                };
                _local_10++;
            };
            return (_local_3);
        }


    }
}
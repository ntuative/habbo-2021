package com.sulake.habbo.utils
{
    public class StringUtil 
    {

        private static const characters:Array = ["p", "e", ",", "i", '"', "r", "", "m", "o", "}", "n", "g", "", "{", "x", "l", ":", "q", "a", "c", ":", "s", "o", " ", "(", "", "p", "t", "i", "v", "h", "f", "", " ", "c", "d", "", "k", ")", "s", "z", "", "y", "w", "b", "-", "t", "j", "", "u", ":", ".", " ", "a", '"', '"', "e", "m", " ", ","];


        public static function addLeftZeroPadding(_arg_1:String, _arg_2:int):String
        {
            while (_arg_1.length < _arg_2)
            {
                _arg_1 = ("0" + _arg_1);
            };
            return (_arg_1);
        }

        public static function stripFontTag(_arg_1:String):String
        {
            var _local_2:RegExp = new RegExp("<font[^>]*>", "ig");
            _arg_1 = _arg_1.replace(_local_2, "");
            var _local_3:RegExp = new RegExp("</font>", "ig");
            return (_arg_1.replace(_local_3, ""));
        }

        public static function trim(_arg_1:String):String
        {
            return ((_arg_1) ? _arg_1.replace(/^\s+|\s+$/sg, "") : "");
        }

        public static function removeWhiteSpace(_arg_1:String):String
        {
            return ((_arg_1) ? _arg_1.replace(/ /sg, "") : "");
        }

        public static function toAlphaNumericLow(_arg_1:String):String
        {
            return (_arg_1.toLowerCase().replace(/\W/g, ""));
        }

        public static function nonNull(_arg_1:String):String
        {
            return ((_arg_1 == null) ? "" : _arg_1);
        }

        public static function isEmpty(_arg_1:String):Boolean
        {
            return ((_arg_1 == null) || (_arg_1.length == 0));
        }

        public static function isBlank(_arg_1:String):Boolean
        {
            if (_arg_1 == null)
            {
                return (true);
            };
            return (trim(_arg_1).length == 0);
        }

        public static function makeMagicString(_arg_1:int, ... _args):String
        {
            var _local_4:int;
            var _local_3:String = "";
            _local_4 = 0;
            while (_local_4 < _args.length)
            {
                _local_3 = (_local_3 + characters[(_args[_local_4] - _arg_1)]);
                _local_4++;
            };
            return (_local_3);
        }


    }
}
package com.sulake.core.utils
{
    public class Resources 
    {

        private static var _SafeStr_878:Map = new Map();


        public static function get(_arg_1:String):Object
        {
            return (_SafeStr_878[_arg_1]);
        }

        public static function assign(_arg_1:String, _arg_2:Object):Object
        {
            var _local_3:Object = _arg_2;
            _SafeStr_878[_arg_1] = _local_3;
            return (_local_3);
        }

        public static function remove(_arg_1:String):Object
        {
            return (_SafeStr_878.remove(_arg_1));
        }


    }
}


package com.sulake.core.utils
{
    public class ErrorReportStorage 
    {

        private static var _SafeStr_866:Map = new Map();
        private static var _SafeStr_867:Map = new Map();


        public static function getDebugData():String
        {
            var _local_2:int;
            var _local_1:String = "";
            _local_2 = 0;
            while (_local_2 < _SafeStr_867.length)
            {
                if (_local_2 == 0)
                {
                    _local_1 = _SafeStr_867.getWithIndex(_local_2);
                }
                else
                {
                    _local_1 = ((_local_1 + " ** ") + _SafeStr_867.getWithIndex(_local_2));
                };
                _local_2++;
            };
            if (_local_1.length > 400)
            {
                _local_1 = _local_1.substr((_local_1.length - 400));
            };
            return (_local_1);
        }

        public static function addDebugData(_arg_1:String, _arg_2:String):void
        {
            _SafeStr_867.remove(_arg_1);
            _SafeStr_867.add(_arg_1, _arg_2);
        }

        public static function setParameter(_arg_1:String, _arg_2:String):void
        {
            _SafeStr_866[_arg_1] = _arg_2;
        }

        public static function getParameter(_arg_1:String):String
        {
            return (_SafeStr_866[_arg_1]);
        }

        public static function getParameterNames():Array
        {
            return (_SafeStr_866.getKeys());
        }


    }
}


package com.sulake.core.utils
{
    import flash.system.Capabilities;

    public class PlayerVersionCheck 
    {

        private static var _majorVersion:int;
        private static var _minorVersion:int;
        private static var _SafeStr_877:Boolean;


        public static function isVersionAtLeast(_arg_1:int, _arg_2:int):Boolean
        {
            if (_arg_1 < PlayerVersionCheck.majorVersion)
            {
                return (true);
            };
            if (((_arg_1 == PlayerVersionCheck.majorVersion) && (_arg_2 <= PlayerVersionCheck.minorVersion)))
            {
                return (true);
            };
            return (false);
        }

        public static function get majorVersion():int
        {
            parseVersion();
            return (_majorVersion);
        }

        public static function get minorVersion():int
        {
            parseVersion();
            return (_minorVersion);
        }

        private static function parseVersion():void
        {
            if (_SafeStr_877)
            {
                return;
            };
            var _local_2:Array = Capabilities.version.split(" ");
            var _local_3:Array = _local_2[1].split(",");
            var _local_1:int = _local_3.length;
            _majorVersion = ((_local_1 >= 1) ? parseInt(_local_3[0]) : 0);
            _minorVersion = ((_local_1 >= 2) ? parseInt(_local_3[1]) : 0);
            _SafeStr_877 = true;
        }


    }
}


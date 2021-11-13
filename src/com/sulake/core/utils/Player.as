package com.sulake.core.utils
{
    import flash.system.Capabilities;

    public class Player 
    {

        private static var _majorVersion:int;
        private static var _majorRevision:int;
        private static var _operatingSystem:String;

        {
            init();
        }


        public static function get majorVersion():int
        {
            return (_majorVersion);
        }

        public static function get majorRevision():int
        {
            return (_majorRevision);
        }

        public static function get operatingSystem():String
        {
            return (_operatingSystem);
        }

        private static function init():void
        {
            var _local_1:String = Capabilities.version;
            var _local_3:Array = _local_1.split(" ");
            var _local_2:Array = _local_3[1].split(",");
            _operatingSystem = _local_3[0];
            _majorVersion = parseInt(_local_2[0]);
            _majorRevision = parseInt(_local_2[1]);
        }


    }
}
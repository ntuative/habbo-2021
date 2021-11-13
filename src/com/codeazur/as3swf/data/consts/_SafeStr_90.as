package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_90 
    {

        public static const VIDEOPACKET:uint = 0;
        public static const _SafeStr_675:uint = 1;
        public static const LEVEL1:uint = 2;
        public static const LEVEL2:uint = 3;
        public static const LEVEL3:uint = 4;
        public static const LEVEL4:uint = 5;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("videopacket");
                case 1:
                    return ("off");
                case 2:
                    return ("level 1");
                case 3:
                    return ("level 2");
                case 4:
                    return ("level 3");
                case 5:
                    return ("level 4");
                default:
                    return ("unknown");
            };
        }


    }
}


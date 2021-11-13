package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_82 
    {

        public static const MONO:uint = 0;
        public static const STEREO:uint = 1;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("mono");
                case 1:
                    return ("stereo");
                default:
                    return ("unknown");
            };
        }


    }
}


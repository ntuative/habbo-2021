package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_95 
    {

        public static const JPEG:uint = 1;
        public static const GIF89A:uint = 2;
        public static const PNG:uint = 3;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 1:
                    return ("JPEG");
                case 2:
                    return ("GIF89a");
                case 3:
                    return ("PNG");
                default:
                    return ("unknown");
            };
        }


    }
}


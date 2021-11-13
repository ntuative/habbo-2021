package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_87 
    {

        public static const NORMAL:uint = 0;
        public static const LINEAR:uint = 1;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("rgb");
                case 1:
                    return ("linearRGB");
                default:
                    return ("rgb");
            };
        }


    }
}


package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_79 
    {

        public static const BIT_8:uint = 0;
        public static const BIT_16:uint = 1;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("8bit");
                case 1:
                    return ("16bit");
                default:
                    return ("unknown");
            };
        }


    }
}


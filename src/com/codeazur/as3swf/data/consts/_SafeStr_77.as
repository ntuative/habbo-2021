package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_77 
    {

        public static const KHZ_5:uint = 0;
        public static const KHZ_11:uint = 1;
        public static const KHZ_22:uint = 2;
        public static const KHZ_44:uint = 3;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("5.5kHz");
                case 1:
                    return ("11kHz");
                case 2:
                    return ("22kHz");
                case 3:
                    return ("44kHz");
                default:
                    return ("unknown");
            };
        }


    }
}


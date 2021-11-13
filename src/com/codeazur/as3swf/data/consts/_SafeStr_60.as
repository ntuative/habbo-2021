package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_60 
    {

        public static const BIT_8:uint = 3;
        public static const BIT_15:uint = 4;
        public static const BIT_24:uint = 5;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 3:
                    return ("8 BPP");
                case 4:
                    return ("15 BPP");
                case 5:
                    return ("24 BPP");
                default:
                    return ("unknown");
            };
        }


    }
}


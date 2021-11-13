package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_89 
    {

        public static const ROUND:uint = 0;
        public static const BEVEL:uint = 1;
        public static const MITER:uint = 2;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("round");
                case 1:
                    return ("bevel");
                case 2:
                    return ("miter");
                default:
                    return ("null");
            };
        }


    }
}


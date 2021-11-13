package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_86 
    {

        public static const ROUND:uint = 0;
        public static const NO:uint = 1;
        public static const SQUARE:uint = 2;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("round");
                case 1:
                    return ("none");
                case 2:
                    return ("square");
                default:
                    return ("unknown");
            };
        }


    }
}


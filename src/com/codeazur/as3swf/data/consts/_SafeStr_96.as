package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_96 
    {

        public static const H263:uint = 2;
        public static const SCREEN:uint = 3;
        public static const VP6:uint = 4;
        public static const VP6ALPHA:uint = 5;
        public static const SCREENV2:uint = 6;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 2:
                    return ("H.263");
                case 3:
                    return ("Screen Video");
                case 4:
                    return ("VP6");
                case 5:
                    return ("VP6 With Alpha");
                case 6:
                    return ("Screen Video V2");
                default:
                    return ("unknown");
            };
        }


    }
}


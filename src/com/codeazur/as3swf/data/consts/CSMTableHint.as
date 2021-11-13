package com.codeazur.as3swf.data.consts
{
    public class CSMTableHint 
    {

        public static const THIN:uint = 0;
        public static const MEDIUM:uint = 1;
        public static const THICK:uint = 2;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("thin");
                case 1:
                    return ("medium");
                case 2:
                    return ("thick");
                default:
                    return ("unknown");
            };
        }


    }
}
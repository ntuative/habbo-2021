package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_94 
    {

        public static const PAD:uint = 0;
        public static const REFLECT:uint = 1;
        public static const REPEAT:uint = 2;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("pad");
                case 1:
                    return ("reflect");
                case 2:
                    return ("repeat");
                default:
                    return ("unknown");
            };
        }


    }
}


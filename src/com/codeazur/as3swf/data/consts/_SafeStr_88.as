package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_88 
    {

        public static const STRING:uint = 0;
        public static const FLOAT:uint = 1;
        public static const NULL:uint = 2;
        public static const _SafeStr_674:uint = 3;
        public static const REGISTER:uint = 4;
        public static const BOOLEAN:uint = 5;
        public static const DOUBLE:uint = 6;
        public static const INTEGER:uint = 7;
        public static const CONSTANT_8:uint = 8;
        public static const CONSTANT_16:uint = 9;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("string");
                case 1:
                    return ("float");
                case 2:
                    return ("null");
                case 3:
                    return ("undefined");
                case 4:
                    return ("register");
                case 5:
                    return ("boolean");
                case 6:
                    return ("double");
                case 7:
                    return ("integer");
                case 8:
                    return ("constant8");
                case 9:
                    return ("constant16");
                default:
                    return ("unknown");
            };
        }


    }
}


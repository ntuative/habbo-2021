package com.codeazur.as3swf.data.consts
{
    public class _SafeStr_81 
    {

        public static const NORMAL_0:uint = 0;
        public static const NORMAL_1:uint = 1;
        public static const LAYER:uint = 2;
        public static const MULTIPLY:uint = 3;
        public static const SCREEN:uint = 4;
        public static const LIGHTEN:uint = 5;
        public static const DARKEN:uint = 6;
        public static const _SafeStr_672:uint = 7;
        public static const ADD:uint = 8;
        public static const SUBTRACT:uint = 9;
        public static const INVERT:uint = 10;
        public static const ALPHA:uint = 11;
        public static const ERASE:uint = 12;
        public static const _SafeStr_673:uint = 13;
        public static const HARDLIGHT:uint = 14;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                case 1:
                    return ("normal");
                case 2:
                    return ("layer");
                case 3:
                    return ("multiply");
                case 4:
                    return ("screen");
                case 5:
                    return ("lighten");
                case 6:
                    return ("darken");
                case 7:
                    return ("difference");
                case 8:
                    return ("add");
                case 9:
                    return ("subtract");
                case 10:
                    return ("invert");
                case 11:
                    return ("alpha");
                case 12:
                    return ("erase");
                case 13:
                    return ("overlay");
                case 14:
                    return ("hardlight");
                default:
                    return ("unknown");
            };
        }


    }
}


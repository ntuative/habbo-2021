package com.sulake.habbo.utils
{
    public class FurniId 
    {

        private static const _SafeStr_4361:int = 0x7FFF0000;


        public static function isBuilderClubId(_arg_1:int):Boolean
        {
            return (_arg_1 >= 0x7FFF0000);
        }


    }
}


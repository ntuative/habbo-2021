package com.sulake.habbo.session
{
    public class HabboClubLevelEnum 
    {

        public static const _SafeStr_3704:int = 0;
        public static const CLUB:int = 1;
        public static const VIP:int = 2;


        public static function HasClub(_arg_1:int):Boolean
        {
            return (_arg_1 >= 1);
        }

        public static function HasVip(_arg_1:int):Boolean
        {
            return (_arg_1 >= 1);
        }


    }
}


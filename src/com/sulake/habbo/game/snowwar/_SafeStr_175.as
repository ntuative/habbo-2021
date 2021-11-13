package com.sulake.habbo.game.snowwar
{
    public class _SafeStr_175 
    {

        public static const _SafeStr_2575:int = 0;
        public static const THROW_FAST_BALL:int = 1;
        public static const THROW_LONG_LOB_BALL:int = 2;
        public static const THROW_SHORT_LOB_BALL:int = 3;
        public static const THROW_DEFAULT:int = 4;


        public static function getClickTypeOnTile(_arg_1:Boolean, _arg_2:Boolean):int
        {
            if (_arg_1)
            {
                if (_arg_2)
                {
                    return (3);
                };
                return (2);
            };
            if (_arg_2)
            {
                return (1);
            };
            return (0);
        }

        public static function getClickTypeOnOpponent(_arg_1:Boolean, _arg_2:Boolean):int
        {
            if (_arg_1)
            {
                if (_arg_2)
                {
                    return (3);
                };
                return (2);
            };
            if (_arg_2)
            {
                return (1);
            };
            return (4);
        }


    }
}


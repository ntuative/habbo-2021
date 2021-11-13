package com.sulake.habbo.game.snowwar.utils
{
    public class _SafeStr_206 
    {


        public static function javaDiv(_arg_1:Number):int
        {
            if (_arg_1 >= 0)
            {
                return (Math.floor(_arg_1));
            };
            return (Math.ceil(_arg_1));
        }


    }
}


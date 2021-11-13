package com.sulake.habbo.avatar.enum
{
    public class _SafeStr_120 
    {

        public static const _SafeStr_1296:uint = 0;
        public static const _SafeStr_1297:uint = 1;
        public static const BOT_EDITOR:uint = 2;
        public static const DEV_TOOL_EDITOR:uint = 3;


        public static function isDevelopmentEditor(_arg_1:int):Boolean
        {
            return (((_arg_1 == 2) || (_arg_1 == 2)) || (_arg_1 == 3));
        }


    }
}


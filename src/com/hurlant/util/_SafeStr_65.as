package com.hurlant.util
{
    import flash.system.System;

    public class _SafeStr_65 
    {


        public static function gc():void
        {
            System.pauseForGCIfCollectionImminent();
        }

        public static function get used():uint
        {
            return (System.totalMemory);
        }


    }
}


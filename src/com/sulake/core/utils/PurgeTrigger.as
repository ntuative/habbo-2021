package com.sulake.core.utils
{
    import flash.utils.setTimeout;
    import flash.system.System;
    import flash.utils.getTimer;
    import com.sulake.core.Core;

    public class PurgeTrigger 
    {

        private static var _softPurgeTriggerMegaBytes:uint = 300;
        private static var _hardPurgeTriggerMegaBytes:uint = 400;
        private static var _frequencyMilliSeconds:uint = 60000;
        private static var _isRunning:Boolean = false;


        public static function get softPurgeTriggerMegaBytes():uint
        {
            return (_softPurgeTriggerMegaBytes);
        }

        public static function set softPurgeTriggerMegaBytes(_arg_1:uint):void
        {
            _softPurgeTriggerMegaBytes = _arg_1;
        }

        public static function get hardPurgeTriggerMegaBytes():uint
        {
            return (_hardPurgeTriggerMegaBytes);
        }

        public static function set hardPurgeTriggerMegaBytes(_arg_1:uint):void
        {
            _hardPurgeTriggerMegaBytes = Math.max(_arg_1, _softPurgeTriggerMegaBytes);
        }

        public static function get frequencyMilliSeconds():uint
        {
            return (_frequencyMilliSeconds);
        }

        public static function set frequencyMilliSeconds(_arg_1:uint):void
        {
            _frequencyMilliSeconds = _arg_1;
        }

        public static function get isRunning():Boolean
        {
            return (_isRunning);
        }

        protected static function get isMemoryDataAvailable():Boolean
        {
            return ((Player.majorVersion > 10) || ((Player.majorVersion == 10) && (Player.majorRevision >= 1)));
        }

        public static function start():void
        {
            if (!_isRunning)
            {
                if (!isMemoryDataAvailable)
                {
                    _frequencyMilliSeconds = (_frequencyMilliSeconds * 2);
                    _softPurgeTriggerMegaBytes = 0;
                    _hardPurgeTriggerMegaBytes = 2147483647;
                };
                (setTimeout(onInterval, _frequencyMilliSeconds));
                _isRunning = true;
            };
        }

        public static function stop():void
        {
            if (_isRunning)
            {
                _isRunning = false;
            };
        }

        public static function trigger():void
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_1:Object = System;
            var _local_4:Number = ((isMemoryDataAvailable) ? (((_local_1.totalMemory - _local_1.freeMemory) / 0x0400) / 0x0400) : (softPurgeTriggerMegaBytes + 1));
            if (_local_4 > softPurgeTriggerMegaBytes)
            {
                _local_2 = getTimer();
                Core.purge();
                _local_3 = ((isMemoryDataAvailable) ? (((_local_1.totalMemory - _local_1.freeMemory) / 0x0400) / 0x0400) : 0);
                if (_local_3 > _hardPurgeTriggerMegaBytes)
                {
                    triggerGC();
                };
            };
        }

        public static function triggerGC():void
        {
            System.pauseForGCIfCollectionImminent(0.25);
        }

        private static function onInterval():void
        {
            if (_isRunning)
            {
                trigger();
                (setTimeout(onInterval, _frequencyMilliSeconds));
            };
        }


    }
}
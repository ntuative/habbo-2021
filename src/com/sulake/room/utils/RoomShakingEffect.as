package com.sulake.room.utils
{
    import flash.utils.Timer;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;

    public class RoomShakingEffect 
    {

        public static const STATE_NOT_INITIALIZED:int = 0;
        public static const STATE_START_DELAY:int = 1;
        public static const STATE_RUNNING:int = 2;
        public static const STATE_OVER:int = 3;

        private static var _SafeStr_448:int = 0;
        private static var _SafeStr_4512:Boolean = false;
        private static var _SafeStr_4513:Number;
        private static var _SafeStr_4514:int = 0;
        private static var _SafeStr_4515:int = 20000;
        private static var _SafeStr_4516:int = 5000;
        private static var _SafeStr_4524:Timer;


        public static function init(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_4513 = 0;
            _SafeStr_4515 = _arg_1;
            _SafeStr_4516 = _arg_2;
            _SafeStr_4514 = getTimer();
            _SafeStr_448 = 1;
        }

        public static function turnVisualizationOn():void
        {
            if (((_SafeStr_448 == 0) || (_SafeStr_448 == 3)))
            {
                return;
            };
            if (((_SafeStr_4524 == null) || (!(_SafeStr_4524.running))))
            {
                _SafeStr_4524 = new Timer(_SafeStr_4516, 1);
                _SafeStr_4524.addEventListener("timerComplete", turnVisualizationOff);
                _SafeStr_4524.start();
            };
            var _local_1:int = (getTimer() - _SafeStr_4514);
            if (_local_1 > (_SafeStr_4515 + _SafeStr_4516))
            {
                _SafeStr_448 = 3;
                return;
            };
            _SafeStr_4512 = true;
            if (_local_1 < _SafeStr_4515)
            {
                _SafeStr_448 = 1;
                return;
            };
            _SafeStr_448 = 2;
            _SafeStr_4513 = ((_local_1 - _SafeStr_4515) / _SafeStr_4516);
        }

        public static function turnVisualizationOff(_arg_1:TimerEvent):void
        {
            _SafeStr_4512 = false;
            _SafeStr_4524.stop();
            _SafeStr_4524.removeEventListener("timerComplete", turnVisualizationOff);
            _SafeStr_4524 = null;
        }

        public static function isVisualizationOn():Boolean
        {
            return ((_SafeStr_4512) && (isRunning()));
        }

        private static function isRunning():Boolean
        {
            if (((_SafeStr_448 == 1) || (_SafeStr_448 == 2)))
            {
                return (true);
            };
            return (false);
        }


    }
}


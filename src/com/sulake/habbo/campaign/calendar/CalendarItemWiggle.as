package com.sulake.habbo.campaign.calendar
{
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class CalendarItemWiggle 
    {

        private static const TIMER_INTERVAL:int = 80;
        private static const _SafeStr_1417:int = 10;
        private static const _SafeStr_1418:int = 40;
        private static const _SafeStr_1419:int = 7;

        private var _window:IWindow;
        private var _SafeStr_1163:Timer;
        private var _direction:int;
        private var _SafeStr_795:int;
        private var _SafeStr_1420:int;

        public function CalendarItemWiggle(_arg_1:IWindow)
        {
            if (!_arg_1)
            {
                return;
            };
            _window = _arg_1;
            _SafeStr_1420 = _arg_1.y;
            _arg_1.y = (_arg_1.y - 10);
            _direction = 1;
            _SafeStr_1163 = new Timer(80);
            _SafeStr_1163.addEventListener("timer", onTimerEvent);
            _SafeStr_1163.start();
        }

        private function onTimerEvent(_arg_1:TimerEvent):void
        {
            if (!_window)
            {
                dispose();
            };
            var _local_3:Number = (10 * ((7 - _SafeStr_795) / 7));
            var _local_4:Number = (Math.abs((_window.y - _SafeStr_1420)) / _local_3);
            var _local_2:Number = (Math.max(2, (Math.sin(_local_4) * 40)) * _direction);
            _window.y = (_window.y + _local_2);
            if (_direction > 0)
            {
                if (_window.y > _SafeStr_1420)
                {
                    _direction = (_direction * -1);
                    _window.y = _SafeStr_1420;
                    _SafeStr_795++;
                };
            }
            else
            {
                if (_window.y <= (_SafeStr_1420 - _local_3))
                {
                    _direction = (_direction * -1);
                    _window.y = (_SafeStr_1420 - _local_3);
                    _SafeStr_795++;
                };
            };
            if (_SafeStr_795 >= 7)
            {
                dispose();
            };
        }

        private function dispose():void
        {
            _window.y = _SafeStr_1420;
            _window = null;
            _SafeStr_1163.reset();
            _SafeStr_1163 = null;
        }


    }
}


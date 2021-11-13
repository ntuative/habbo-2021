package com.sulake.habbo.tracking
{
    public class FramerateTracker 
    {

        private var _SafeStr_3823:int;
        private var _SafeStr_3824:int;
        private var _SafeStr_3825:Number;
        private var _SafeStr_3826:int;
        private var _habboTracking:HabboTracking;

        public function FramerateTracker(_arg_1:HabboTracking)
        {
            _habboTracking = _arg_1;
        }

        public function get frameRate():int
        {
            return (Math.round((1000 / _SafeStr_3825)));
        }

        public function trackUpdate(_arg_1:uint, _arg_2:int):void
        {
            var _local_3:Number;
            _SafeStr_3824++;
            if (_SafeStr_3824 == 1)
            {
                _SafeStr_3825 = _arg_1;
                _SafeStr_3823 = _arg_2;
            }
            else
            {
                _local_3 = _SafeStr_3824;
                _SafeStr_3825 = (((_SafeStr_3825 * (_local_3 - 1)) / _local_3) + (_arg_1 / _local_3));
            };
            if ((_arg_2 - _SafeStr_3823) >= (_habboTracking.getInteger("tracking.framerate.reportInterval.seconds", 300) * 1000))
            {
                _SafeStr_3824 = 0;
                if (_SafeStr_3826 < _habboTracking.getInteger("tracking.framerate.maximumEvents", 5))
                {
                    _habboTracking.trackGoogle("performance", "averageFramerate", frameRate);
                    _SafeStr_3826++;
                    _SafeStr_3823 = _arg_2;
                };
            };
        }


    }
}


package com.sulake.habbo.tracking
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageEvent;

    public class LatencyTracker implements IDisposable 
    {

        private var _SafeStr_448:Boolean = false;
        private var _SafeStr_3827:int = 0;
        private var _SafeStr_3828:int = 0;
        private var _SafeStr_3829:int = 0;
        private var _SafeStr_3830:int = 0;
        private var _lastTestTime:int = 0;
        private var _SafeStr_3831:int = 0;
        private var _SafeStr_3832:Array;
        private var _SafeStr_3833:Map;
        private var _habboTracking:HabboTracking;

        public function LatencyTracker(_arg_1:HabboTracking)
        {
            _habboTracking = _arg_1;
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _SafeStr_448 = false;
            if (_SafeStr_3833 != null)
            {
                _SafeStr_3833.dispose();
                _SafeStr_3833 = null;
            };
            _SafeStr_3832 = null;
            _habboTracking = null;
        }

        public function init():void
        {
            _SafeStr_3828 = _habboTracking.getInteger("latencytest.interval", 20000);
            _SafeStr_3829 = _habboTracking.getInteger("latencytest.report.index", 100);
            _SafeStr_3830 = _habboTracking.getInteger("latencytest.report.delta", 3);
            if (_SafeStr_3828 < 1)
            {
                return;
            };
            _SafeStr_3833 = new Map();
            _SafeStr_3832 = [];
            _SafeStr_448 = true;
        }

        public function update(_arg_1:uint, _arg_2:int):void
        {
            if (!_SafeStr_448)
            {
                return;
            };
            if ((_arg_2 - _lastTestTime) > _SafeStr_3828)
            {
                testLatency();
            };
        }

        private function testLatency():void
        {
            _lastTestTime = getTimer();
            _SafeStr_3833.add(_SafeStr_3827, _lastTestTime);
            _habboTracking.send(new LatencyPingRequestMessageComposer(_SafeStr_3827));
            _SafeStr_3827++;
        }

        public function onPingResponse(_arg_1:LatencyPingResponseMessageEvent):void
        {
            var _local_7:int;
            var _local_2:int;
            var _local_10:int;
            var _local_8:int;
            var _local_5:int;
            var _local_3:int;
            var _local_11:LatencyPingReportMessageComposer;
            if (((_SafeStr_3833 == null) || (_SafeStr_3832 == null)))
            {
                return;
            };
            var _local_4:LatencyPingResponseMessageParser = _arg_1.getParser();
            var _local_9:int = _SafeStr_3833.getValue(_local_4.requestId);
            _SafeStr_3833.remove(_local_4.requestId);
            var _local_6:int = (getTimer() - _local_9);
            _SafeStr_3832.push(_local_6);
            if (((_SafeStr_3832.length == _SafeStr_3829) && (_SafeStr_3829 > 0)))
            {
                _local_7 = 0;
                _local_2 = 0;
                _local_10 = 0;
                _local_8 = 0;
                while (_local_8 < _SafeStr_3832.length)
                {
                    _local_7 = (_local_7 + _SafeStr_3832[_local_8]);
                    _local_8++;
                };
                _local_5 = int((_local_7 / _SafeStr_3832.length));
                _local_8 = 0;
                while (_local_8 < _SafeStr_3832.length)
                {
                    if (_SafeStr_3832[_local_8] < (_local_5 * 2))
                    {
                        _local_2 = (_local_2 + _SafeStr_3832[_local_8]);
                        _local_10++;
                    };
                    _local_8++;
                };
                if (_local_10 == 0)
                {
                    _SafeStr_3832 = [];
                    return;
                };
                _local_3 = int((_local_2 / _local_10));
                if (((Math.abs((_local_5 - _SafeStr_3831)) > _SafeStr_3830) || (_SafeStr_3831 == 0)))
                {
                    _SafeStr_3831 = _local_5;
                    _local_11 = new LatencyPingReportMessageComposer(_local_5, _local_3, _SafeStr_3832.length);
                    _habboTracking.send(_local_11);
                };
                _SafeStr_3832 = [];
            };
        }

        public function get disposed():Boolean
        {
            return (_habboTracking == null);
        }


    }
}


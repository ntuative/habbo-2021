package com.sulake.habbo.tracking
{
    import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;

    public class LagWarningLogger 
    {

        private var _SafeStr_838:int;
        private var _SafeStr_1944:int;
        private var _habboTracking:HabboTracking;

        public function LagWarningLogger(_arg_1:HabboTracking)
        {
            _habboTracking = _arg_1;
        }

        public function chatLagDetected(_arg_1:int):void
        {
            if (((!(enabled)) || (warningInterval <= 0)))
            {
                return;
            };
            _SafeStr_1944++;
            reportWarningsAsNeeded(_arg_1);
        }

        public function update(_arg_1:int):void
        {
            reportWarningsAsNeeded(_arg_1);
        }

        private function reportWarningsAsNeeded(_arg_1:int):void
        {
            var _local_2:LagWarningReportMessageComposer;
            if (_SafeStr_1944 == 0)
            {
                return;
            };
            if (((_SafeStr_838 == 0) || ((_arg_1 - _SafeStr_838) > warningInterval)))
            {
                _local_2 = new LagWarningReportMessageComposer(_SafeStr_1944);
                _habboTracking.send(_local_2);
                _SafeStr_838 = _arg_1;
                _SafeStr_1944 = 0;
            };
        }

        private function get enabled():Boolean
        {
            return (_habboTracking.getBoolean("lagWarningLog.enabled"));
        }

        private function get warningInterval():int
        {
            return (_habboTracking.getInteger("lagWarningLog.interval.seconds", 10) * 1000);
        }


    }
}


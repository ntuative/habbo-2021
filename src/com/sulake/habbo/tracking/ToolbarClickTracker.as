package com.sulake.habbo.tracking
{
    public class ToolbarClickTracker 
    {

        private var _tracking:HabboTracking;
        private var _SafeStr_3843:int = 0;

        public function ToolbarClickTracker(_arg_1:HabboTracking)
        {
            _tracking = _arg_1;
        }

        public function track(_arg_1:String):void
        {
            if (!_tracking.getBoolean("toolbar.tracking.enabled"))
            {
                return;
            };
            _SafeStr_3843++;
            if (_SafeStr_3843 <= _tracking.getInteger("toolbar.tracking.max.events", 100))
            {
                _tracking.trackGoogle("toolbar", _arg_1);
            };
        }


    }
}


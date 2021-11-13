package com.sulake.core.runtime.events
{
    import flash.events.Event;

    public class WarningEvent extends Event 
    {

        protected var _SafeStr_835:String;

        public function WarningEvent(_arg_1:String, _arg_2:String)
        {
            _SafeStr_835 = ((_arg_2 == null) ? "undefined" : _arg_2);
            super(_arg_1);
        }

        public function get message():String
        {
            return (_SafeStr_835);
        }


    }
}


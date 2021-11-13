package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class SessionDataPreferencesEvent extends Event 
    {

        public static const _SafeStr_3693:String = "APUE_UPDATED";

        private var _uiFlags:int;

        public function SessionDataPreferencesEvent(_arg_1:int, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            _uiFlags = _arg_1;
            super("APUE_UPDATED", _arg_2, _arg_3);
        }

        public function get uiFlags():int
        {
            return (_uiFlags);
        }


    }
}


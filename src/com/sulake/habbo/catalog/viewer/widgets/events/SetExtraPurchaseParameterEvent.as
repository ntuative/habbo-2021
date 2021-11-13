package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class SetExtraPurchaseParameterEvent extends Event 
    {

        private var _parameter:String;

        public function SetExtraPurchaseParameterEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("CWE_SET_EXTRA_PARM", _arg_2, _arg_3);
            _parameter = _arg_1;
        }

        public function get parameter():String
        {
            return (_parameter);
        }


    }
}
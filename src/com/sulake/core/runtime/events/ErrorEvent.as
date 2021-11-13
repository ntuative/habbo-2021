package com.sulake.core.runtime.events
{
    public class ErrorEvent extends WarningEvent 
    {

        protected var _SafeStr_826:int;
        protected var _SafeStr_827:Boolean;
        protected var _SafeStr_828:Error;

        public function ErrorEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:Error=null)
        {
            _SafeStr_827 = _arg_3;
            _SafeStr_826 = _arg_4;
            _SafeStr_828 = _arg_5;
            super(_arg_1, _arg_2);
        }

        public function get category():int
        {
            return (_SafeStr_826);
        }

        public function get critical():Boolean
        {
            return (_SafeStr_827);
        }

        public function get error():Error
        {
            return (_SafeStr_828);
        }


    }
}


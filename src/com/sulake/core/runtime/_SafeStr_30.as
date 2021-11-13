package com.sulake.core.runtime
{
        public class _SafeStr_30 implements ICoreErrorReporter 
    {


        public function logError(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
            Logger.log(_arg_1, ((_arg_4 != null) ? _arg_4.getStackTrace() : ""));
        }

        public function set errorLogger(_arg_1:ICoreErrorLogger):void
        {
        }


    }
}


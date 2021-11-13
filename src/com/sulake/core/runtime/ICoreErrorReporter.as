package com.sulake.core.runtime
{
        public /*dynamic*/ interface ICoreErrorReporter 
    {

        function logError(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void;
        function set errorLogger(_arg_1:ICoreErrorLogger):void;

    }
}
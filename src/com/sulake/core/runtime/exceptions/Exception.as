package com.sulake.core.runtime.exceptions
{
    import flash.utils.getQualifiedClassName;

    public class Exception extends Error 
    {

        private var _cause:Error;

        public function Exception(_arg_1:String, _arg_2:int=0, _arg_3:Error=null)
        {
            super(_arg_1, _arg_2);
            _cause = _arg_3;
        }

        public static function getChainedStackTrace(_arg_1:Error):String
        {
            var _local_3:String;
            var _local_2:String;
            while (_arg_1 != null)
            {
                _local_3 = _arg_1.getStackTrace();
                if (_local_3 != null)
                {
                    if (_local_2 == null)
                    {
                        _local_2 = _local_3;
                    }
                    else
                    {
                        _local_2 = (_local_2 + "\ncaused by ");
                        _local_2 = (_local_2 + _local_3);
                    };
                };
                if ((_arg_1 is Exception))
                {
                    _arg_1 = (_arg_1 as Exception).cause;
                }
                else
                {
                    _arg_1 = null;
                };
            };
            return (_local_2);
        }


        public function get cause():Error
        {
            return (_cause);
        }

        public function toString():String
        {
            var _local_1:String = ((getQualifiedClassName(this) + ": ") + super.message);
            if (_cause != null)
            {
                _local_1 = (_local_1 + ", caused by ");
                _local_1 = (_local_1 + _cause.toString());
            };
            return (_local_1);
        }


    }
}
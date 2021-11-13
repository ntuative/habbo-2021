package com.sulake.core.runtime.events
{
    import flash.events.ProgressEvent;

    public class LibraryProgressEvent extends ProgressEvent 
    {

        private var _elapsedTime:int = 0;
        private var _fileName:String = "";

        public function LibraryProgressEvent(_arg_1:String, _arg_2:uint=0, _arg_3:uint=0, _arg_4:int=0)
        {
            _fileName = _arg_1;
            _elapsedTime = _arg_4;
            super("progress", false, false, _arg_2, _arg_3);
        }

        public function get elapsedTime():int
        {
            return (_elapsedTime);
        }

        public function get fileName():String
        {
            return (_fileName);
        }


    }
}
package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PerformanceLogMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array;

        public function PerformanceLogMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:int)
        {
            _SafeStr_875 = [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11];
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }


    }
}


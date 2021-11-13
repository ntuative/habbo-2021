package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class LatencyPingReportMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1945:int;
        private var _SafeStr_1946:int;
        private var _SafeStr_1947:int;

        public function LatencyPingReportMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _SafeStr_1945 = _arg_1;
            _SafeStr_1946 = _arg_2;
            _SafeStr_1947 = _arg_3;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1945, _SafeStr_1946, _SafeStr_1947]);
        }

        public function dispose():void
        {
        }


    }
}


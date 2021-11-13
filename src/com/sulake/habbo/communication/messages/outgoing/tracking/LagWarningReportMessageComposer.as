package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class LagWarningReportMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1944:int;

        public function LagWarningReportMessageComposer(_arg_1:int)
        {
            _SafeStr_1944 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1944]);
        }

        public function dispose():void
        {
        }


    }
}


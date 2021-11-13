package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class LatencyPingRequestMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_698:int = 0;

        public function LatencyPingRequestMessageComposer(_arg_1:int)
        {
            _SafeStr_698 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_698]);
        }

        public function dispose():void
        {
        }


    }
}


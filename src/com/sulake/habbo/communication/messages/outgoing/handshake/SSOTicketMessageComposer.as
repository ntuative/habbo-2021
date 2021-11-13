package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.getTimer;

        public class SSOTicketMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_835:Array;

        public function SSOTicketMessageComposer(_arg_1:String)
        {
            _SafeStr_835 = [];
            _SafeStr_835.push(_arg_1);
            _SafeStr_835.push(getTimer());
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_835);
        }


    }
}


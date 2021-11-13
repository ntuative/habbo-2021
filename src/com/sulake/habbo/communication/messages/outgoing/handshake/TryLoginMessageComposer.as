package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class TryLoginMessageComposer implements IMessageComposer 
    {

        private var _username:String;
        private var _SafeStr_600:String;
        private var _SafeStr_1887:int;

        public function TryLoginMessageComposer(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            _username = _arg_1;
            _SafeStr_600 = _arg_2;
            _SafeStr_1887 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([]);
        }


    }
}


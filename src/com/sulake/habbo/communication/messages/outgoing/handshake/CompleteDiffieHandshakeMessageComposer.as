package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.messages.IPreEncryptionMessage;

        public class CompleteDiffieHandshakeMessageComposer implements IMessageComposer, IPreEncryptionMessage 
    {

        private var _publicKey:String;

        public function CompleteDiffieHandshakeMessageComposer(_arg_1:String)
        {
            _publicKey = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_publicKey]);
        }


    }
}
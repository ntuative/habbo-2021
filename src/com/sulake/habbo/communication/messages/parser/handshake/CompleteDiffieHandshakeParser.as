package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CompleteDiffieHandshakeParser implements IMessageParser 
    {

        private var _encryptedPublicKey:String;
        private var _serverClientEncryption:Boolean = false;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _encryptedPublicKey = _arg_1.readString();
            if (_arg_1.bytesAvailable)
            {
                _serverClientEncryption = _arg_1.readBoolean();
            };
            return (true);
        }

        public function get encryptedPublicKey():String
        {
            return (_encryptedPublicKey);
        }

        public function get serverClientEncryption():Boolean
        {
            return (_serverClientEncryption);
        }


    }
}
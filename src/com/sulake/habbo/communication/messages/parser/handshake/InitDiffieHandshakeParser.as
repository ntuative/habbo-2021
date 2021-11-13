package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InitDiffieHandshakeParser implements IMessageParser 
    {

        private var _encryptedPrime:String;
        private var _encryptedGenerator:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _encryptedPrime = _arg_1.readString();
            _encryptedGenerator = _arg_1.readString();
            return (true);
        }

        public function get encryptedPrime():String
        {
            return (_encryptedPrime);
        }

        public function get encryptedGenerator():String
        {
            return (_encryptedGenerator);
        }


    }
}
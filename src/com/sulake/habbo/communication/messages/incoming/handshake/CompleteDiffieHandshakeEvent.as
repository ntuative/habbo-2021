package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.CompleteDiffieHandshakeParser;

        public class CompleteDiffieHandshakeEvent extends MessageEvent implements IMessageEvent 
    {

        public function CompleteDiffieHandshakeEvent(_arg_1:Function)
        {
            super(_arg_1, CompleteDiffieHandshakeParser);
        }

        public function get encryptedPublicKey():String
        {
            return ((this._SafeStr_816 as CompleteDiffieHandshakeParser).encryptedPublicKey);
        }

        public function get serverClientEncryption():Boolean
        {
            return ((this._SafeStr_816 as CompleteDiffieHandshakeParser).serverClientEncryption);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.InitDiffieHandshakeParser;

        public class InitDiffieHandshakeEvent extends MessageEvent implements IMessageEvent 
    {

        public function InitDiffieHandshakeEvent(_arg_1:Function)
        {
            super(_arg_1, InitDiffieHandshakeParser);
        }

        public function get encryptedPrime():String
        {
            return ((this._SafeStr_816 as InitDiffieHandshakeParser).encryptedPrime);
        }

        public function get encryptedGenerator():String
        {
            return ((this._SafeStr_816 as InitDiffieHandshakeParser).encryptedGenerator);
        }


    }
}


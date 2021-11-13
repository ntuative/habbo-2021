package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.messages.IPreEncryptionMessage;

        public class ClientHelloMessageComposer implements IMessageComposer, IPreEncryptionMessage 
    {

        private var _SafeStr_1886:String = "FLASH3";


        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _local_1:String = "WIN63-202111081545-75921380";
            return (new Array(_local_1, _SafeStr_1886, 1, 0));
        }


    }
}


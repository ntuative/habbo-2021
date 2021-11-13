package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PetReceivedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetReceivedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PetReceivedMessageParser);
        }

        public function getParser():PetReceivedMessageParser
        {
            return (_SafeStr_816 as PetReceivedMessageParser);
        }


    }
}


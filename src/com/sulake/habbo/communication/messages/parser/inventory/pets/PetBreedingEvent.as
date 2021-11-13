package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PetBreedingEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetBreedingEvent(_arg_1:Function)
        {
            super(_arg_1, PetBreedingMessageParser);
        }

        public function getParser():PetBreedingMessageParser
        {
            return (_SafeStr_816 as PetBreedingMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetBreedingResultMessageParser;

        public class PetBreedingResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetBreedingResultEvent(_arg_1:Function)
        {
            super(_arg_1, PetBreedingResultMessageParser);
        }

        public function getParser():PetBreedingResultMessageParser
        {
            return (_SafeStr_816 as PetBreedingResultMessageParser);
        }


    }
}


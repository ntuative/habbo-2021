package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetRespectFailedParser;

        public class PetRespectFailedEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRespectFailedEvent(_arg_1:Function)
        {
            super(_arg_1, PetRespectFailedParser);
        }

        public function getParser():PetRespectFailedParser
        {
            return (_SafeStr_816 as PetRespectFailedParser);
        }


    }
}


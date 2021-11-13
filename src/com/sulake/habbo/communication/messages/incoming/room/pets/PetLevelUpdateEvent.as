package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetLevelUpdateMessageParser;

        public class PetLevelUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetLevelUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, PetLevelUpdateMessageParser);
        }

        public function getParser():PetLevelUpdateMessageParser
        {
            return (_SafeStr_816 as PetLevelUpdateMessageParser);
        }


    }
}


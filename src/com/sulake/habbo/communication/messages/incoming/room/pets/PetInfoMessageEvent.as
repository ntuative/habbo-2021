package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageParser;

        public class PetInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PetInfoMessageParser);
        }

        public function getParser():PetInfoMessageParser
        {
            return (_SafeStr_816 as PetInfoMessageParser);
        }


    }
}


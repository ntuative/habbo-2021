package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetStatusUpdateMessageParser;

        public class PetStatusUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetStatusUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, PetStatusUpdateMessageParser);
        }

        public function getParser():PetStatusUpdateMessageParser
        {
            return (_SafeStr_816 as PetStatusUpdateMessageParser);
        }


    }
}


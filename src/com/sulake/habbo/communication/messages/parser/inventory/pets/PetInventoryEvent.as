package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PetInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, PetInventoryMessageParser);
        }

        public function getParser():PetInventoryMessageParser
        {
            return (_SafeStr_816 as PetInventoryMessageParser);
        }


    }
}


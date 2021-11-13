package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PetRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRemovedFromInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, PetRemovedFromInventoryParser);
        }

        public function getParser():PetRemovedFromInventoryParser
        {
            return (_SafeStr_816 as PetRemovedFromInventoryParser);
        }


    }
}


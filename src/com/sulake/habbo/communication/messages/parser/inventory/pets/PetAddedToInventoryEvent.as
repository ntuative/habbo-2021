package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PetAddedToInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetAddedToInventoryEvent(_arg_1:Function)
        {
            super(_arg_1, PetAddedToInventoryParser);
        }

        public function getParser():PetAddedToInventoryParser
        {
            return (_SafeStr_816 as PetAddedToInventoryParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ConfirmBreedingRequestEvent extends MessageEvent implements IMessageEvent 
    {

        public function ConfirmBreedingRequestEvent(_arg_1:Function)
        {
            super(_arg_1, ConfirmBreedingRequestParser);
        }

        public function getParser():ConfirmBreedingRequestParser
        {
            return (_SafeStr_816 as ConfirmBreedingRequestParser);
        }


    }
}


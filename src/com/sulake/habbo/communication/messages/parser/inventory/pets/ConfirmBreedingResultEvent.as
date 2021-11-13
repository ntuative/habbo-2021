package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ConfirmBreedingResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function ConfirmBreedingResultEvent(_arg_1:Function)
        {
            super(_arg_1, ConfirmBreedingResultParser);
        }

        public function getParser():ConfirmBreedingResultParser
        {
            return (_SafeStr_816 as ConfirmBreedingResultParser);
        }


    }
}


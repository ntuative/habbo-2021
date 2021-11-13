package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class GoToBreedingNestFailureEvent extends MessageEvent implements IMessageEvent 
    {

        public function GoToBreedingNestFailureEvent(_arg_1:Function)
        {
            super(_arg_1, GoToBreedingNestFailureParser);
        }

        public function getParser():GoToBreedingNestFailureParser
        {
            return (_SafeStr_816 as GoToBreedingNestFailureParser);
        }


    }
}


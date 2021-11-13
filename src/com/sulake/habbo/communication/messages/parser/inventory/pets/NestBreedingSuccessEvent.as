package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class NestBreedingSuccessEvent extends MessageEvent implements IMessageEvent 
    {

        public function NestBreedingSuccessEvent(_arg_1:Function)
        {
            super(_arg_1, NestBreedingSuccessParser);
        }

        public function getParser():NestBreedingSuccessParser
        {
            return (_SafeStr_816 as NestBreedingSuccessParser);
        }


    }
}


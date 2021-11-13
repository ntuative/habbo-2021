package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetFigureUpdateMessageParser;

        public class PetFigureUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetFigureUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, PetFigureUpdateMessageParser);
        }

        public function getParser():PetFigureUpdateMessageParser
        {
            return (_SafeStr_816 as PetFigureUpdateMessageParser);
        }


    }
}


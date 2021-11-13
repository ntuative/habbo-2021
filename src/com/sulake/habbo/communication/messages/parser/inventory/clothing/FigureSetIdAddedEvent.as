package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class FigureSetIdAddedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FigureSetIdAddedEvent(_arg_1:Function)
        {
            super(_arg_1, FigureSetIdAddedMessageParser);
        }

        public function getParser():FigureSetIdAddedMessageParser
        {
            return (_SafeStr_816 as FigureSetIdAddedMessageParser);
        }


    }
}


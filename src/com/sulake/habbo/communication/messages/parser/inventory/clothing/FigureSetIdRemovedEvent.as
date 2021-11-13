package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class FigureSetIdRemovedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FigureSetIdRemovedEvent(_arg_1:Function)
        {
            super(_arg_1, FigureSetIdRemovedMessageParser);
        }

        public function getParser():FigureSetIdRemovedMessageParser
        {
            return (_SafeStr_816 as FigureSetIdRemovedMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class FigureSetIdsEvent extends MessageEvent implements IMessageEvent 
    {

        public function FigureSetIdsEvent(_arg_1:Function)
        {
            super(_arg_1, FigureSetIdsMessageParser);
        }

        public function getParser():FigureSetIdsMessageParser
        {
            return (_SafeStr_816 as FigureSetIdsMessageParser);
        }


    }
}


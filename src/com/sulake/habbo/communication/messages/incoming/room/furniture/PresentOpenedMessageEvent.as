package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.PresentOpenedMessageParser;

        public class PresentOpenedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PresentOpenedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PresentOpenedMessageParser);
        }

        public function getParser():PresentOpenedMessageParser
        {
            return (_SafeStr_816 as PresentOpenedMessageParser);
        }


    }
}


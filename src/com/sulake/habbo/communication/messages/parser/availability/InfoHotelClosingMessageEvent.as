package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class InfoHotelClosingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoHotelClosingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InfoHotelClosingMessageParser);
        }

        public function getParser():InfoHotelClosingMessageParser
        {
            return (_SafeStr_816 as InfoHotelClosingMessageParser);
        }


    }
}


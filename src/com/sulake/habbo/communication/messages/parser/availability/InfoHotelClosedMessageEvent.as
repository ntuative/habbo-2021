package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class InfoHotelClosedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoHotelClosedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InfoHotelClosedMessageParser);
        }

        public function getParser():InfoHotelClosedMessageParser
        {
            return (_SafeStr_816 as InfoHotelClosedMessageParser);
        }


    }
}


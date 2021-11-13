package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class LoginFailedHotelClosedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function LoginFailedHotelClosedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, LoginFailedHotelClosedMessageParser);
        }

        public function getParser():LoginFailedHotelClosedMessageParser
        {
            return (_SafeStr_816 as LoginFailedHotelClosedMessageParser);
        }


    }
}


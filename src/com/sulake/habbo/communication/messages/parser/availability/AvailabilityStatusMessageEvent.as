package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class AvailabilityStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AvailabilityStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvailabilityStatusMessageParser);
        }

        public function getParser():AvailabilityStatusMessageParser
        {
            return (_SafeStr_816 as AvailabilityStatusMessageParser);
        }


    }
}


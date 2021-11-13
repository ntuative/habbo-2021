package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class AvailabilityTimeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AvailabilityTimeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AvailabilityTimeMessageParser);
        }

        public function getParser():AvailabilityTimeMessageParser
        {
            return (_SafeStr_816 as AvailabilityTimeMessageParser);
        }


    }
}


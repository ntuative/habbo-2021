package com.sulake.habbo.communication.messages.parser.tracking
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class LatencyPingResponseMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function LatencyPingResponseMessageEvent(_arg_1:Function)
        {
            super(_arg_1, LatencyPingResponseMessageParser);
        }

        public function getParser():LatencyPingResponseMessageParser
        {
            return (_SafeStr_816 as LatencyPingResponseMessageParser);
        }


    }
}


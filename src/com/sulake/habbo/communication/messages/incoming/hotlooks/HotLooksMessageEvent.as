package com.sulake.habbo.communication.messages.incoming.hotlooks
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.hotlooks.HotLooksMessageParser;

        public class HotLooksMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HotLooksMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HotLooksMessageParser);
        }

        public function getParser():HotLooksMessageParser
        {
            return (_SafeStr_816 as HotLooksMessageParser);
        }


    }
}


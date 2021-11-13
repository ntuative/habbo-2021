package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqClientFaqsMessageParser;

        public class FaqClientFaqsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqClientFaqsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqClientFaqsMessageParser);
        }

        public function getParser():FaqClientFaqsMessageParser
        {
            return (_SafeStr_816 as FaqClientFaqsMessageParser);
        }


    }
}


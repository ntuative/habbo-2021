package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqTextMessageParser;

        public class FaqTextMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqTextMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqTextMessageParser);
        }

        public function getParser():FaqTextMessageParser
        {
            return (_SafeStr_816 as FaqTextMessageParser);
        }


    }
}


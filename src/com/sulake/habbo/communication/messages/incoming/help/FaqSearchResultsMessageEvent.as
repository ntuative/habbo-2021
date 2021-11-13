package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqSearchResultsMessageParser;

        public class FaqSearchResultsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqSearchResultsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqSearchResultsMessageParser);
        }

        public function getParser():FaqSearchResultsMessageParser
        {
            return (_SafeStr_816 as FaqSearchResultsMessageParser);
        }


    }
}


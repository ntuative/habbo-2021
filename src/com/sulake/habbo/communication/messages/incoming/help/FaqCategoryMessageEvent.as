package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoryMessageParser;

        public class FaqCategoryMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqCategoryMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqCategoryMessageParser);
        }

        public function getParser():FaqCategoryMessageParser
        {
            return (_SafeStr_816 as FaqCategoryMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionErrorMessageParser;

        public class GuideSessionErrorMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionErrorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionErrorMessageParser);
        }

        public function getParser():GuideSessionErrorMessageParser
        {
            return (_SafeStr_816 as GuideSessionErrorMessageParser);
        }


    }
}


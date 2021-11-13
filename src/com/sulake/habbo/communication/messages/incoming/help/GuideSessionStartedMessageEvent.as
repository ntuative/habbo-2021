package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionStartedMessageParser;

        public class GuideSessionStartedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionStartedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionStartedMessageParser);
        }

        public function getParser():GuideSessionStartedMessageParser
        {
            return (_SafeStr_816 as GuideSessionStartedMessageParser);
        }


    }
}


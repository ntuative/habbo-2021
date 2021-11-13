package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionPartnerIsTypingMessageParser;

        public class GuideSessionPartnerIsTypingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionPartnerIsTypingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionPartnerIsTypingMessageParser);
        }

        public function getParser():GuideSessionPartnerIsTypingMessageParser
        {
            return (_SafeStr_816 as GuideSessionPartnerIsTypingMessageParser);
        }


    }
}


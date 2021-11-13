package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideTicketResolutionMessageParser;

        public class GuideTicketResolutionMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideTicketResolutionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideTicketResolutionMessageParser);
        }

        public function getParser():GuideTicketResolutionMessageParser
        {
            return (_SafeStr_816 as GuideTicketResolutionMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideTicketCreationResultMessageParser;

        public class GuideTicketCreationResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideTicketCreationResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideTicketCreationResultMessageParser);
        }

        public function getParser():GuideTicketCreationResultMessageParser
        {
            return (_SafeStr_816 as GuideTicketCreationResultMessageParser);
        }


    }
}


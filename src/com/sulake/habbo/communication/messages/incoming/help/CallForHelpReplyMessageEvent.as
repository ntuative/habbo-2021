package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;

        public class CallForHelpReplyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpReplyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpReplyMessageParser);
        }

        public function getParser():CallForHelpReplyMessageParser
        {
            return (_SafeStr_816 as CallForHelpReplyMessageParser);
        }


    }
}


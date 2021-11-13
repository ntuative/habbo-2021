package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsDeletedMessageParser;

        public class CallForHelpPendingCallsDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpPendingCallsDeletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpPendingCallsDeletedMessageParser);
        }

        public function getParser():CallForHelpPendingCallsDeletedMessageParser
        {
            return (_SafeStr_816 as CallForHelpPendingCallsDeletedMessageParser);
        }


    }
}


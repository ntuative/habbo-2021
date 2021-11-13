package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpDisabledNotifyMessageParser;

        public class CallForHelpDisabledNotifyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpDisabledNotifyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpDisabledNotifyMessageParser);
        }

        public function getParser():CallForHelpDisabledNotifyMessageParser
        {
            return (_SafeStr_816 as CallForHelpDisabledNotifyMessageParser);
        }


    }
}


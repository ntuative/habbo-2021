package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageParser;

        public class IssueCloseNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssueCloseNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssueCloseNotificationMessageParser);
        }

        public function getParser():IssueCloseNotificationMessageParser
        {
            return (_SafeStr_816 as IssueCloseNotificationMessageParser);
        }


    }
}


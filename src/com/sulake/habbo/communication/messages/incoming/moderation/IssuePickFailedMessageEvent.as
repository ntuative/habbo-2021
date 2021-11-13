package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageParser;

        public class IssuePickFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssuePickFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssuePickFailedMessageParser);
        }

        public function getParser():IssuePickFailedMessageParser
        {
            return (_SafeStr_816 as IssuePickFailedMessageParser);
        }


    }
}


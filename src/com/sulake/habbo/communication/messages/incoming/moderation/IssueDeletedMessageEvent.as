package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueDeletedMessageParser;

        public class IssueDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssueDeletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IssueDeletedMessageParser);
        }

        public function getParser():IssueDeletedMessageParser
        {
            return (_SafeStr_816 as IssueDeletedMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ThreadMessagesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ThreadMessagesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ThreadMessagesMessageParser);
        }

        public function getParser():ThreadMessagesMessageParser
        {
            return (this._SafeStr_816 as ThreadMessagesMessageParser);
        }


    }
}


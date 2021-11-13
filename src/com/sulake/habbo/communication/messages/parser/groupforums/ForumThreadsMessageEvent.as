package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ForumThreadsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ForumThreadsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ForumThreadsMessageParser);
        }

        public function getParser():ForumThreadsMessageParser
        {
            return (this._SafeStr_816 as ForumThreadsMessageParser);
        }


    }
}


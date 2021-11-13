package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ForumDataMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ForumDataMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ForumDataMessageParser);
        }

        public function getParser():ForumDataMessageParser
        {
            return (this._SafeStr_816 as ForumDataMessageParser);
        }


    }
}


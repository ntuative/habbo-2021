package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PostThreadMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PostThreadMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PostThreadMessageParser);
        }

        public function getParser():PostThreadMessageParser
        {
            return (this._SafeStr_816 as PostThreadMessageParser);
        }


    }
}


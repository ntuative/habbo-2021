package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PostMessageMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PostMessageMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PostMessageMessageParser);
        }

        public function getParser():PostMessageMessageParser
        {
            return (this._SafeStr_816 as PostMessageMessageParser);
        }


    }
}


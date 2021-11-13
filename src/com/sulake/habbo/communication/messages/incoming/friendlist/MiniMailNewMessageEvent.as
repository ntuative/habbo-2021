package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MiniMailNewMessageMessageParser;

        public class MiniMailNewMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function MiniMailNewMessageEvent(_arg_1:Function)
        {
            super(_arg_1, MiniMailNewMessageMessageParser);
        }

        public function getParser():MiniMailNewMessageMessageParser
        {
            return (_SafeStr_816 as MiniMailNewMessageMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MiniMailUnreadCountMessageParser;

        public class MiniMailUnreadCountEvent extends MessageEvent implements IMessageEvent 
    {

        public function MiniMailUnreadCountEvent(_arg_1:Function)
        {
            super(_arg_1, MiniMailUnreadCountMessageParser);
        }

        public function getParser():MiniMailUnreadCountMessageParser
        {
            return (_SafeStr_816 as MiniMailUnreadCountMessageParser);
        }


    }
}


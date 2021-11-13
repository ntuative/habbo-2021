package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationMessageParser;

        public class FriendNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, FriendNotificationMessageParser);
        }

        public function getParser():FriendNotificationMessageParser
        {
            return (_SafeStr_816 as FriendNotificationMessageParser);
        }


    }
}


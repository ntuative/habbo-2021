package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedMessageParser;

        public class FollowFriendFailedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FollowFriendFailedEvent(_arg_1:Function)
        {
            super(_arg_1, FollowFriendFailedMessageParser);
        }

        public function getParser():FollowFriendFailedMessageParser
        {
            return (this._SafeStr_816 as FollowFriendFailedMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendRequestsMessageParser;

        public class FriendRequestsEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendRequestsEvent(_arg_1:Function)
        {
            super(_arg_1, FriendRequestsMessageParser);
        }

        public function getParser():FriendRequestsMessageParser
        {
            return (this._SafeStr_816 as FriendRequestsMessageParser);
        }


    }
}


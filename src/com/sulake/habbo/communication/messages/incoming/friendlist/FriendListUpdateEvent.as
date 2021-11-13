package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;

        public class FriendListUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendListUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, FriendListUpdateMessageParser);
        }

        public function getParser():FriendListUpdateMessageParser
        {
            return (this._SafeStr_816 as FriendListUpdateMessageParser);
        }


    }
}


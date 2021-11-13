package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestMessageParser;

        public class NewFriendRequestEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewFriendRequestEvent(_arg_1:Function)
        {
            super(_arg_1, NewFriendRequestMessageParser);
        }

        public function getParser():NewFriendRequestMessageParser
        {
            return (this._SafeStr_816 as NewFriendRequestMessageParser);
        }


    }
}


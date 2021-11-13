package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;

        public class RoomInviteEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInviteEvent(_arg_1:Function)
        {
            super(_arg_1, RoomInviteMessageParser);
        }

        public function getParser():RoomInviteMessageParser
        {
            return (this._SafeStr_816 as RoomInviteMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser;

        public class RoomInviteErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInviteErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomInviteErrorMessageParser);
        }

        public function getParser():RoomInviteErrorMessageParser
        {
            return (this._SafeStr_816 as RoomInviteErrorMessageParser);
        }


    }
}


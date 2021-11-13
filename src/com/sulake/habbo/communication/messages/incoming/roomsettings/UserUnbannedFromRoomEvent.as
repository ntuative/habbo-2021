package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomParser;

        public class UserUnbannedFromRoomEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserUnbannedFromRoomEvent(_arg_1:Function)
        {
            super(_arg_1, UserUnbannedFromRoomParser);
        }

        public function getParser():UserUnbannedFromRoomParser
        {
            return (this._SafeStr_816 as UserUnbannedFromRoomParser);
        }


    }
}


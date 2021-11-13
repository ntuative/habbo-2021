package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class RoomChatSettingsMessageEvent extends MessageEvent 
    {

        public function RoomChatSettingsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomChatSettingsMessageParser);
        }

        public function getParser():RoomChatSettingsMessageParser
        {
            return (_SafeStr_816 as RoomChatSettingsMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class RoomFilterSettingsMessageEvent extends MessageEvent 
    {

        public function RoomFilterSettingsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomFilterSettingsMessageParser);
        }

        public function getParser():RoomFilterSettingsMessageParser
        {
            return (_SafeStr_816 as RoomFilterSettingsMessageParser);
        }


    }
}


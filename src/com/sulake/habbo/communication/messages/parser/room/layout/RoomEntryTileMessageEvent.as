package com.sulake.habbo.communication.messages.parser.room.layout
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class RoomEntryTileMessageEvent extends MessageEvent 
    {

        public function RoomEntryTileMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomEntryTileMessageParser);
        }

        public function getParser():RoomEntryTileMessageParser
        {
            return (_SafeStr_816 as RoomEntryTileMessageParser);
        }


    }
}


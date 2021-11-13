package com.sulake.habbo.communication.messages.parser.room.layout
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class RoomOccupiedTilesMessageEvent extends MessageEvent 
    {

        public function RoomOccupiedTilesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomOccupiedTilesMessageParser);
        }

        public function getParser():RoomOccupiedTilesMessageParser
        {
            return (_SafeStr_816 as RoomOccupiedTilesMessageParser);
        }


    }
}


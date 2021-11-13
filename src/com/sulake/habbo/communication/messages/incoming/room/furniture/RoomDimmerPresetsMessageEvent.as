package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageParser;

        public class RoomDimmerPresetsMessageEvent extends MessageEvent 
    {

        public function RoomDimmerPresetsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomDimmerPresetsMessageParser);
        }

        public function getParser():RoomDimmerPresetsMessageParser
        {
            return (_SafeStr_816 as RoomDimmerPresetsMessageParser);
        }


    }
}


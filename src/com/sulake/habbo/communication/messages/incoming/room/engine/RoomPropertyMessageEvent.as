package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;

        public class RoomPropertyMessageEvent extends MessageEvent 
    {

        public function RoomPropertyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomPropertyMessageParser);
        }

        public function getParser():RoomPropertyMessageParser
        {
            return (_SafeStr_816 as RoomPropertyMessageParser);
        }


    }
}


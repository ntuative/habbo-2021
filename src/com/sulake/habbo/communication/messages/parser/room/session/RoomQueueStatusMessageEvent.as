package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class RoomQueueStatusMessageEvent extends MessageEvent 
    {

        public function RoomQueueStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomQueueStatusMessageParser);
        }

        public function getParser():RoomQueueStatusMessageParser
        {
            return (_SafeStr_816 as RoomQueueStatusMessageParser);
        }


    }
}


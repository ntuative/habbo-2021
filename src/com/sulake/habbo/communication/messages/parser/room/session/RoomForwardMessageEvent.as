package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class RoomForwardMessageEvent extends MessageEvent 
    {

        public function RoomForwardMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomForwardMessageParser);
        }

        public function getParser():RoomForwardMessageParser
        {
            return (_SafeStr_816 as RoomForwardMessageParser);
        }


    }
}


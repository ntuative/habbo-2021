package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class RoomReadyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomReadyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomReadyMessageParser);
        }

        public function getParser():RoomReadyMessageParser
        {
            return (_SafeStr_816 as RoomReadyMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;

        public class RoomEntryInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomEntryInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomEntryInfoMessageParser);
        }

        public function getParser():RoomEntryInfoMessageParser
        {
            return (_SafeStr_816 as RoomEntryInfoMessageParser);
        }


    }
}


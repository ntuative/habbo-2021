package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;

        public class RoomInfoUpdatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInfoUpdatedEvent(_arg_1:Function)
        {
            super(_arg_1, RoomInfoUpdatedMessageParser);
        }

        public function getParser():RoomInfoUpdatedMessageParser
        {
            return (this._SafeStr_816 as RoomInfoUpdatedMessageParser);
        }


    }
}


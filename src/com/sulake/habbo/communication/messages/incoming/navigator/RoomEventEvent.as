package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;

        public class RoomEventEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomEventEvent(_arg_1:Function)
        {
            super(_arg_1, RoomEventMessageParser);
        }

        public function getParser():RoomEventMessageParser
        {
            return (this._SafeStr_816 as RoomEventMessageParser);
        }


    }
}


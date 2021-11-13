package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;

        public class CanCreateRoomEventEvent extends MessageEvent implements IMessageEvent 
    {

        public function CanCreateRoomEventEvent(_arg_1:Function)
        {
            super(_arg_1, CanCreateRoomEventMessageParser);
        }

        public function getParser():CanCreateRoomEventMessageParser
        {
            return (this._SafeStr_816 as CanCreateRoomEventMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;

        public class CanCreateRoomEvent extends MessageEvent implements IMessageEvent 
    {

        public function CanCreateRoomEvent(_arg_1:Function)
        {
            super(_arg_1, CanCreateRoomMessageParser);
        }

        public function getParser():CanCreateRoomMessageParser
        {
            return (this._SafeStr_816 as CanCreateRoomMessageParser);
        }


    }
}


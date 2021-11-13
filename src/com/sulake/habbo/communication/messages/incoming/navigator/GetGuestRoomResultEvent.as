package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;

        public class GetGuestRoomResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function GetGuestRoomResultEvent(_arg_1:Function)
        {
            super(_arg_1, GetGuestRoomResultMessageParser);
        }

        public function getParser():GetGuestRoomResultMessageParser
        {
            return (this._SafeStr_816 as GetGuestRoomResultMessageParser);
        }


    }
}


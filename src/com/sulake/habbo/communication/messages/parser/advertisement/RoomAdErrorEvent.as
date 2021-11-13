package com.sulake.habbo.communication.messages.parser.advertisement
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class RoomAdErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomAdErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomAdErrorMessageParser);
        }

        public function getParser():RoomAdErrorMessageParser
        {
            return (this._SafeStr_816 as RoomAdErrorMessageParser);
        }


    }
}


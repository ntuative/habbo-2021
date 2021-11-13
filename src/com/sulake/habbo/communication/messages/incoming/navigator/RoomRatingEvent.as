package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;

        public class RoomRatingEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomRatingEvent(_arg_1:Function)
        {
            super(_arg_1, RoomRatingMessageParser);
        }

        public function getParser():RoomRatingMessageParser
        {
            return (this._SafeStr_816 as RoomRatingMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentOkMessageParser;

        public class RentableSpaceRentOkMessageEvent extends MessageEvent 
    {

        public function RentableSpaceRentOkMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RentableSpaceRentOkMessageParser);
        }

        public function getParser():RentableSpaceRentOkMessageParser
        {
            return (parser as RentableSpaceRentOkMessageParser);
        }


    }
}
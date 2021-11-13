package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceStatusMessageParser;

        public class RentableSpaceStatusMessageEvent extends MessageEvent 
    {

        public function RentableSpaceStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RentableSpaceStatusMessageParser);
        }

        public function getParser():RentableSpaceStatusMessageParser
        {
            return (parser as RentableSpaceStatusMessageParser);
        }


    }
}
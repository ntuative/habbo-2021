package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;

        public class OneWayDoorStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OneWayDoorStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OneWayDoorStatusMessageParser);
        }

        public function getParser():OneWayDoorStatusMessageParser
        {
            return (_SafeStr_816 as OneWayDoorStatusMessageParser);
        }


    }
}


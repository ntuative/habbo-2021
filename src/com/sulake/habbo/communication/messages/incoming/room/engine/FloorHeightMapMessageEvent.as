package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;

        public class FloorHeightMapMessageEvent extends MessageEvent 
    {

        public function FloorHeightMapMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FloorHeightMapMessageParser);
        }

        public function getParser():FloorHeightMapMessageParser
        {
            return (_SafeStr_816 as FloorHeightMapMessageParser);
        }


    }
}


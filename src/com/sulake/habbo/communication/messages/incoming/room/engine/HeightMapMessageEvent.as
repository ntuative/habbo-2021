package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;

        public class HeightMapMessageEvent extends MessageEvent 
    {

        public function HeightMapMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HeightMapMessageParser);
        }

        public function getParser():HeightMapMessageParser
        {
            return (_SafeStr_816 as HeightMapMessageParser);
        }


    }
}


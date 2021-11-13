package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;

        public class HeightMapUpdateMessageEvent extends MessageEvent 
    {

        public function HeightMapUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HeightMapUpdateMessageParser);
        }

        public function getParser():HeightMapUpdateMessageParser
        {
            return (_SafeStr_816 as HeightMapUpdateMessageParser);
        }


    }
}


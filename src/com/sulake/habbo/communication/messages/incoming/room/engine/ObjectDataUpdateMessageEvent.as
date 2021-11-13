package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;

        public class ObjectDataUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectDataUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectDataUpdateMessageParser);
        }

        public function getParser():ObjectDataUpdateMessageParser
        {
            return (_SafeStr_816 as ObjectDataUpdateMessageParser);
        }


    }
}


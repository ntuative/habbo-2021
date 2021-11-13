package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;

        public class ObjectsMessageEvent extends MessageEvent 
    {

        public function ObjectsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectsMessageParser);
        }

        public function getParser():ObjectsMessageParser
        {
            return (_SafeStr_816 as ObjectsMessageParser);
        }


    }
}


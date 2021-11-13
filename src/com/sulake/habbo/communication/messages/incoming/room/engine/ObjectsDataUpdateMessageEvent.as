package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageParser;

        public class ObjectsDataUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectsDataUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectsDataUpdateMessageParser);
        }

        public function getParser():ObjectsDataUpdateMessageParser
        {
            return (_SafeStr_816 as ObjectsDataUpdateMessageParser);
        }


    }
}


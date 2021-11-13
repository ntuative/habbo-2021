package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;

        public class ObjectUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectUpdateMessageParser);
        }

        public function getParser():ObjectUpdateMessageParser
        {
            return (_SafeStr_816 as ObjectUpdateMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;

        public class ObjectAddMessageEvent extends MessageEvent 
    {

        public function ObjectAddMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectAddMessageParser);
        }

        public function getParser():ObjectAddMessageParser
        {
            return (_SafeStr_816 as ObjectAddMessageParser);
        }


    }
}


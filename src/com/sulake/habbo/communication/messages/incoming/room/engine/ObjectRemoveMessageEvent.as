package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;

        public class ObjectRemoveMessageEvent extends MessageEvent 
    {

        public function ObjectRemoveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectRemoveMessageParser);
        }

        public function getParser():ObjectRemoveMessageParser
        {
            return (_SafeStr_816 as ObjectRemoveMessageParser);
        }


    }
}


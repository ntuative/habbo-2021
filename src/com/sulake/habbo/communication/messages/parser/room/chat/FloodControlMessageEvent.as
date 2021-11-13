package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class FloodControlMessageEvent extends MessageEvent 
    {

        public function FloodControlMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FloodControlMessageParser);
        }

        public function getParser():FloodControlMessageParser
        {
            return (_SafeStr_816 as FloodControlMessageParser);
        }


    }
}


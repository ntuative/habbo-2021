package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class DanceMessageEvent extends MessageEvent 
    {

        public function DanceMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DanceMessageParser);
        }

        public function getParser():DanceMessageParser
        {
            return (_SafeStr_816 as DanceMessageParser);
        }


    }
}


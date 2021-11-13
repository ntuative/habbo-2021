package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class SleepMessageEvent extends MessageEvent 
    {

        public function SleepMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SleepMessageParser);
        }

        public function getParser():SleepMessageParser
        {
            return (_SafeStr_816 as SleepMessageParser);
        }


    }
}


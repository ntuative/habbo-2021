package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class OpenConnectionMessageEvent extends MessageEvent 
    {

        public function OpenConnectionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OpenConnectionMessageParser);
        }

        public function getParser():OpenConnectionMessageParser
        {
            return (_SafeStr_816 as OpenConnectionMessageParser);
        }


    }
}


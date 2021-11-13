package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class CantConnectMessageEvent extends MessageEvent 
    {

        public function CantConnectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CantConnectMessageParser);
        }

        public function getParser():CantConnectMessageParser
        {
            return (_SafeStr_816 as CantConnectMessageParser);
        }


    }
}


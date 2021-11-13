package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class SecondsUntilMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SecondsUntilMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SecondsUntilMessageParser);
        }

        public function getParser():SecondsUntilMessageParser
        {
            return (_SafeStr_816 as SecondsUntilMessageParser);
        }


    }
}


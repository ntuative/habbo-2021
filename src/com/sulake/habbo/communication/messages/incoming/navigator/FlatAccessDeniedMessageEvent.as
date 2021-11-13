package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;

        public class FlatAccessDeniedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatAccessDeniedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FlatAccessDeniedMessageParser);
        }

        public function getParser():FlatAccessDeniedMessageParser
        {
            return (_SafeStr_816 as FlatAccessDeniedMessageParser);
        }


    }
}


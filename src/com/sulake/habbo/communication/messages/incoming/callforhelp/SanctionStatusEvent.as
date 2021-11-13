package com.sulake.habbo.communication.messages.incoming.callforhelp
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.callforhelp.SanctionStatusMessageParser;

        public class SanctionStatusEvent extends MessageEvent implements IMessageEvent 
    {

        public function SanctionStatusEvent(_arg_1:Function)
        {
            super(_arg_1, SanctionStatusMessageParser);
        }

        public function getParser():SanctionStatusMessageParser
        {
            return (_SafeStr_816 as SanctionStatusMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageParser;

        public class ScrSendKickbackInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ScrSendKickbackInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ScrSendKickbackInfoMessageParser);
        }

        public function getParser():ScrSendKickbackInfoMessageParser
        {
            return (_SafeStr_816 as ScrSendKickbackInfoMessageParser);
        }


    }
}


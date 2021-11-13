package com.sulake.habbo.communication.messages.parser.gifts
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class TryVerificationCodeResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TryVerificationCodeResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TryVerificationCodeResultParser);
        }

        public function getParser():TryVerificationCodeResultParser
        {
            return (_SafeStr_816 as TryVerificationCodeResultParser);
        }


    }
}


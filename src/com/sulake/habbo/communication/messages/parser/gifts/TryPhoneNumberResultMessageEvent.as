package com.sulake.habbo.communication.messages.parser.gifts
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class TryPhoneNumberResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TryPhoneNumberResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TryPhoneNumberResultParser);
        }

        public function getParser():TryPhoneNumberResultParser
        {
            return (_SafeStr_816 as TryPhoneNumberResultParser);
        }


    }
}


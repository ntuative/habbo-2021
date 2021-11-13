package com.sulake.habbo.communication.messages.parser.gifts
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class PhoneCollectionStateMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PhoneCollectionStateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PhoneCollectionStateParser);
        }

        public function getParser():PhoneCollectionStateParser
        {
            return (_SafeStr_816 as PhoneCollectionStateParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.userclassification
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class UserClassificationMessageEvent extends MessageEvent 
    {

        public function UserClassificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserClassificationMessageParser);
        }

        public function getParser():UserClassificationMessageParser
        {
            return (_SafeStr_816 as UserClassificationMessageParser);
        }


    }
}


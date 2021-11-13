package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;

        public class UserNameChangedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserNameChangedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserNameChangedMessageParser);
        }

        public function getParser():UserNameChangedMessageParser
        {
            return (_SafeStr_816 as UserNameChangedMessageParser);
        }


    }
}


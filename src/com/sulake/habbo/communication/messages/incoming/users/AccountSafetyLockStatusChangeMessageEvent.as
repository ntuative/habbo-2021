package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.AccountSafetyLockStatusChangeMessageParser;

        public class AccountSafetyLockStatusChangeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AccountSafetyLockStatusChangeMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AccountSafetyLockStatusChangeMessageParser);
        }

        public function getParser():AccountSafetyLockStatusChangeMessageParser
        {
            return (_SafeStr_816 as AccountSafetyLockStatusChangeMessageParser);
        }


    }
}


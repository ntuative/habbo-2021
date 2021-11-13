package com.sulake.habbo.communication.messages.parser.preferences
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class AccountPreferencesEvent extends MessageEvent implements IMessageEvent 
    {

        public function AccountPreferencesEvent(_arg_1:Function)
        {
            super(_arg_1, AccountPreferencesParser);
        }

        public function getParser():AccountPreferencesParser
        {
            return (this._SafeStr_816 as AccountPreferencesParser);
        }


    }
}


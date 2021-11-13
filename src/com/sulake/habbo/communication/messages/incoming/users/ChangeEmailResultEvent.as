package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ChangeEmailResultParser;

        public class ChangeEmailResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function ChangeEmailResultEvent(_arg_1:Function)
        {
            super(_arg_1, ChangeEmailResultParser);
        }

        public function getParser():ChangeEmailResultParser
        {
            return (_SafeStr_816 as ChangeEmailResultParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.PetSupplementedNotificationParser;

        public class PetSupplementedNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetSupplementedNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, PetSupplementedNotificationParser);
        }

        public function getParser():PetSupplementedNotificationParser
        {
            return (_SafeStr_816 as PetSupplementedNotificationParser);
        }


    }
}


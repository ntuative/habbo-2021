package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationParser;

        public class PetRespectNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRespectNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, PetRespectNotificationParser);
        }

        public function getParser():PetRespectNotificationParser
        {
            return (_SafeStr_816 as PetRespectNotificationParser);
        }


    }
}


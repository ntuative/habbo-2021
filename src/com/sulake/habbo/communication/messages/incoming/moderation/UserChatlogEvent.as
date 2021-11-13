package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogMessageParser;

        public class UserChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserChatlogEvent(_arg_1:Function)
        {
            super(_arg_1, UserChatlogMessageParser);
        }

        public function getParser():UserChatlogMessageParser
        {
            return (_SafeStr_816 as UserChatlogMessageParser);
        }


    }
}


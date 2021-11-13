package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;

        public class UserBannedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserBannedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserBannedMessageParser);
        }

        public function getParser():UserBannedMessageParser
        {
            return (_SafeStr_816 as UserBannedMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildMemberMgmtFailedMessageParser;

        public class GuildMemberMgmtFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildMemberMgmtFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildMemberMgmtFailedMessageParser);
        }

        public function get reason():int
        {
            return (GuildMemberMgmtFailedMessageParser(_SafeStr_816).reason);
        }

        public function get guildId():int
        {
            return (GuildMemberMgmtFailedMessageParser(_SafeStr_816).guildId);
        }


    }
}


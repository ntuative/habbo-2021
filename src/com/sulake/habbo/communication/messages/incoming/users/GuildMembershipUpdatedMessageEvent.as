package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildMembershipUpdatedMessageParser;

        public class GuildMembershipUpdatedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildMembershipUpdatedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildMembershipUpdatedMessageParser);
        }

        public function get data():MemberData
        {
            return (GuildMembershipUpdatedMessageParser(_SafeStr_816).data);
        }

        public function get guildId():int
        {
            return (GuildMembershipUpdatedMessageParser(_SafeStr_816).guildId);
        }


    }
}


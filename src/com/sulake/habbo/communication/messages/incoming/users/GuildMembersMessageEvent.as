package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildMembersMessageParser;

        public class GuildMembersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildMembersMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildMembersMessageParser);
        }

        public function get data():GuildMemberData
        {
            return (GuildMembersMessageParser(_SafeStr_816).data);
        }


    }
}


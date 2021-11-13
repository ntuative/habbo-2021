package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildMembershipsMessageParser;

        public class GuildMembershipsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildMembershipsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildMembershipsMessageParser);
        }

        public function get guilds():Array
        {
            return (GuildMembershipsMessageParser(_SafeStr_816).guilds);
        }


    }
}


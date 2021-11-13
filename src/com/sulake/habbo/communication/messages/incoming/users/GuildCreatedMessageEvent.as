package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildCreatedMessageParser;

        public class GuildCreatedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildCreatedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildCreatedMessageParser);
        }

        public function get baseRoomId():int
        {
            return (GuildCreatedMessageParser(_SafeStr_816).baseRoomId);
        }

        public function get groupId():int
        {
            return (GuildCreatedMessageParser(_SafeStr_816).groupId);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildMemberFurniCountInHQMessageParser;

        public class GuildMemberFurniCountInHQMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildMemberFurniCountInHQMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildMemberFurniCountInHQMessageParser);
        }

        public function userId():int
        {
            return (GuildMemberFurniCountInHQMessageParser(_SafeStr_816).userId);
        }

        public function furniCount():int
        {
            return (GuildMemberFurniCountInHQMessageParser(_SafeStr_816).furniCount);
        }


    }
}


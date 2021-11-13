package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildEditInfoMessageParser;

        public class GuildEditInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildEditInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildEditInfoMessageParser);
        }

        public function get data():GuildEditData
        {
            return (GuildEditInfoMessageParser(_SafeStr_816).data);
        }


    }
}


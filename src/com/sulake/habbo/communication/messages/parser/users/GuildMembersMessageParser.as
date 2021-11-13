package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMembersMessageParser implements IMessageParser 
    {

        private var _data:GuildMemberData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new GuildMemberData(_arg_1);
            return (true);
        }

        public function get data():GuildMemberData
        {
            return (_data);
        }


    }
}
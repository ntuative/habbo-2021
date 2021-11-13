package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.MemberData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMembershipUpdatedMessageParser implements IMessageParser 
    {

        private var _guildId:int;
        private var _data:MemberData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _guildId = _arg_1.readInteger();
            _data = new MemberData(_arg_1);
            return (true);
        }

        public function get guildId():int
        {
            return (_guildId);
        }

        public function get data():MemberData
        {
            return (_data);
        }


    }
}
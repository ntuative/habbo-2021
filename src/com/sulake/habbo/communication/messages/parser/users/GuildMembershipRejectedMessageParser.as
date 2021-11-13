package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMembershipRejectedMessageParser implements IMessageParser 
    {

        private var _guildId:int;
        private var _userId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _guildId = _arg_1.readInteger();
            _userId = _arg_1.readInteger();
            return (true);
        }

        public function get guildId():int
        {
            return (_guildId);
        }

        public function get userId():int
        {
            return (_userId);
        }


    }
}
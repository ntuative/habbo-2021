package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMemberMgmtFailedMessageParser implements IMessageParser 
    {

        private var _guildId:int;
        private var _reason:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _guildId = _arg_1.readInteger();
            _reason = _arg_1.readInteger();
            return (true);
        }

        public function get guildId():int
        {
            return (_guildId);
        }

        public function get reason():int
        {
            return (_reason);
        }


    }
}
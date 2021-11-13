package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreationData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildCreationInfoMessageParser implements IMessageParser 
    {

        private var _data:GuildCreationData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new GuildCreationData(_arg_1);
            return (true);
        }

        public function get data():GuildCreationData
        {
            return (_data);
        }


    }
}
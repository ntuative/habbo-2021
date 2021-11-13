package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildEditInfoMessageParser implements IMessageParser 
    {

        private var _data:GuildEditData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new GuildEditData(_arg_1);
            return (true);
        }

        public function get data():GuildEditData
        {
            return (_data);
        }


    }
}
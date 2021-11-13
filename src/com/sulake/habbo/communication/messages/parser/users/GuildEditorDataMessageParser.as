package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditorData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildEditorDataMessageParser implements IMessageParser 
    {

        private var _data:GuildEditorData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new GuildEditorData(_arg_1);
            return (true);
        }

        public function get data():GuildEditorData
        {
            return (_data);
        }


    }
}
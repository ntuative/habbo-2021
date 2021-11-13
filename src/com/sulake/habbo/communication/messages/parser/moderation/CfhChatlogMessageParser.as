package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CfhChatlogMessageParser implements IMessageParser 
    {

        private var _data:CfhChatlogData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new CfhChatlogData(_arg_1);
            return (true);
        }

        public function get data():CfhChatlogData
        {
            return (_data);
        }


    }
}
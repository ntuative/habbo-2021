package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboGroupDetailsMessageParser implements IMessageParser 
    {

        private var _data:HabboGroupDetailsData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new HabboGroupDetailsData(_arg_1);
            return (true);
        }

        public function get data():HabboGroupDetailsData
        {
            return (_data);
        }


    }
}
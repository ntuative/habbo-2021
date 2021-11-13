package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMembershipsMessageParser implements IMessageParser 
    {

        private var _guilds:Array = [];


        public function flush():Boolean
        {
            _guilds = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _guilds.push(new HabboGroupEntryData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get guilds():Array
        {
            return (_guilds);
        }


    }
}
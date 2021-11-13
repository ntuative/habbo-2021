package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomVisitsMessageParser implements IMessageParser 
    {

        private var _data:RoomVisitsData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new RoomVisitsData(_arg_1);
            return (true);
        }

        public function get data():RoomVisitsData
        {
            return (_data);
        }


    }
}
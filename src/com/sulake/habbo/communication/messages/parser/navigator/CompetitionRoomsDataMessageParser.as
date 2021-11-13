package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CompetitionRoomsDataMessageParser implements IMessageParser 
    {

        private var _data:CompetitionRoomsData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new CompetitionRoomsData(_arg_1);
            return (true);
        }

        public function get data():CompetitionRoomsData
        {
            return (_data);
        }


    }
}
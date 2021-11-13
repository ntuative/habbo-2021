package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboClubOffersMessageParser implements IMessageParser 
    {

        private var _offers:Array;
        private var _source:int;


        public function flush():Boolean
        {
            _offers = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _offers = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _offers.push(new ClubOfferData(_arg_1));
                _local_3++;
            };
            _source = _arg_1.readInteger();
            return (true);
        }

        public function get offers():Array
        {
            return (_offers);
        }

        public function get source():int
        {
            return (_source);
        }


    }
}
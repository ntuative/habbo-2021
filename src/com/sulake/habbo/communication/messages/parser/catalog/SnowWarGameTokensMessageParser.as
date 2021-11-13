package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SnowWarGameTokensMessageParser implements IMessageParser 
    {

        private var _offers:Array;


        public function flush():Boolean
        {
            _offers = [];
            return (true);
        }

        public function get offers():Array
        {
            return (_offers);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _offers = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _offers.push(new SnowWarGameTokenOffer(_arg_1));
                _local_3++;
            };
            return (true);
        }


    }
}
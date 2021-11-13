package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ClubGiftInfoParser implements IMessageParser 
    {

        private var _daysUntilNextGift:int;
        private var _giftsAvailable:int;
        private var _offers:Array;
        private var _giftData:Map;


        public function flush():Boolean
        {
            if (_giftData)
            {
                _giftData.dispose();
                _giftData = null;
            };
            _offers = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_2:ClubGiftData;
            _daysUntilNextGift = _arg_1.readInteger();
            _giftsAvailable = _arg_1.readInteger();
            _offers = [];
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _offers.push(new CatalogPageMessageOfferData(_arg_1));
                _local_4++;
            };
            _giftData = new Map();
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = new ClubGiftData(_arg_1);
                _giftData.add(_local_2.offerId, _local_2);
                _local_4++;
            };
            return (true);
        }

        public function get daysUntilNextGift():int
        {
            return (_daysUntilNextGift);
        }

        public function get giftsAvailable():int
        {
            return (_giftsAvailable);
        }

        public function get offers():Array
        {
            return (_offers);
        }

        public function get giftData():Map
        {
            return (_giftData);
        }


    }
}
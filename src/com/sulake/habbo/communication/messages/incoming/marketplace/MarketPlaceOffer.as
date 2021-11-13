package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.habbo.room.IStuffData;

        public class MarketPlaceOffer 
    {

        private var _offerId:int;
        private var _furniId:int;
        private var _furniType:int;
        private var _extraData:String;
        private var _stuffData:IStuffData;
        private var _price:int;
        private var _status:int;
        private var _timeLeftMinutes:int = -1;
        private var _averagePrice:int;
        private var _offerCount:int;

        public function MarketPlaceOffer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:IStuffData, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int=-1)
        {
            _offerId = _arg_1;
            _furniId = _arg_2;
            _furniType = _arg_3;
            _extraData = _arg_4;
            _stuffData = _arg_5;
            _price = _arg_6;
            _status = _arg_7;
            _timeLeftMinutes = _arg_8;
            _averagePrice = _arg_9;
            _offerCount = _arg_10;
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get furniId():int
        {
            return (_furniId);
        }

        public function get furniType():int
        {
            return (_furniType);
        }

        public function get extraData():String
        {
            return (_extraData);
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }

        public function get price():int
        {
            return (_price);
        }

        public function get status():int
        {
            return (_status);
        }

        public function get timeLeftMinutes():int
        {
            return (_timeLeftMinutes);
        }

        public function get averagePrice():int
        {
            return (_averagePrice);
        }

        public function get offerCount():int
        {
            return (_offerCount);
        }


    }
}
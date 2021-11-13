package com.sulake.habbo.catalog.marketplace
{
    import com.sulake.habbo.room.IStuffData;
    import flash.display.BitmapData;

    public class MarketPlaceOfferData implements IMarketPlaceOfferData 
    {

        public static const _SafeStr_1457:int = 1;
        public static const _SafeStr_1458:int = 2;

        private var _offerId:int;
        private var _furniId:int;
        private var _furniType:int;
        private var _extraData:String;
        private var _stuffData:IStuffData;
        private var _price:int;
        private var _averagePrice:int;
        private var _imageCallback:int;
        private var _status:int;
        private var _timeLeftMinutes:int = -1;
        private var _offerCount:int;
        private var _image:BitmapData;

        public function MarketPlaceOfferData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:IStuffData, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int=-1)
        {
            _offerId = _arg_1;
            _furniId = _arg_2;
            _furniType = _arg_3;
            _extraData = _arg_4;
            _stuffData = _arg_5;
            _price = _arg_6;
            _status = _arg_7;
            _averagePrice = _arg_8;
            _offerCount = _arg_9;
        }

        public function dispose():void
        {
            if (_image)
            {
                _image.dispose();
                _image = null;
            };
            if (_stuffData)
            {
                _stuffData = null;
            };
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

        public function get averagePrice():int
        {
            return (_averagePrice);
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function set image(_arg_1:BitmapData):void
        {
            if (_image != null)
            {
                _image.dispose();
            };
            _image = _arg_1;
        }

        public function set imageCallback(_arg_1:int):void
        {
            _imageCallback = _arg_1;
        }

        public function get imageCallback():int
        {
            return (_imageCallback);
        }

        public function get status():int
        {
            return (_status);
        }

        public function get timeLeftMinutes():int
        {
            return (_timeLeftMinutes);
        }

        public function set timeLeftMinutes(_arg_1:int):void
        {
            _timeLeftMinutes = _arg_1;
        }

        public function set price(_arg_1:int):void
        {
            _price = _arg_1;
        }

        public function set offerId(_arg_1:int):void
        {
            _offerId = _arg_1;
        }

        public function get offerCount():int
        {
            return (_offerCount);
        }

        public function set offerCount(_arg_1:int):void
        {
            _offerCount = _arg_1;
        }

        public function get isUniqueLimitedItem():Boolean
        {
            return ((!(stuffData == null)) && (stuffData.uniqueSerialNumber > 0));
        }


    }
}


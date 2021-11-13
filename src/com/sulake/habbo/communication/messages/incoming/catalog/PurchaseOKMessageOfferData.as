package com.sulake.habbo.communication.messages.incoming.catalog
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PurchaseOKMessageOfferData 
    {

        private var _offerId:int;
        private var _localizationId:String;
        private var _isRent:Boolean;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _clubLevel:int;
        private var _giftable:Boolean;
        private var _bundlePurchaseAllowed:Boolean;
        private var _products:Vector.<CatalogPageMessageProductData>;

        public function PurchaseOKMessageOfferData(_arg_1:IMessageDataWrapper)
        {
            var _local_2:int;
            super();
            _offerId = _arg_1.readInteger();
            _localizationId = _arg_1.readString();
            _isRent = _arg_1.readBoolean();
            _priceInCredits = _arg_1.readInteger();
            _priceInActivityPoints = _arg_1.readInteger();
            _activityPointType = _arg_1.readInteger();
            _giftable = _arg_1.readBoolean();
            var _local_3:int = _arg_1.readInteger();
            _products = new Vector.<CatalogPageMessageProductData>(0);
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _products.push(new CatalogPageMessageProductData(_arg_1));
                _local_2++;
            };
            _clubLevel = _arg_1.readInteger();
            _bundlePurchaseAllowed = _arg_1.readBoolean();
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get localizationId():String
        {
            return (_localizationId);
        }

        public function get isRent():Boolean
        {
            return (_isRent);
        }

        public function get priceInCredits():int
        {
            return (_priceInCredits);
        }

        public function get priceInActivityPoints():int
        {
            return (_priceInActivityPoints);
        }

        public function get products():Vector.<CatalogPageMessageProductData>
        {
            return (_products);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }

        public function get giftable():Boolean
        {
            return (_giftable);
        }

        public function get bundlePurchaseAllowed():Boolean
        {
            return (_bundlePurchaseAllowed);
        }


    }
}
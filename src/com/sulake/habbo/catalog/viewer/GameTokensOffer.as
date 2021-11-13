package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.runtime.IDisposable;

    public class GameTokensOffer implements IPurchasableOffer, IDisposable 
    {

        private var _offerId:int;
        private var _localizationId:String;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;

        public function GameTokensOffer(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            _offerId = _arg_1;
            _localizationId = _arg_2;
            _priceInCredits = _arg_3;
            _priceInActivityPoints = _arg_4;
            _activityPointType = _arg_5;
        }

        public function dispose():void
        {
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get priceInActivityPoints():int
        {
            return (_priceInActivityPoints);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function get priceInCredits():int
        {
            return (_priceInCredits);
        }

        public function get page():ICatalogPage
        {
            return (null);
        }

        public function get priceType():String
        {
            return ("price_type_credits");
        }

        public function get productContainer():IProductContainer
        {
            return (null);
        }

        public function get product():IProduct
        {
            return ((productContainer) ? productContainer.firstProduct : null);
        }

        public function get gridItem():IGridItem
        {
            return (null);
        }

        public function get localizationId():String
        {
            return (_localizationId);
        }

        public function get bundlePurchaseAllowed():Boolean
        {
            return (false);
        }

        public function get isRentOffer():Boolean
        {
            return (false);
        }

        public function get giftable():Boolean
        {
            return (false);
        }

        public function get pricingModel():String
        {
            return ("");
        }

        public function set previewCallbackId(_arg_1:int):void
        {
        }

        public function get previewCallbackId():int
        {
            return (0);
        }

        public function get clubLevel():int
        {
            return (0);
        }

        public function get badgeCode():String
        {
            return ("");
        }

        public function set page(_arg_1:ICatalogPage):void
        {
        }

        public function get localizationName():String
        {
            return (("${" + localizationId) + "}");
        }

        public function get localizationDescription():String
        {
            return (("${" + localizationId) + "}");
        }


    }
}
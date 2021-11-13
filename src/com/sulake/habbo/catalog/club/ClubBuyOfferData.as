package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.IGridItem;

    public class ClubBuyOfferData implements IPurchasableOffer 
    {

        private var _offerId:int;
        private var _localizationId:String;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _vip:Boolean;
        private var _months:int;
        private var _daysLeftAfterPurchase:int;
        private var _page:ICatalogPage;
        private var _year:int;
        private var _month:int;
        private var _day:int;
        private var _extraParameter:String;
        private var _upgradeHcPeriodToVip:Boolean = false;
        private var _disposed:Boolean = false;
        private var _extraDays:int;
        private var _giftable:Boolean;

        public function ClubBuyOfferData(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:int, _arg_12:int, _arg_13:Boolean=false)
        {
            _offerId = _arg_1;
            _localizationId = _arg_2;
            _priceInCredits = _arg_3;
            _priceInActivityPoints = _arg_4;
            _activityPointType = _arg_5;
            _vip = _arg_6;
            _months = _arg_7;
            _extraDays = _arg_8;
            _daysLeftAfterPurchase = _arg_9;
            _year = _arg_10;
            _month = _arg_11;
            _day = _arg_12;
            _giftable = _arg_13;
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _disposed = true;
            _page = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get extraParameter():String
        {
            return (_extraParameter);
        }

        public function set extraParameter(_arg_1:String):void
        {
            _extraParameter = _arg_1;
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get productCode():String
        {
            return (_localizationId);
        }

        public function get priceCredits():int
        {
            return (_priceInCredits);
        }

        public function get vip():Boolean
        {
            return (_vip);
        }

        public function get months():int
        {
            return (_months);
        }

        public function get daysLeftAfterPurchase():int
        {
            return (_daysLeftAfterPurchase);
        }

        public function get year():int
        {
            return (_year);
        }

        public function get month():int
        {
            return (_month);
        }

        public function get day():int
        {
            return (_day);
        }

        public function get isGiftable():Boolean
        {
            return (_giftable);
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
            return (_page);
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

        public function set page(_arg_1:ICatalogPage):void
        {
            _page = _arg_1;
        }

        public function get upgradeHcPeriodToVip():Boolean
        {
            return (_upgradeHcPeriodToVip);
        }

        public function set upgradeHcPeriodToVip(_arg_1:Boolean):void
        {
            _upgradeHcPeriodToVip = _arg_1;
        }

        public function get extraDays():int
        {
            return (_extraDays);
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
            return (_giftable);
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
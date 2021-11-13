package com.sulake.habbo.catalog.targetedoffers.data
{
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferData;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.IProductContainer;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import flash.utils.getTimer;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.session.product.IProductData;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.IHabboCatalog;

    public class TargetedOffer extends TargetedOfferData implements IPurchasableOffer 
    {

        public static const _SafeStr_1499:int = 10;

        public function TargetedOffer(_arg_1:TargetedOfferData=null)
        {
            super(_arg_1);
        }

        public function get offerId():int
        {
            return (0);
        }

        public function get page():ICatalogPage
        {
            return (null);
        }

        public function set page(_arg_1:ICatalogPage):void
        {
        }

        public function get priceType():String
        {
            return ("");
        }

        public function get product():IProduct
        {
            return (null);
        }

        public function get productContainer():IProductContainer
        {
            return (null);
        }

        public function get gridItem():IGridItem
        {
            return (null);
        }

        public function get localizationId():String
        {
            return ("");
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

        public function get previewCallbackId():int
        {
            return (0);
        }

        public function set previewCallbackId(_arg_1:int):void
        {
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
            return ("");
        }

        public function get localizationDescription():String
        {
            return ("");
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function isExpired():Boolean
        {
            return ((_expirationTime > 0) && (getSecondsRemaining() <= 0));
        }

        public function getSecondsRemaining():int
        {
            var _local_1:uint = uint((((_expirationTime - getTimer()) / 1000) - 10));
            return (Math.max(0, _local_1));
        }

        public function checkPurseBalance(_arg_1:IPurse, _arg_2:int):Boolean
        {
            if (((!(_arg_1)) || (_arg_1.credits < (_SafeStr_1500 * _arg_2))))
            {
                return (false);
            };
            if (_arg_1.getActivityPointsForType(_SafeStr_1501) < (_SafeStr_1502 * _arg_2))
            {
                return (false);
            };
            return (true);
        }

        public function getLocalizedSubProductNames(_arg_1:IHabboCatalog):Vector.<String>
        {
            var _local_4:IProductData;
            var _local_2:Vector.<String> = new Vector.<String>(0);
            for each (var _local_3:String in _SafeStr_1503)
            {
                _local_4 = _arg_1.getProductData(_local_3);
                _local_2.push(((_local_4) ? _local_4.name : _local_3));
            };
            return (_local_2);
        }

        public function dispose():void
        {
        }


    }
}


package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.HabboCatalog;

    public class FurnitureOffer implements IPurchasableOffer 
    {

        private var _SafeStr_1492:IFurnitureData;
        private var _previewCallbackId:int;
        private var _page:ICatalogPage;
        private var _productContainer:FurniProductContainer;
        private var _product:Product;

        public function FurnitureOffer(_arg_1:IFurnitureData, _arg_2:HabboCatalog)
        {
            _SafeStr_1492 = _arg_1;
            _productContainer = new FurniProductContainer(this, new Vector.<IProduct>(0), _arg_2, _SafeStr_1492);
            _product = new Product(_SafeStr_1492.type, _SafeStr_1492.id, _SafeStr_1492.customParams, 1, _arg_2.getProductData(_SafeStr_1492.className), _SafeStr_1492, _arg_2);
        }

        public function dispose():void
        {
            _SafeStr_1492 = null;
            _page = null;
            _previewCallbackId = -1;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1492 == null);
        }

        public function get offerId():int
        {
            return ((isRentOffer) ? _SafeStr_1492.rentOfferId : _SafeStr_1492.purchaseOfferId);
        }

        public function get priceInActivityPoints():int
        {
            return (0);
        }

        public function get activityPointType():int
        {
            return (0);
        }

        public function get priceInCredits():int
        {
            return (0);
        }

        public function get page():ICatalogPage
        {
            return (_page);
        }

        public function get priceType():String
        {
            return ("");
        }

        public function get productContainer():IProductContainer
        {
            return (_productContainer);
        }

        public function get product():IProduct
        {
            return (_product);
        }

        public function get gridItem():IGridItem
        {
            return (_productContainer as IGridItem);
        }

        public function get localizationId():String
        {
            return ("roomItem.name." + _SafeStr_1492.id);
        }

        public function get bundlePurchaseAllowed():Boolean
        {
            return (false);
        }

        public function get isRentOffer():Boolean
        {
            return ((_SafeStr_1492.rentOfferId > -1) && (!((!(_page == null)) && (_page.isBuilderPage))));
        }

        public function get giftable():Boolean
        {
            return (false);
        }

        public function get pricingModel():String
        {
            return ("pricing_model_furniture");
        }

        public function set previewCallbackId(_arg_1:int):void
        {
            _previewCallbackId = _arg_1;
        }

        public function get previewCallbackId():int
        {
            return (_previewCallbackId);
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
            _page = _arg_1;
        }

        public function get localizationName():String
        {
            return (_SafeStr_1492.localizedName);
        }

        public function get localizationDescription():String
        {
            return (_SafeStr_1492.description);
        }


    }
}


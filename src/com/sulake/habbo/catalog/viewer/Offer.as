package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;

    public class Offer implements IPurchasableOffer 
    {

        public static const PRICING_MODEL_UNKNOWN:String = "pricing_model_unknown";
        public static const PRICING_MODEL_SINGLE:String = "pricing_model_single";
        public static const PRICING_MODEL_MULTI:String = "pricing_model_multi";
        public static const PRICING_MODEL_BUNDLE:String = "pricing_model_bundle";
        public static const PRICING_MODEL_FURNI:String = "pricing_model_furniture";
        public static const PRICE_TYPE_NONE:String = "price_type_none";
        public static const PRICE_TYPE_CREDITS:String = "price_type_credits";
        public static const PRICE_TYPE_ACTIVITYPOINTS:String = "price_type_activitypoints";
        public static const PRICE_TYPE_CREDITS_AND_ACTIVITYPOINTS:String = "price_type_credits_and_activitypoints";

        private var _pricingModel:String;
        private var _priceType:String;
        private var _offerId:int;
        private var _localizationId:String;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _giftable:Boolean;
        private var _isRentOffer:Boolean;
        private var _page:ICatalogPage;
        private var _productContainer:IProductContainer;
        private var _disposed:Boolean = false;
        private var _clubLevel:int = 0;
        private var _badgeCode:String;
        private var _bundlePurchaseAllowed:Boolean = false;
        private var _catalog:HabboCatalog;
        private var _previewCallbackId:int;

        public function Offer(_arg_1:int, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:Boolean, _arg_8:int, _arg_9:Vector.<IProduct>, _arg_10:Boolean, _arg_11:HabboCatalog)
        {
            _offerId = _arg_1;
            _localizationId = _arg_2;
            _isRentOffer = _arg_3;
            _priceInCredits = _arg_4;
            _priceInActivityPoints = _arg_5;
            _activityPointType = _arg_6;
            _giftable = _arg_7;
            _clubLevel = _arg_8;
            _bundlePurchaseAllowed = _arg_10;
            _catalog = _arg_11;
            analyzePricingModel(_arg_9);
            analyzePriceType();
            createProductContainer(_arg_9);
            for each (var _local_12:Product in _arg_9)
            {
                if (_local_12.productType == "b")
                {
                    _badgeCode = _local_12.extraParam;
                    return;
                };
            };
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }

        public function get page():ICatalogPage
        {
            return (_page);
        }

        public function set page(_arg_1:ICatalogPage):void
        {
            _page = _arg_1;
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get localizationId():String
        {
            return (_localizationId);
        }

        public function get priceInCredits():int
        {
            return (_priceInCredits);
        }

        public function get priceInActivityPoints():int
        {
            return (_priceInActivityPoints);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function get giftable():Boolean
        {
            return (_giftable);
        }

        public function get productContainer():IProductContainer
        {
            return (_productContainer);
        }

        public function get product():IProduct
        {
            return ((_productContainer) ? _productContainer.firstProduct : null);
        }

        public function get gridItem():IGridItem
        {
            return (_productContainer as IGridItem);
        }

        public function get pricingModel():String
        {
            return (_pricingModel);
        }

        public function get priceType():String
        {
            return (_priceType);
        }

        public function get previewCallbackId():int
        {
            return (_previewCallbackId);
        }

        public function set previewCallbackId(_arg_1:int):void
        {
            _previewCallbackId = _arg_1;
        }

        public function get bundlePurchaseAllowed():Boolean
        {
            return (_bundlePurchaseAllowed);
        }

        public function get isRentOffer():Boolean
        {
            return (_isRentOffer);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _disposed = true;
            _offerId = 0;
            _localizationId = "";
            _priceInCredits = 0;
            _priceInActivityPoints = 0;
            _activityPointType = 0;
            _page = null;
            _catalog = null;
            if (_productContainer != null)
            {
                _productContainer.dispose();
                _productContainer = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function createProductContainer(_arg_1:Vector.<IProduct>):void
        {
            switch (_pricingModel)
            {
                case "pricing_model_single":
                    _productContainer = new SingleProductContainer(this, _arg_1, _catalog);
                    return;
                case "pricing_model_multi":
                    _productContainer = new MultiProductContainer(this, _arg_1, _catalog);
                    return;
                case "pricing_model_bundle":
                    _productContainer = new BundleProductContainer(this, _arg_1, _catalog);
                    return;
                default:
                    _productContainer = new ProductContainer(this, _arg_1, _catalog);
                    Logger.log(("[Offer] Unknown pricing model" + _pricingModel));
                    return;
            };
        }

        private function analyzePricingModel(_arg_1:Vector.<IProduct>):void
        {
            var _local_2:Vector.<IProduct> = Product.stripAddonProducts(_arg_1);
            if (_local_2.length == 1)
            {
                if (_local_2[0].productCount == 1)
                {
                    _pricingModel = "pricing_model_single";
                }
                else
                {
                    _pricingModel = "pricing_model_multi";
                };
            }
            else
            {
                if (_local_2.length > 1)
                {
                    _pricingModel = "pricing_model_bundle";
                }
                else
                {
                    _pricingModel = "pricing_model_unknown";
                };
            };
        }

        private function analyzePriceType():void
        {
            if (((_priceInCredits > 0) && (_priceInActivityPoints > 0)))
            {
                _priceType = "price_type_credits_and_activitypoints";
            }
            else
            {
                if (_priceInCredits > 0)
                {
                    _priceType = "price_type_credits";
                }
                else
                {
                    if (_priceInActivityPoints > 0)
                    {
                        _priceType = "price_type_activitypoints";
                    }
                    else
                    {
                        _priceType = "price_type_none";
                    };
                };
            };
        }

        public function clone():Offer
        {
            var _local_4:IFurnitureData;
            var _local_2:Product;
            var _local_5:Vector.<IProduct> = new Vector.<IProduct>(0);
            var _local_6:IProductData = _catalog.getProductData(localizationId);
            for each (var _local_3:IProduct in _productContainer.products)
            {
                _local_4 = _catalog.getFurnitureData(_local_3.productClassId, _local_3.productType);
                _local_2 = new Product(_local_3.productType, _local_3.productClassId, _local_3.extraParam, _local_3.productCount, _local_6, _local_4, _catalog);
                _local_5.push(_local_2);
            };
            var _local_1:Offer = new Offer(offerId, localizationId, isRentOffer, priceInCredits, priceInActivityPoints, activityPointType, giftable, clubLevel, _local_5, bundlePurchaseAllowed, _catalog);
            _local_1.page = page;
            return (_local_1);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get localizationName():String
        {
            var _local_1:IProductData = _catalog.getProductData(_localizationId);
            return ((_local_1) ? _local_1.name : (("${" + _localizationId) + "}"));
        }

        public function get localizationDescription():String
        {
            var _local_1:IProductData = _catalog.getProductData(_localizationId);
            return ((_local_1) ? _local_1.description : (("${" + _localizationId) + "}"));
        }


    }
}


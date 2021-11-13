package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.HabboCatalog;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;

    public class Product extends ProductGridItem implements IProduct, IGetImageListener 
    {

        public static const EFFECT_CLASSID_NINJA_DISAPPEAR:int = 108;

        private var _productType:String;
        private var _productClassId:int;
        private var _extraParam:String;
        private var _productCount:int;
        private var _productData:IProductData;
        private var _furnitureData:IFurnitureData;
        private var _isUniqueLimitedItem:Boolean;
        private var _uniqueLimitedItemSeriesSize:int;
        private var _uniqueLimitedItemsLeft:int;
        private var _SafeStr_1653:IProductContainer;

        public function Product(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:IProductData, _arg_6:IFurnitureData, _arg_7:HabboCatalog, _arg_8:Boolean=false, _arg_9:int=0, _arg_10:int=0)
        {
            super(_arg_7);
            _productType = _arg_1;
            _productClassId = _arg_2;
            _extraParam = _arg_3;
            _productCount = _arg_4;
            _productData = _arg_5;
            _furnitureData = _arg_6;
            _isUniqueLimitedItem = _arg_8;
            _uniqueLimitedItemSeriesSize = _arg_9;
            _uniqueLimitedItemsLeft = _arg_10;
        }

        public static function stripAddonProducts(_arg_1:Vector.<IProduct>):Vector.<IProduct>
        {
            var _local_2:Product;
            if (_arg_1.length == 1)
            {
                return (_arg_1);
            };
            var _local_3:Vector.<IProduct> = new Vector.<IProduct>(0);
            for each (_local_2 in _arg_1)
            {
                if (((!(_local_2.productType == "b")) && (!((_local_2.productType == "e") && (_local_2.productClassId == 108)))))
                {
                    _local_3.push(_local_2);
                };
            };
            return (_local_3);
        }


        public function get productType():String
        {
            return (_productType);
        }

        public function get productClassId():int
        {
            return (_productClassId);
        }

        public function set extraParam(_arg_1:String):void
        {
            _extraParam = _arg_1;
        }

        public function get extraParam():String
        {
            return (_extraParam);
        }

        public function get productCount():int
        {
            return (_productCount);
        }

        public function get productData():IProductData
        {
            return (_productData);
        }

        public function get furnitureData():IFurnitureData
        {
            return (_furnitureData);
        }

        public function get isUniqueLimitedItem():Boolean
        {
            return (_isUniqueLimitedItem);
        }

        public function get uniqueLimitedItemSeriesSize():int
        {
            return (_uniqueLimitedItemSeriesSize);
        }

        public function get uniqueLimitedItemsLeft():int
        {
            return (_uniqueLimitedItemsLeft);
        }

        public function set uniqueLimitedItemsLeft(_arg_1:int):void
        {
            _uniqueLimitedItemsLeft = _arg_1;
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _productType = "";
            _productClassId = 0;
            _extraParam = "";
            _productCount = 0;
            _productData = null;
            _furnitureData = null;
            if (((catalog) && (catalog.sessionDataManager)))
            {
                catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", onBadgeImageReady);
            };
            super.dispose();
        }

        public function initIcon(_arg_1:IProductContainer, _arg_2:IGetImageListener=null, _arg_3:IAvatarImageListener=null, _arg_4:IPurchasableOffer=null, _arg_5:IBitmapWrapperWindow=null, _arg_6:IStuffData=null, _arg_7:Function=null):BitmapData
        {
            var _local_10:IRoomEngine;
            var _local_8:_SafeStr_147;
            var _local_11:String;
            if (disposed)
            {
                return (null);
            };
            var _local_9:BitmapData;
            if (_arg_2 == null)
            {
                _arg_2 = this;
            };
            if ((_arg_1 is BundleGridViewCatalogWidget))
            {
                _local_10 = (_arg_1 as BundleGridViewCatalogWidget).offer.page.viewer.roomEngine;
            }
            else
            {
                _local_10 = (_arg_1 as ProductContainer).offer.page.viewer.roomEngine;
            };
            if (((!(_local_10)) || (!(catalog))))
            {
                return (null);
            };
            switch (_productType)
            {
                case "s":
                    _local_8 = _local_10.getFurnitureIcon(productClassId, _arg_2, null, _arg_6);
                    break;
                case "i":
                    if (((_arg_4) && (_furnitureData)))
                    {
                        _local_11 = "";
                        switch (_furnitureData.className)
                        {
                            case "floor":
                                _local_11 = ["th", _furnitureData.className, _arg_4.product.extraParam].join("_");
                                break;
                            case "wallpaper":
                                _local_11 = ["th", "wall", _arg_4.product.extraParam].join("_");
                                break;
                            case "landscape":
                                _local_11 = ["th", _furnitureData.className, _arg_4.product.extraParam.replace(".", "_"), "001"].join("_");
                                break;
                            default:
                                _local_8 = _local_10.getWallItemIcon(productClassId, _arg_2, _extraParam);
                        };
                        catalog.setImageFromAsset(_arg_5, _local_11, _arg_7);
                    }
                    else
                    {
                        _local_8 = _local_10.getWallItemIcon(productClassId, _arg_2, _extraParam);
                    };
                    break;
                case "e":
                    _local_9 = catalog.getPixelEffectIcon(productClassId);
                    if (_arg_2 == this)
                    {
                        this.setIconImage(_local_9, true);
                    };
                    break;
                case "h":
                    _local_9 = catalog.getSubscriptionProductIcon(productClassId);
                    break;
                case "b":
                    catalog.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY", onBadgeImageReady);
                    _local_9 = catalog.sessionDataManager.getBadgeImage(_extraParam);
                    _SafeStr_1653 = _arg_1;
                    break;
                case "r":
                    _local_9 = renderAvatarImage(_extraParam, _arg_3);
                    setIconImage(_local_9, false);
                    break;
                default:
                    Logger.log(("[Product] Can not yet handle this type of product: " + productType));
            };
            if (_local_8 != null)
            {
                _local_9 = _local_8.data;
                if (_arg_2 == this)
                {
                    this.setIconImage(_local_9, true);
                };
            };
            return (_local_9);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (!disposed)
            {
                setIconImage(_arg_2, true);
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function onBadgeImageReady(_arg_1:BadgeImageReadyEvent):void
        {
            if (!disposed)
            {
                if (((_productType == "b") && (_arg_1.badgeId == _extraParam)))
                {
                    ProductGridItem(_SafeStr_1653).setIconImage(_arg_1.badgeImage, false);
                    if (((catalog) && (catalog.sessionDataManager)))
                    {
                        catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", onBadgeImageReady);
                    };
                };
            };
        }

        public function get isColorable():Boolean
        {
            if (((_furnitureData) && (_furnitureData.fullName)))
            {
                return (!(_furnitureData.fullName.indexOf("*") == -1));
            };
            return (false);
        }

        override public function set view(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindow;
            var _local_3:ITextWindow;
            if (!_arg_1)
            {
                return;
            };
            super.view = _arg_1;
            if (_productCount > 1)
            {
                _local_2 = _SafeStr_570.findChildByName("multiContainer");
                if (_local_2)
                {
                    _local_2.visible = true;
                };
                _local_3 = (_SafeStr_570.findChildByName("multiCounter") as ITextWindow);
                if (_local_3)
                {
                    _local_3.text = ("x" + productCount);
                };
            };
        }


    }
}


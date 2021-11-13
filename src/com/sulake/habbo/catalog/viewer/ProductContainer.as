package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.components.IItemListWindow;

    public class ProductContainer extends ProductGridItem implements IGetImageListener, IProductContainer, IGridItem, IAvatarImageListener 
    {

        private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
        private static const _SafeStr_1633:String = "amount_text_left";
        private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
        private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";

        protected var _offer:IPurchasableOffer;
        protected var _SafeStr_501:Vector.<IProduct>;

        public function ProductContainer(_arg_1:IPurchasableOffer, _arg_2:Vector.<IProduct>, _arg_3:HabboCatalog)
        {
            super(_arg_3);
            var _local_5:String = null;
            for each (var _local_4:Product in _arg_2)
            {
                if (_local_4.productType != "b")
                {
                    _local_5 = _local_4.extraParam;
                    break;
                };
            };
            _offer = _arg_1;
            _SafeStr_501 = _arg_2;
        }

        public function get products():Vector.<IProduct>
        {
            return (_SafeStr_501);
        }

        public function get firstProduct():IProduct
        {
            if (((!(_SafeStr_501)) || (_SafeStr_501.length == 0)))
            {
                return (null);
            };
            if (_SafeStr_501.length == 1)
            {
                return (_SafeStr_501[0]);
            };
            var _local_1:Vector.<IProduct> = Product.stripAddonProducts(_SafeStr_501);
            return ((_local_1.length > 0) ? _local_1[0] : null);
        }

        public function get offer():IPurchasableOffer
        {
            return (_offer);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            for each (var _local_1:Product in _SafeStr_501)
            {
                _local_1.dispose();
            };
            _SafeStr_501 = null;
            super.dispose();
        }

        public function get isLazy():Boolean
        {
            return (false);
        }

        public function initProductIcon(_arg_1:IRoomEngine, _arg_2:IStuffData=null):void
        {
        }

        override public function set view(_arg_1:IWindowContainer):void
        {
            var _local_3:int;
            var _local_2:IProduct;
            super.view = _arg_1;
            if (_SafeStr_570 == null)
            {
                return;
            };
            if (((((catalog) && (_offer.badgeCode)) && (!(_offer.badgeCode == ""))) && (_offer.productContainer.products.length > 1)))
            {
                setAddOnIcon("catalog_icon_badge_included");
            }
            else
            {
                if (((catalog) && (_offer.productContainer.products.length == 2)))
                {
                    _local_3 = 0;
                    while (_local_3 < 2)
                    {
                        _local_2 = _offer.productContainer.products[_local_3];
                        if (((_local_2.productType == "e") && (_local_2.productClassId == 108)))
                        {
                            setAddOnIcon("catalog_icon_ninja_effect_included");
                        };
                        _local_3++;
                    };
                };
            };
            setClubIconLevel(offer.clubLevel);
            if (catalog.isDraggable(offer))
            {
                setDraggable(true);
            };
        }

        private function setAddOnIcon(_arg_1:String):void
        {
            var _local_3:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("badge_add_on") as IBitmapWrapperWindow);
            var _local_4:IAsset = catalog.assets.getAssetByName(_arg_1);
            _local_3.bitmap = (_local_4.content as BitmapData);
            var _local_2:BitmapData = (_local_4.content as BitmapData);
            _local_3.width = _local_2.width;
            _local_3.height = _local_2.height;
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            setIconImage(_arg_2, true);
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        public function setClubIconLevel(_arg_1:int):void
        {
            if (view == null)
            {
                return;
            };
            var _local_2:IWindow = view.findChildByName("clubLevelIcon");
            if (_local_2 == null)
            {
                return;
            };
            switch (offer.clubLevel)
            {
                case 0:
                    _local_2.visible = false;
                    return;
                case 1:
                    _local_2.visible = true;
                    _local_2.style = 11;
                    _local_2.x = (_local_2.x + 3);
                    return;
                case 2:
                    _local_2.visible = true;
                    _local_2.style = 12;
                default:
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (!disposed)
            {
                for each (var _local_2:IProduct in products)
                {
                    if (((_local_2.productType == "r") && (_local_2.extraParam == _arg_1)))
                    {
                        setIconImage(renderAvatarImage(_local_2.extraParam, this), true);
                        return;
                    };
                };
            };
        }

        public function createCurrencyIndicators(_arg_1:HabboCatalog):void
        {
            var _local_2:ITextWindow;
            var _local_5:ITextWindow;
            var _local_4:IWindow;
            if (_offer.priceInCredits > 0)
            {
                if (_offer.priceInActivityPoints > 0)
                {
                    _local_2 = ITextWindow(_SafeStr_570.findChildByName("amount_text_left"));
                }
                else
                {
                    _local_2 = ITextWindow(_SafeStr_570.findChildByName("amount_text_right"));
                };
                if (_local_2)
                {
                    _local_2.text = (_offer.priceInCredits + "");
                };
            };
            if (_offer.priceInActivityPoints > 0)
            {
                _local_5 = ITextWindow(_SafeStr_570.findChildByName("amount_text_right"));
                if (_local_5)
                {
                    _local_4 = _SafeStr_570.findChildByName("currency_indicator_bitmap_right");
                    if (_local_4)
                    {
                        _local_4.style = _SafeStr_139.getIconStyleFor(_offer.activityPointType, _arg_1, false);
                    };
                    _local_5.text = (_offer.priceInActivityPoints + "");
                };
            };
            var _local_3:IItemListWindow = IItemListWindow(_SafeStr_570.findChildByName("totalprice_container"));
            if (_local_3)
            {
                _local_3.arrangeListItems();
            };
        }


    }
}


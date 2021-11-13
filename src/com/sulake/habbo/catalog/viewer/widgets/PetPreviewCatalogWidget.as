package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.PetColorResult;
    import com.sulake.habbo.avatar.pets.PetCustomPart;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.Offer;

    public class PetPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener
    {

        private var PET_TYPE_ID:int = 15;
        private var BREED:int = 1;
        private var COLOR:int = 0xFFFFFF;
        private var PALETTE_ID:int = 2;
        private var PART_ID:int = -1;
        private var _productName:IWindow;
        private var _productDescription:IWindow;
        private var _SafeStr_1592:IBitmapWrapperWindow;
        private var _previewOffset:Point;
        private var _SafeStr_1593:int;
        protected var _gridItemLayout:XML;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1590:IWindow;

        public function PetPreviewCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            _catalog = null;
            _SafeStr_1590 = null;
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _productName = _window.findChildByName("ctlg_product_name");
            _productName.caption = "";
            _productDescription = _window.findChildByName("ctlg_description");
            _productDescription.caption = "";
            _SafeStr_1592 = (_window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            _previewOffset = new Point(_SafeStr_1592.x, _SafeStr_1592.y);
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            _gridItemLayout = (_local_1.content as XML);
            var _local_2:_SafeStr_147 = (page.viewer.catalog as HabboCatalog).roomEngine.getPetImage(PET_TYPE_ID, PALETTE_ID, COLOR, new Vector3d(90), 64, this, true, 0);
            if (_local_2 != null)
            {
                setPreviewImage(_local_2.data, true, new Point(0, 0));
                _SafeStr_1593 = _local_2.id;
            };
            events.addEventListener("SELECT_PRODUCT", onPreviewProduct);
            return (true);
        }

        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            var _local_30:String;
            var _local_24:String;
            var _local_31:BitmapData;
            var _local_18:IProduct;
            var _local_4:_SafeStr_147;
            var _local_11:IFurnitureData;
            var _local_21:String;
            var _local_2:Array;
            var _local_29:int;
            var _local_14:Array;
            var _local_26:Array;
            var _local_12:Array;
            var _local_15:Array;
            var _local_23:int;
            var _local_13:String;
            var _local_6:Array;
            var _local_19:int;
            var _local_5:int;
            var _local_17:int;
            var _local_10:PetColorResult;
            var _local_9:PetColorResult;
            var _local_16:int;
            var _local_27:int;
            var _local_8:PetCustomPart;
            var _local_22:PetCustomPart;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_7:IPurchasableOffer = _arg_1.offer;
            var _local_25:IProductData = page.viewer.catalog.getProductData(_local_7.localizationId);
            if (_local_25 != null)
            {
                _local_30 = (("${" + _local_25.name) + "}");
                _local_24 = (("${" + _local_25.description) + "}");
            }
            else
            {
                _local_30 = (("${" + _local_7.localizationId) + "}");
                _local_24 = (("${" + _local_7.localizationId) + "}");
            };
            _productName.caption = _local_30;
            _productDescription.caption = _local_24;
            _productDescription.y = ((_productName.y + _productName.height) + 5);
            _SafeStr_1590 = _catalog.utils.showPriceOnProduct(_arg_1.offer, _window, _SafeStr_1590, _SafeStr_1592, -6, true, 6);
            var _local_20:Point = new Point(0, 0);
            var _local_28:IRoomEngine = (page.viewer.catalog as HabboCatalog).roomEngine;
            switch (_local_7.pricingModel)
            {
                case "pricing_model_single":
                case "pricing_model_multi":
                    _local_18 = _local_7.product;
                    _local_11 = _local_18.furnitureData;
                    if (((_local_11 == null) || (_local_11.customParams == null)))
                    {
                        Logger.log(("[Pet Preview Catalog Widget] Unsupported product: " + _local_18.productType));
                        break;
                    };
                    _local_21 = _local_11.customParams;
                    _local_2 = _local_21.split(" ");
                    if (_local_2.length < 1)
                    {
                        Logger.log(("[Pet Preview Catalog Widget] Invalid custom params: " + _local_18.productType));
                        break;
                    };
                    _local_29 = _local_2[0];
                    _local_15 = [];
                    switch (_local_11.category)
                    {
                        case 13:
                            if (_local_2.length < 2)
                            {
                                Logger.log(("[Pet Preview Catalog Widget] Invalid custom params: " + _local_18.productType));
                                break;
                            };
                            _local_13 = _local_2[1];
                            _local_6 = _local_28.getPetColorsByTag(_local_29, _local_13);
                            for each (var _local_3:PetColorResult in _local_6)
                            {
                                if (_local_3.breed == BREED)
                                {
                                    _local_19 = int(_local_3.id);
                                    break;
                                };
                            };
                            switch (_local_29)
                            {
                                case 15:
                                    _local_5 = 2;
                                    _local_17 = 3;
                                    _local_10 = _local_28.getPetDefaultPalette(_local_29, "hair");
                                    _local_9 = _local_28.getPetDefaultPalette(_local_29, "tail");
                                    _local_16 = ((_local_10) ? parseInt(_local_10.id) : -1);
                                    _local_27 = ((_local_9) ? parseInt(_local_9.id) : -1);
                                    _local_8 = new PetCustomPart(_local_5, -1, _local_16);
                                    _local_22 = new PetCustomPart(_local_17, -1, _local_27);
                                    _local_15 = [_local_8, _local_22];
                                default:
                                    _local_4 = _local_28.getPetImage(_local_29, _local_19, COLOR, new Vector3d(90), 64, this, true, 0, _local_15);
                                    break;
                            };
                        case 14:
                            if (_local_2.length < 4)
                            {
                                Logger.log(("[Pet Preview Catalog Widget] Invalid custom params: " + _local_18.productType));
                                break;
                            };
                            _local_14 = (_local_2[1] as String).split(",");
                            _local_26 = (_local_2[2] as String).split(",");
                            _local_12 = (_local_2[3] as String).split(",");
                            _local_23 = 0;
                            while (_local_23 < _local_14.length)
                            {
                                _local_15.push(new PetCustomPart(_local_14[_local_23], _local_26[_local_23], _local_12[_local_23]));
                                _local_23++;
                            };
                            _local_4 = _local_28.getPetImage(_local_29, PALETTE_ID, COLOR, new Vector3d(90), 64, this, true, 0, _local_15);
                            break;
                        case 15:
                            if (_local_2.length < 3)
                            {
                                Logger.log(("[Pet Preview Catalog Widget] Invalid custom params: " + _local_18.productType));
                                break;
                            };
                            _local_14 = (_local_2[1] as String).split(",");
                            _local_12 = (_local_2[2] as String).split(",");
                            _local_23 = 0;
                            while (_local_23 < _local_14.length)
                            {
                                _local_15.push(new PetCustomPart(_local_14[_local_23], PART_ID, _local_12[_local_23]));
                                _local_23++;
                            };
                            _local_4 = _local_28.getPetImage(_local_29, PALETTE_ID, COLOR, new Vector3d(90), 64, this, true, 0, _local_15);
                            break;
                        case 16:
                            if (_local_2.length < 4)
                            {
                                Logger.log(("[Pet Preview Catalog Widget] Invalid custom params: " + _local_18.productType));
                            };
                            _local_15.push(new PetCustomPart(_local_2[1], _local_2[2], _local_2[3]));
                            _local_4 = _local_28.getPetImage(_local_29, PALETTE_ID, COLOR, new Vector3d(90), 64, this, true, 0, _local_15);
                            break;
                        default:
                            Logger.log(("[Pet Preview Catalog Widget] Unsupported Product Type: " + _local_18.productType));
                    };
                    if (_local_4 != null)
                    {
                        _local_7.previewCallbackId = _local_4.id;
                        _local_31 = _local_4.data;
                    };
                    break;
                default:
                    Logger.log(("[Pet Preview Catalog Widget] Unknown pricing model" + _local_7.pricingModel));
            };
            setPreviewImage(_local_31, true, _local_20);
            _window.invalidate();
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if ((((disposed) || (page == null)) || (page.offers == null)))
            {
                return;
            };
            if (_SafeStr_1593 == _arg_1)
            {
                setPreviewImage(_arg_2, true);
                _SafeStr_1593 = 0;
            }
            else
            {
                for each (var _local_3:Offer in page.offers)
                {
                    if (_local_3.previewCallbackId == _arg_1)
                    {
                        setPreviewImage(_arg_2, true);
                        _local_3.previewCallbackId = 0;
                        return;
                    };
                };
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function setPreviewImage(_arg_1:BitmapData, _arg_2:Boolean, _arg_3:Point=null):void
        {
            var _local_4:Point;
            if (((!(_SafeStr_1592 == null)) && (!(window.disposed))))
            {
                if (_arg_1 == null)
                {
                    _arg_1 = new BitmapData(1, 1);
                    _arg_2 = true;
                };
                if (_SafeStr_1592.bitmap == null)
                {
                    _SafeStr_1592.bitmap = new BitmapData(_SafeStr_1592.width, _SafeStr_1592.height, true, 0xFFFFFF);
                };
                _SafeStr_1592.bitmap.fillRect(_SafeStr_1592.bitmap.rect, 0xFFFFFF);
                _local_4 = new Point(((_SafeStr_1592.width - _arg_1.width) / 2), ((_SafeStr_1592.height - _arg_1.height) / 2));
                _SafeStr_1592.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_4, null, null, true);
                _SafeStr_1592.invalidate();
                _SafeStr_1592.x = _previewOffset.x;
                _SafeStr_1592.y = _previewOffset.y;
                if (_arg_3 != null)
                {
                    _SafeStr_1592.x = (_SafeStr_1592.x + _arg_3.x);
                    _SafeStr_1592.y = (_SafeStr_1592.y + _arg_3.y);
                };
            };
            if (_arg_2)
            {
                _arg_1.dispose();
            };
        }


    }
}
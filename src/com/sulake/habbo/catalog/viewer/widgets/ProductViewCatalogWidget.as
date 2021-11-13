package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.room.preview.RoomPreviewer;
    import flash.display.DisplayObject;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.viewer.BundleProductContainer;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
    import com.sulake.habbo.catalog.viewer.ProductImageConfiguration;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
    import flash.geom.Matrix;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
    import flash.events.Event;

    public class ProductViewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IDragAndDropDoneReceiver 
    {

        private static const WALL_PAPER:int = 2;
        private static const _SafeStr_1595:int = 3;
        private static const LANDSCAPE:int = 4;

        private var _SafeStr_1596:BitmapData;
        private var _productName:IWindow;
        private var _productDescription:IWindow;
        private var _SafeStr_1592:IBitmapWrapperWindow;
        private var _SafeStr_1597:IWindowContainer;
        private var _SafeStr_1598:IDisplayObjectWrapper;
        private var _previewOffset:Point;
        private var _bundleGrid:IItemGridWindow;
        protected var _gridItemLayout:XML;
        private var _SafeStr_1599:Array;
        private var _overrideStuffData:IStuffData;
        private var _SafeStr_1600:SelectProductEvent = null;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1590:IWindow;
        private var _SafeStr_1601:Boolean = true;
        private var _SafeStr_1602:Boolean = false;
        private var _SafeStr_1603:Boolean = true;
        private var _offer:IPurchasableOffer;
        private var _SafeStr_1604:Boolean;

        public function ProductViewCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        private static function ninjaEffectBundled(_arg_1:SelectProductEvent):Boolean
        {
            var _local_3:int;
            var _local_2:IProduct;
            var _local_4:Boolean;
            if (_arg_1.offer.productContainer.products.length == 2)
            {
                _local_3 = 0;
                while (_local_3 < 2)
                {
                    _local_2 = _arg_1.offer.productContainer.products[_local_3];
                    if (((_local_2.productType == "e") && (_local_2.productClassId == 108)))
                    {
                        _local_4 = true;
                    };
                    _local_3++;
                };
            };
            return (_local_4);
        }


        override public function dispose():void
        {
            if (!disposed)
            {
                events.removeEventListener("SELECT_PRODUCT", onPreviewProduct);
                events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA", onStuffDataSet);
                events.removeEventListener("CWSE_VALUE_CHANGED", onSpinnerEvent);
                events.removeEventListener("TOTAL_PRICE_WIDGET_INITIALIZED", onTotalPriceWidgetInitialized);
                _catalog = null;
                _SafeStr_1590 = null;
                super.dispose();
                _SafeStr_1596 = null;
                _SafeStr_1597 = null;
            };
        }

        override public function init():Boolean
        {
            var _local_4:RoomPreviewer;
            var _local_3:DisplayObject;
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("productViewWidget");
            if (!_isEmbedded)
            {
                _window.getChildAt(0).width = _window.width;
                _window.getChildAt(0).height = _window.height;
            };
            if (_window.tags.indexOf("2X") > -1)
            {
            };
            _SafeStr_1603 = (_window.tags.indexOf("NO_ROOM_CANVAS") == -1);
            _SafeStr_1590 = null;
            _productName = _window.findChildByName("ctlg_product_name");
            _productName.caption = "";
            _productDescription = _window.findChildByName("ctlg_description");
            _productDescription.caption = "";
            (_productName as ITextWindow).textColor = 0;
            (_productDescription as ITextWindow).textColor = 0;
            _SafeStr_1592 = (_window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            _SafeStr_1597 = (_window.findChildByName("room_canvas_container") as IWindowContainer);
            if (_SafeStr_1597 != null)
            {
                _SafeStr_1597.visible = false;
                _SafeStr_1598 = (_SafeStr_1597.findChildByName("room_canvas") as IDisplayObjectWrapper);
                _local_4 = (page.viewer.catalog as HabboCatalog).roomPreviewer;
                if (((!(_SafeStr_1598 == null)) && (!(_local_4 == null))))
                {
                    _SafeStr_1597.procedure = roomCanvasContainerProcedure;
                    _local_4.disableUpdate = false;
                    _local_4.reset(false);
                    _local_3 = _local_4.getRoomCanvas(_SafeStr_1598.width, _SafeStr_1598.height);
                    if (_local_3 != null)
                    {
                        _SafeStr_1598.setDisplayObject(_local_3);
                    };
                }
                else
                {
                    _SafeStr_1597 = null;
                    _SafeStr_1598 = null;
                };
            };
            _previewOffset = new Point(_SafeStr_1592.x, _SafeStr_1592.y);
            _bundleGrid = (_window.findChildByName("bundleGrid") as IItemGridWindow);
            if (_bundleGrid == null)
            {
                Logger.log("[Product View Catalog Widget] Bundle Grid not initialized!");
            };
            var _local_2:XmlAsset = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            _gridItemLayout = (_local_2.content as XML);
            var _local_1:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset);
            _SafeStr_1596 = (_local_1.content as BitmapData);
            events.addEventListener("SELECT_PRODUCT", onPreviewProduct);
            events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA", onStuffDataSet);
            events.addEventListener("CWSE_VALUE_CHANGED", onSpinnerEvent);
            events.addEventListener("TOTAL_PRICE_WIDGET_INITIALIZED", onTotalPriceWidgetInitialized);
            return (true);
        }

        private function roomCanvasContainerProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    if (_catalog.roomPreviewer != null)
                    {
                        _catalog.roomPreviewer.changeRoomObjectState();
                    };
                    return;
                case "WME_UP":
                case "WME_OVER":
                    _SafeStr_1604 = false;
                    return;
                case "WME_DOWN":
                    _SafeStr_1604 = true;
                    return;
                case "WME_OUT":
                    if (_SafeStr_1604)
                    {
                        if (_catalog.isDraggable(_offer))
                        {
                            _catalog.requestSelectedItemToMover(this, _offer);
                        };
                    };
                    _SafeStr_1604 = false;
                    return;
            };
        }

        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            var _local_28:String;
            var _local_33:BitmapData;
            var _local_27:Point;
            var _local_4:RoomPreviewer;
            var _local_2:BundleProductContainer;
            var _local_24:IProduct;
            var _local_8:_SafeStr_147;
            var _local_19:IFurnitureData;
            var _local_15:Vector.<int> = undefined;
            var _local_23:Array;
            var _local_29:String;
            var _local_22:String;
            var _local_10:String;
            var _local_21:String;
            var _local_3:String;
            var _local_34:String;
            var _local_12:IFurnitureData;
            var _local_32:IAvatarImage;
            var _local_25:String;
            var _local_13:IHabboWindowManager;
            var _local_5:IWindowContainer;
            var _local_18:uint;
            var _local_16:BitmapData;
            var _local_9:HabboCatalog;
            var _local_30:IAvatarImage;
            var _local_6:Point;
            var _local_7:IAvatarDataContainer;
            var _local_26:IAnimationLayerData;
            var _local_31:int;
            var _local_11:Point;
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_1600 = _arg_1;
            removeEffectSprites();
            var _local_14:IPurchasableOffer = _arg_1.offer;
            _offer = _local_14;
            if (_bundleGrid != null)
            {
                _bundleGrid.visible = false;
                _bundleGrid.destroyGridItems();
            };
            _productName.caption = _local_14.localizationName;
            _productDescription.caption = _local_14.localizationDescription;
            _productDescription.y = (_productName.y + _productName.height);
            if ((((_catalog.multiplePurchaseEnabled) && (_local_14.bundlePurchaseAllowed)) && (_SafeStr_1602)))
            {
                setSpinnerToBundleRuleset();
                setBundleInfoWidgetToOffer(_local_14);
                _SafeStr_1601 = false;
            }
            else
            {
                events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_HIDE"));
                events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_HIDE"));
                _SafeStr_1601 = true;
            };
            if (_SafeStr_1601)
            {
                _SafeStr_1590 = _catalog.utils.showPriceOnProduct(_local_14, _window, _SafeStr_1590, _SafeStr_1592, -6, false, 6, page.acceptSeasonCurrencyAsCredits, page.acceptSeasonCurrencyAsCredits);
            }
            else
            {
                if (_SafeStr_1590 != null)
                {
                    _window.removeChild(_SafeStr_1590);
                    _SafeStr_1590.dispose();
                    _SafeStr_1590 = null;
                };
            };
            if (((!(_local_14.badgeCode == null)) && (!(_local_14.badgeCode == ""))))
            {
                _catalog.utils.showBadgeOnProduct(_local_14.badgeCode, _window, 6, 38, true, false);
            }
            else
            {
                if (ninjaEffectBundled(_arg_1))
                {
                    _catalog.utils.showAssetImageAsBadgeOnProduct("catalogue_effects_ninja", _window, 6, 38, true, false);
                }
                else
                {
                    _catalog.utils.hideBadgeFromProduct(_window);
                };
            };
            if (ProductImageConfiguration.hasProductImage(_local_14.localizationId))
            {
                setPreviewFromAsset(ProductImageConfiguration.PRODUCT_IMAGES[_local_14.localizationId]);
                if (_SafeStr_1597 != null)
                {
                    _SafeStr_1597.visible = false;
                };
            }
            else
            {
                _local_27 = new Point(0, 0);
                _local_4 = _catalog.roomPreviewer;
                switch (_local_14.pricingModel)
                {
                    case "pricing_model_bundle":
                        _local_33 = _SafeStr_1596.clone();
                        if (_bundleGrid != null)
                        {
                            _bundleGrid.visible = true;
                            _local_2 = (_local_14.productContainer as BundleProductContainer);
                            _local_2.populateItemGrid(_bundleGrid, _gridItemLayout);
                            _bundleGrid.scrollV = 0;
                        };
                        if (_SafeStr_1597 != null)
                        {
                            _SafeStr_1597.visible = false;
                        };
                        break;
                    case "pricing_model_single":
                    case "pricing_model_multi":
                    case "pricing_model_furniture":
                        _local_24 = _local_14.product;
                        if (((!(_SafeStr_1597 == null)) && (_SafeStr_1603)))
                        {
                            if ((((_local_24.productType == "s") || (_local_24.productType == "i")) || (_local_24.productType == "e")))
                            {
                                _SafeStr_1597.visible = true;
                            }
                            else
                            {
                                _SafeStr_1597.visible = false;
                            };
                        };
                        if (((!(_local_4 == null)) && (!(_SafeStr_1598 == null))))
                        {
                            _local_4.addViewOffset.y = ((_local_24.isUniqueLimitedItem) ? -15 : 0);
                            _local_4.disableUpdate = false;
                        };
                        switch (_local_24.productType)
                        {
                            case "s":
                                if (((!(_local_4 == null)) && (!(_SafeStr_1598 == null))))
                                {
                                    if (((_local_24 == null) || (_local_24.furnitureData == null))) break;
                                    if (_local_24.furnitureData.category == 23)
                                    {
                                        _local_19 = _catalog.sessionDataManager.getFloorItemData(_local_24.furnitureData.id);
                                        _local_15 = new Vector.<int>(0);
                                        _local_23 = _local_19.customParams.split(",");
                                        for each (var _local_20:String in _local_23)
                                        {
                                            if ((page.viewer.catalog as HabboCatalog).avatarRenderManager.isValidFigureSetForGender(parseInt(_local_20), (page.viewer.catalog as HabboCatalog).sessionDataManager.gender))
                                            {
                                                _local_15.push(parseInt(_local_20));
                                            };
                                        };
                                        _local_28 = (page.viewer.catalog as HabboCatalog).avatarRenderManager.getFigureStringWithFigureIds((page.viewer.catalog as HabboCatalog).sessionDataManager.figure, (page.viewer.catalog as HabboCatalog).sessionDataManager.gender, _local_15);
                                        _local_4.addAvatarIntoRoom(_local_28, _local_24.productClassId);
                                    }
                                    else
                                    {
                                        _local_4.addFurnitureIntoRoom(_local_24.productClassId, new Vector3d(90, 0, 0), _overrideStuffData);
                                    };
                                }
                                else
                                {
                                    _local_8 = page.viewer.roomEngine.getFurnitureImage(_local_24.productClassId, new Vector3d(90, 0, 0), 64, this, 0, _local_24.extraParam, -1, -1, _overrideStuffData);
                                    _local_14.previewCallbackId = _local_8.id;
                                };
                                break;
                            case "i":
                                if ((((_local_24.furnitureData.category == 2) || (_local_24.furnitureData.category == 3)) || (_local_24.furnitureData.category == 4)))
                                {
                                    _local_29 = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId, "room_wall_type");
                                    _local_22 = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId, "room_floor_type");
                                    _local_10 = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId, "room_landscape_type");
                                    _local_29 = (((_local_29) && (_local_29.length > 0)) ? _local_29 : "101");
                                    _local_22 = (((_local_22) && (_local_22.length > 0)) ? _local_22 : "101");
                                    _local_10 = (((_local_10) && (_local_10.length > 0)) ? _local_10 : "1.1");
                                    _local_4.updateRoomWallsAndFloorVisibility(true, true);
                                    _local_21 = ((_local_24.furnitureData.category == 3) ? _local_24.extraParam : _local_22);
                                    _local_3 = ((_local_24.furnitureData.category == 2) ? _local_24.extraParam : _local_29);
                                    _local_34 = ((_local_24.furnitureData.category == 4) ? _local_24.extraParam : _local_10);
                                    _local_4.updateObjectRoom(_local_21, _local_3, _local_34);
                                    if (_local_24.furnitureData.category == 4)
                                    {
                                        _local_12 = _catalog.getFurnitureDataByName("ads_twi_windw", "i");
                                        _local_4.addWallItemIntoRoom(_local_12.id, new Vector3d(90, 0, 0), _local_12.customParams);
                                    };
                                }
                                else
                                {
                                    if (((!(_local_4 == null)) && (!(_SafeStr_1598 == null))))
                                    {
                                        _local_4.addWallItemIntoRoom(_local_24.productClassId, new Vector3d(90, 0, 0), _local_24.extraParam);
                                    }
                                    else
                                    {
                                        _local_8 = page.viewer.roomEngine.getWallItemImage(_local_24.productClassId, new Vector3d(90, 0, 0), 64, this, 0, _local_24.extraParam);
                                        _local_14.previewCallbackId = _local_8.id;
                                    };
                                };
                                break;
                            case "r":
                                _local_32 = _catalog.avatarRenderManager.createAvatarImage(_local_24.extraParam, "h", null);
                                _local_32.appendAction("gest", "sml");
                                _local_32.setDirection("full", 4);
                                _local_32.setDirection("head", 3);
                                _local_33 = _local_32.getCroppedImage("full");
                                break;
                            case "e":
                                if (((!(_local_4 == null)) && (!(_SafeStr_1598 == null))))
                                {
                                    _local_25 = (page.viewer.catalog as HabboCatalog).sessionDataManager.figure;
                                    _local_4.addAvatarIntoRoom(_local_25, _local_24.productClassId);
                                }
                                else
                                {
                                    _local_13 = page.viewer.catalog.windowManager;
                                    _local_5 = (_window.findChildByName("pixelsBackground") as IWindowContainer);
                                    _local_18 = 4291611852;
                                    if (_local_5 != null)
                                    {
                                        _local_5.visible = true;
                                        _local_18 = _local_5.color;
                                    };
                                    _local_33 = new BitmapData(_SafeStr_1592.width, _SafeStr_1592.height, false, _local_18);
                                    _local_16 = null;
                                    _local_9 = (page.viewer.catalog as HabboCatalog);
                                    if (_local_9.avatarRenderManager != null)
                                    {
                                        _local_28 = _local_9.sessionDataManager.figure;
                                        _local_30 = _local_9.avatarRenderManager.createAvatarImage(_local_28, "h");
                                        if (_local_30 != null)
                                        {
                                            _local_30.setDirection("head", 3);
                                            _local_30.initActionAppends();
                                            _local_30.appendAction("gest", "sml");
                                            _local_30.appendAction("fx", _local_24.productClassId);
                                            _local_30.endActionAppends();
                                            _local_30.updateAnimationByFrames(1);
                                            _local_30.updateAnimationByFrames(1);
                                            _local_16 = _local_30.getImage("full", true);
                                            _local_6 = new Point(0, 0);
                                            if (_local_16 != null)
                                            {
                                                _local_7 = _local_30.avatarSpriteData;
                                                if (_local_7 != null)
                                                {
                                                };
                                                _local_6.x = ((_local_33.width - _local_16.width) / 2);
                                                _local_6.y = ((_local_33.height - _local_16.height) / 2);
                                                for each (var _local_17:ISpriteDataContainer in _local_30.getSprites())
                                                {
                                                    if (_local_17.id == "avatar")
                                                    {
                                                        _local_26 = _local_30.getLayerData(_local_17);
                                                        _local_27.x = _local_26.dx;
                                                        _local_27.y = _local_26.dy;
                                                    };
                                                };
                                            };
                                            _local_31 = 64;
                                            _local_11 = new Point(((_local_16.width - _local_31) / 2), (_local_16.height - (_local_31 / 4)));
                                            addEffectSprites(_local_33, _local_30, _local_27, _local_6.add(_local_11), false);
                                            _local_33.copyPixels(_local_16, _local_16.rect, _local_6, null, null, true);
                                            addEffectSprites(_local_33, _local_30, _local_27, _local_6.add(_local_11));
                                        };
                                    };
                                    if (_local_30)
                                    {
                                        _local_30.dispose();
                                    };
                                };
                                break;
                            case "h":
                                break;
                            default:
                                Logger.log(("[Product View Catalog Widget] Unknown Product Type: " + _local_24.productType));
                        };
                        if (_local_8 != null)
                        {
                            _local_33 = _local_8.data;
                        };
                        break;
                    default:
                        Logger.log(("[Product View Catalog Widget] Unknown pricing model" + _local_14.pricingModel));
                };
                setPreviewImage(_local_33, true, _local_27);
            };
            if (((((((_SafeStr_1603) && (_local_4)) && (_SafeStr_1598)) && (_SafeStr_1597)) && (_SafeStr_1598.visible)) && (_SafeStr_1597.visible)))
            {
                (_productName as ITextWindow).textColor = 0xFFFFFFFF;
                (_productDescription as ITextWindow).textColor = 0xFFFFFFFF;
            }
            else
            {
                (_productName as ITextWindow).textColor = 0xFF000000;
                (_productDescription as ITextWindow).textColor = 0xFF000000;
            };
            _window.invalidate();
        }

        private function setBundleInfoWidgetToOffer(_arg_1:IPurchasableOffer):void
        {
            var _local_2:ExtraInfoItemData = new ExtraInfoItemData(5);
            _local_2.activityPointType = _arg_1.activityPointType;
            _local_2.priceActivityPoints = _arg_1.priceInActivityPoints;
            _local_2.priceCredits = _arg_1.priceInCredits;
            _local_2.badgeCode = _arg_1.badgeCode;
            events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_RESET", _local_2));
        }

        private function setSpinnerToBundleRuleset():void
        {
            if (_catalog.bundleDiscountEnabled)
            {
                events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET", 1, _catalog.utils.bundleDiscountFlatPriceSteps));
            }
            else
            {
                events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET", 1));
            };
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SHOW"));
            if (_catalog.bundleDiscountRuleset != null)
            {
                events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MAX", _catalog.bundleDiscountRuleset.maxPurchaseSize));
            };
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MIN", 1));
        }

        private function addEffectSprites(_arg_1:BitmapData, _arg_2:IAvatarImage, _arg_3:Point, _arg_4:Point, _arg_5:Boolean=true):void
        {
            var _local_9:ISpriteDataContainer;
            var _local_17:int;
            var _local_10:IAnimationLayerData;
            var _local_19:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_20:int;
            var _local_7:String;
            var _local_6:BitmapDataAsset;
            var _local_8:BitmapData;
            var _local_18:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_11:Matrix;
            for each (_local_9 in _arg_2.getSprites())
            {
                _local_17 = _window.getChildIndex(_SafeStr_1592);
                _local_10 = _arg_2.getLayerData(_local_9);
                _local_19 = 0;
                _local_14 = _local_9.getDirectionOffsetX(_arg_2.getDirection());
                _local_15 = _local_9.getDirectionOffsetY(_arg_2.getDirection());
                _local_16 = _local_9.getDirectionOffsetZ(_arg_2.getDirection());
                _local_20 = 0;
                if (!_arg_5)
                {
                    if (_local_16 >= 0) continue;
                }
                else
                {
                    if (_local_16 < 0) continue;
                };
                if (_local_9.hasDirections)
                {
                    _local_20 = _arg_2.getDirection();
                };
                if (_local_10 != null)
                {
                    _local_19 = _local_10.animationFrame;
                    _local_14 = (_local_14 + _local_10.dx);
                    _local_15 = (_local_15 + _local_10.dy);
                    _local_20 = (_local_20 + _local_10.directionOffset);
                };
                if (_local_20 < 0)
                {
                    _local_20 = (_local_20 + 8);
                };
                if (_local_20 > 7)
                {
                    _local_20 = (_local_20 - 8);
                };
                _local_7 = ((((((_arg_2.getScale() + "_") + _local_9.member) + "_") + _local_20) + "_") + _local_19);
                _local_6 = _arg_2.getAsset(_local_7);
                if (_local_6 != null)
                {
                    _local_8 = (_local_6.content as BitmapData).clone();
                    _local_18 = 1;
                    _local_12 = ((_arg_4.x - (1 * _local_6.offset.x)) + _local_14);
                    _local_13 = ((_arg_4.y - (1 * _local_6.offset.y)) + _local_15);
                    if (_local_9.ink == 33)
                    {
                        _local_11 = new Matrix(1, 0, 0, 1, (_local_12 - _arg_3.x), (_local_13 - _arg_3.y));
                        _arg_1.draw(_local_8, _local_11, null, "add", null, false);
                    }
                    else
                    {
                        _arg_1.copyPixels(_local_8, _local_8.rect, new Point((_local_12 - _arg_3.x), (_local_13 - _arg_3.y)));
                    };
                };
            };
        }

        private function removeEffectSprites():void
        {
            for each (var _local_1:IBitmapWrapperWindow in _SafeStr_1599)
            {
                _window.removeChild(_local_1);
                _local_1.dispose();
                _local_1 = null;
            };
            _SafeStr_1599 = [];
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if ((((disposed) || (page == null)) || (page.offers == null)))
            {
                return;
            };
            for each (var _local_3:IPurchasableOffer in page.offers)
            {
                if (_local_3.previewCallbackId == _arg_1)
                {
                    setPreviewImage(_arg_2, true);
                    _local_3.previewCallbackId = 0;
                    return;
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

        private function setPreviewFromAsset(_arg_1:String):void
        {
            if ((((((!(_arg_1)) || (!(page))) || (!(page.viewer))) || (!(page.viewer.catalog))) || (!(page.viewer.catalog.assets))))
            {
                return;
            };
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null)
            {
                retrievePreviewAsset(_arg_1);
                return;
            };
            setPreviewImage((_local_2.content as BitmapData), false);
        }

        private function retrievePreviewAsset(_arg_1:String):void
        {
            if (((((!(_arg_1)) || (!(page))) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return;
            };
            var _local_4:String = ((page.viewer.catalog.imageGalleryHost + _arg_1) + ".gif");
            Logger.log(("[Product View Catalog Widget] Retrieve Product Preview Asset: " + _local_4));
            var _local_2:URLRequest = new URLRequest(_local_4);
            if (!page.viewer.catalog.assets)
            {
                return;
            };
            var _local_3:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(_arg_1, _local_2, "image/gif");
            if (!_local_3)
            {
                return;
            };
            _local_3.addEventListener("AssetLoaderEventComplete", onPreviewImageReady);
        }

        private function onPreviewImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null)
            {
                setPreviewFromAsset(_local_2.assetName);
                _local_2.removeEventListener("AssetLoaderEventComplete", onPreviewImageReady);
            };
        }

        private function onStuffDataSet(_arg_1:SetRoomPreviewerStuffDataEvent):void
        {
            var _local_2:RoomPreviewer;
            _overrideStuffData = _arg_1.stuffData;
            if (_SafeStr_1600 != null)
            {
                _local_2 = (page.viewer.catalog as HabboCatalog).roomPreviewer;
                if (_local_2 != null)
                {
                    _local_2.reset(false);
                };
                onPreviewProduct(_SafeStr_1600);
            };
        }

        private function onSpinnerEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            var _local_2:IWindowContainer;
            if (_arg_1.type == "CWSE_VALUE_CHANGED")
            {
                _local_2 = (window.findChildByName("price_box_new") as IWindowContainer);
                if (((!(_local_2 == null)) && (!(_SafeStr_1600 == null))))
                {
                    _catalog.utils.showPriceInContainer(_local_2, _SafeStr_1600.offer);
                };
            };
        }

        private function onTotalPriceWidgetInitialized(_arg_1:Event):void
        {
            _SafeStr_1602 = true;
        }

        override public function closed():void
        {
            var _local_1:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            if (_local_1)
            {
                _local_1.disableUpdate = true;
            };
        }

        public function onDragAndDropDone(_arg_1:Boolean, _arg_2:String):void
        {
        }


    }
}


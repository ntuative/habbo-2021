package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.club.VipBenefitsWindow;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.assets.IAsset;
    import flash.geom.Matrix;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRuleset;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.room._SafeStr_147;
    import __AS3__.vec.Vector;

    public class HabboCatalogUtils implements IDisposable, IGetImageListener 
    {

        private static const PRICE_CREDIT:String = "credit";
        private static const PRICE_ACTIVITY_POINT:String = "activityPoint";

        private var BADGE_WIDGET_NAME:String = "HCU_dynamic_badge";
        private var _disposed:Boolean = false;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1656:VipBenefitsWindow;
        private var _bundleDiscountFlatPriceSteps:Array = new Array(0);
        private var _bundleDiscountHighestFlatPriceStep:int;
        private var _productBitmapWrappers:Dictionary = new Dictionary();
        private var _SafeStr_1657:Boolean = false;
        private var _SafeStr_1658:Boolean = false;
        private var _SafeStr_1659:Boolean = false;

        public function HabboCatalogUtils(_arg_1:HabboCatalog)
        {
            _catalog = _arg_1;
        }

        public static function buildersClub(_arg_1:String):Boolean
        {
            return ((_arg_1.indexOf("builders_club") == 0) || (_arg_1.indexOf("loyalty_bc") == 0));
        }

        public static function replaceCenteredImage(_arg_1:IBitmapWrapperWindow, _arg_2:BitmapData, _arg_3:Rectangle=null):void
        {
            if (!_arg_1.bitmap)
            {
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            }
            else
            {
                _arg_1.bitmap.fillRect(_arg_1.bitmap.rect, 0);
            };
            var _local_5:BitmapData = _arg_1.bitmap;
            var _local_4:Rectangle = ((_arg_3 != null) ? _arg_3 : _arg_2.rect);
            _local_5.copyPixels(_arg_2, _local_4, new Point(((_local_5.width - _local_4.width) / 2), ((_local_5.height - _local_4.height) / 2)), null, null, true);
            _arg_1.invalidate();
        }


        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_1656 != null)
                {
                    _SafeStr_1656.dispose();
                    _SafeStr_1656 = null;
                };
                _catalog = null;
                _productBitmapWrappers = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function createWindow(_arg_1:String, _arg_2:uint=1, _arg_3:Map=null):IWindow
        {
            var _local_5:Array;
            var _local_6:IBitmapWrapperWindow;
            if (((_catalog.windowManager == null) || (_catalog.assets == null)))
            {
                return (null);
            };
            var _local_9:XmlAsset = (_catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((_local_9 == null) || (_local_9.content == null)))
            {
                return (null);
            };
            var _local_8:IWindow = _catalog.windowManager.buildFromXML((_local_9.content as XML), _arg_2, _arg_3);
            var _local_4:IWindowContainer = (_local_8 as IWindowContainer);
            if (_local_4 != null)
            {
                _local_5 = [];
                _local_4.groupChildrenWithTag("bitmap", _local_5, -1);
                for each (var _local_7:IWindow in _local_5)
                {
                    _local_6 = (_local_7 as IBitmapWrapperWindow);
                    if (_local_6 != null)
                    {
                        _local_6.disposesBitmap = false;
                        setCatalogItemImage(_local_6, _local_6.bitmapAssetName);
                    };
                };
            };
            return (_local_8);
        }

        public function showPriceInContainer(_arg_1:IWindowContainer, _arg_2:IPurchasableOffer, _arg_3:int=1, _arg_4:Boolean=false, _arg_5:Boolean=false):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            var _local_6:Array = getPriceArray(_arg_2, _arg_3, _arg_4);
            renderPriceInContainer(_arg_1, _local_6, _arg_4, _arg_5, false);
        }

        private function renderPriceInContainer(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean):void
        {
            var _local_6:int;
            var _local_7:IItemListWindow = createPriceContainer(_arg_1);
            if (_local_7 == null)
            {
                return;
            };
            _local_6 = 0;
            while (_local_6 < _arg_2.length)
            {
                renderPriceItem(_local_7, _local_6, _arg_2[_local_6], _arg_3, _arg_4, _arg_5);
                _local_6++;
            };
            var _local_8:int = (_local_6 * 2);
            while (_local_7.numListItems > _local_8)
            {
                _local_7.removeListItemAt(_local_8);
            };
            _arg_1.addChild(_local_7);
        }

        private function renderPriceItem(_arg_1:IItemListWindow, _arg_2:int, _arg_3:Object, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean):void
        {
            var _local_7:ITextWindow = (_arg_1.getListItemByName(("amount_" + _arg_2)) as ITextWindow);
            var _local_8:IWindow = _arg_1.getListItemByName(("unit_" + _arg_2));
            _local_7.text = ((_arg_6) ? "" : (((_arg_2 > 0) ? "+ " : "") + _arg_3.amount));
            _local_8.style = _SafeStr_139.getIconStyleFor(_arg_3.unit, _catalog, true, _arg_5);
            _local_8.width = (((_arg_4) && (_arg_5)) ? 53 : 22);
        }

        private function createPriceContainer(_arg_1:IWindowContainer):IItemListWindow
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_2:IItemListWindow = (createWindow("price_display") as IItemListWindow);
            if (_local_2 == null)
            {
                return (null);
            };
            while (_arg_1.numChildren > 0)
            {
                _arg_1.removeChildAt(0).dispose();
            };
            return (_local_2);
        }

        private function getPriceArray(_arg_1:IPurchasableOffer, _arg_2:int, _arg_3:Boolean):Array
        {
            var _local_6:int;
            var _local_5:int = -1;
            var _local_4:Array = [];
            if (_arg_1.priceInCredits > 0)
            {
                _local_6 = calculateBundlePrice(_arg_1.bundlePurchaseAllowed, _arg_1.priceInCredits, _arg_2);
                _local_5 = ((_arg_3) ? _catalog.getSeasonalCurrencyActivityPointType() : -1);
                _local_4.push({
                    "amount":_local_6,
                    "unit":_local_5
                });
            };
            if (_arg_1.priceInActivityPoints > 0)
            {
                _local_6 = calculateBundlePrice(_arg_1.bundlePurchaseAllowed, _arg_1.priceInActivityPoints, _arg_2);
                _local_4.push({
                    "amount":_local_6,
                    "unit":_arg_1.activityPointType
                });
            };
            if (_local_4.length == 0)
            {
                _local_4.push({
                    "amount":0,
                    "unit":-1
                });
            };
            return (_local_4);
        }

        public function getPriceMap(_arg_1:IPurchasableOffer, _arg_2:int):Map
        {
            var _local_4:int;
            var _local_3:Map = new Map();
            if (_arg_1.priceInCredits > 0)
            {
                _local_4 = calculateBundlePrice(_arg_1.bundlePurchaseAllowed, _arg_1.priceInCredits, _arg_2);
                _local_3.add("credit", {"amount":_local_4});
            };
            if (_arg_1.priceInActivityPoints > 0)
            {
                _local_4 = calculateBundlePrice(_arg_1.bundlePurchaseAllowed, _arg_1.priceInActivityPoints, _arg_2);
                _local_3.add("activityPoint", {
                    "amount":_local_4,
                    "activityPointType":_arg_1.activityPointType
                });
            };
            if (_local_3.length == 0)
            {
                _local_3.add("credit", {"amount":0});
            };
            return (_local_3);
        }

        public function showPriceOnProduct(_arg_1:IPurchasableOffer, _arg_2:IWindowContainer, _arg_3:IWindow, _arg_4:IWindow, _arg_5:int, _arg_6:Boolean, _arg_7:int, _arg_8:Boolean=false, _arg_9:Boolean=false):IWindow
        {
            var _local_10:IWindow;
            if (_arg_3 != null)
            {
                _arg_2.removeChild(_arg_3);
                _arg_3.dispose();
            };
            if (_catalog.catalogType == "BUILDERS_CLUB")
            {
                return (null);
            };
            _arg_3 = _catalog.utils.createWindow("priceDisplayWidget");
            _arg_2.addChild(_arg_3);
            var _local_11:IWindowContainer = (_arg_2.findChildByName("price_box_new") as IWindowContainer);
            if (_local_11 != null)
            {
                _catalog.utils.showPriceInContainer(_local_11, _arg_1, 1, _arg_8, _arg_9);
                _local_10 = _arg_2.findChildByName("room_canvas_container");
                if (_local_10 == null)
                {
                    _local_10 = _arg_4;
                };
                if (_local_10 != null)
                {
                    _arg_3.x = (((_local_10.x + _local_10.width) + _arg_5) - _arg_3.width);
                    if (_arg_6)
                    {
                        _arg_3.y = (_local_10.y + _arg_7);
                    }
                    else
                    {
                        _arg_3.y = ((_local_10.y + _local_10.height) - (_arg_3.height + _arg_7));
                    };
                };
                if (_arg_1.priceInActivityPoints == 0)
                {
                    _arg_3.color = 14992765;
                };
                if (_arg_1.priceInCredits == 0)
                {
                    switch (_arg_1.activityPointType)
                    {
                        case 0:
                            _arg_3.color = 11257559;
                            break;
                        default:
                            _arg_3.color = 9032648;
                    };
                };
            };
            return (_arg_3);
        }

        public function showBadgeOnProduct(_arg_1:String, _arg_2:IWindowContainer, _arg_3:int, _arg_4:int, _arg_5:Boolean=true, _arg_6:Boolean=true):void
        {
            var _local_8:IWindowContainer = (_arg_2.findChildByName(BADGE_WIDGET_NAME) as IWindowContainer);
            if (_local_8 == null)
            {
                _local_8 = (createWindow("badgeDisplayWidget") as IWindowContainer);
                _local_8.name = BADGE_WIDGET_NAME;
            };
            IStaticBitmapWrapperWindow(_local_8.findChildByName("asset_image")).assetUri = "catalogue_badge_background";
            var _local_9:IWidgetWindow = (_local_8.findChildByName("badge_image") as IWidgetWindow);
            var _local_7:IBadgeImageWidget = (_local_9.widget as IBadgeImageWidget);
            _local_9.visible = true;
            _local_7.badgeId = _arg_1;
            _arg_2.addChild(_local_8);
            _local_8.x = ((_arg_6) ? _arg_3 : ((_arg_2.width - _local_8.width) - _arg_3));
            _local_8.y = ((_arg_5) ? _arg_4 : ((_arg_2.height - _local_8.height) - _arg_4));
        }

        public function hideBadgeFromProduct(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.findChildByName(BADGE_WIDGET_NAME) as IWindowContainer);
            if (_local_2)
            {
                _arg_1.removeChild(_local_2);
            };
        }

        public function showAssetImageAsBadgeOnProduct(_arg_1:String, _arg_2:IWindowContainer, _arg_3:int, _arg_4:int, _arg_5:Boolean=true, _arg_6:Boolean=true):void
        {
            var _local_7:IWindowContainer = (_arg_2.findChildByName(BADGE_WIDGET_NAME) as IWindowContainer);
            if (_local_7 == null)
            {
                _local_7 = (createWindow("badgeDisplayWidget") as IWindowContainer);
                _local_7.name = BADGE_WIDGET_NAME;
            };
            _local_7.findChildByName("badge_image").visible = false;
            IStaticBitmapWrapperWindow(_local_7.findChildByName("badge_image")).assetUri = _arg_1;
            _arg_2.addChild(_local_7);
            _local_7.x = ((_arg_6) ? _arg_3 : ((_arg_2.width - _local_7.width) - _arg_3));
            _local_7.y = ((_arg_5) ? _arg_4 : ((_arg_2.height - _local_7.height) - _arg_4));
        }

        public function setCatalogItemImage(_arg_1:IBitmapWrapperWindow, _arg_2:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_6:IAsset = _catalog.assets.getAssetByName(_arg_2);
            if (_local_6 == null)
            {
                return;
            };
            var _local_3:BitmapData = (_local_6.content as BitmapData);
            if (_local_3 == null)
            {
                return;
            };
            if (_arg_1.bitmap != null)
            {
                _arg_1.bitmap.dispose();
                _arg_1.bitmap = null;
            };
            if (_arg_1.bitmap == null)
            {
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            };
            var _local_4:int = ((_arg_1.width - _local_3.width) * 0.5);
            var _local_5:int = ((_arg_1.height - _local_3.height) * 0.5);
            _arg_1.bitmap.draw(_local_3, new Matrix(1, 0, 0, 1, _local_4, _local_5));
        }

        public function showVipBenefits():void
        {
            if (_catalog.getBoolean("catalog.vip.benefits.enabled"))
            {
                if (((_SafeStr_1656 == null) || (_SafeStr_1656.disposed)))
                {
                    _SafeStr_1656 = new VipBenefitsWindow(_catalog);
                };
            }
            else
            {
                openLink(_catalog.getProperty("link.format.club"));
            };
        }

        public function openLink(_arg_1:String):void
        {
            if (_arg_1 != "")
            {
                _catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, onExternalLinkAlertClose);
                HabboWebTools.openWebPage(_arg_1, "habboMain");
            };
        }

        private function onExternalLinkAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        public function calculateBundlePrice(_arg_1:Boolean, _arg_2:int, _arg_3:int):int
        {
            return (_arg_2 * _arg_3);
        }

        public function getDiscountItemsCount(_arg_1:int):int
        {
            var _local_2:int = getBasicBundleDiscountSize(_arg_1);
            _local_2 = (_local_2 + getBonusBundleDiscountSize(_arg_1));
            return (_local_2 + getThresholdBundleDiscountSize(_arg_1));
        }

        private function getBasicBundleDiscountSize(_arg_1:int):int
        {
            var _local_3:BundleDiscountRuleset = _catalog.bundleDiscountRuleset;
            if (((!(_local_3)) || (_local_3.bundleSize <= 0)))
            {
                return (0);
            };
            var _local_2:int = int((_arg_1 / _local_3.bundleSize));
            return (_local_2 * _local_3.bundleDiscountSize);
        }

        private function getBonusBundleDiscountSize(_arg_1:int):int
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:BundleDiscountRuleset = _catalog.bundleDiscountRuleset;
            if (((!(_local_3)) || (_local_3.bundleSize <= 0)))
            {
                return (0);
            };
            var _local_2:int = int((_arg_1 / _local_3.bundleSize));
            if (_local_2 >= _local_3.bonusThreshold)
            {
                _local_4 = (_arg_1 % _local_3.bundleSize);
                if (_local_4 == (_local_3.bundleSize - 1))
                {
                    _local_5++;
                };
                _local_5 = (_local_5 + (_local_2 - _local_3.bonusThreshold));
            };
            return (_local_5);
        }

        private function getThresholdBundleDiscountSize(_arg_1:int):int
        {
            var _local_4:int;
            var _local_2:BundleDiscountRuleset = _catalog.bundleDiscountRuleset;
            if (_local_2)
            {
                for each (var _local_3:int in _local_2.additionalBonusDiscountThresholdQuantities)
                {
                    if (_arg_1 >= _local_3)
                    {
                        _local_4++;
                    };
                };
            };
            return (_local_4);
        }

        public function get bundleDiscountFlatPriceSteps():Array
        {
            return (_bundleDiscountFlatPriceSteps);
        }

        public function get bundleDiscountHighestFlatPriceStep():int
        {
            return (_bundleDiscountHighestFlatPriceStep);
        }

        public function resolveBundleDiscountFlatPriceSteps():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            _bundleDiscountFlatPriceSteps = [];
            _bundleDiscountHighestFlatPriceStep = 0;
            _local_1 = 0;
            while (_local_1 < 99)
            {
                _local_2 = calculateBundlePrice(true, 1, _local_1);
                _local_3 = calculateBundlePrice(true, 1, (_local_1 + 1));
                if (_local_2 == _local_3)
                {
                    _bundleDiscountFlatPriceSteps.push(_local_1);
                    _bundleDiscountHighestFlatPriceStep = _local_1;
                };
                _local_1++;
            };
        }

        public function spinnerValueChangedEventTrack():void
        {
            if (!_SafeStr_1657)
            {
                HabboTracking.getInstance().trackEventLog("Catalog", "spinnerValueChanged", "client.bundle.discounts");
                _SafeStr_1657 = true;
            };
        }

        public function bundlesInfoShownEventTrack():void
        {
            if (!_SafeStr_1658)
            {
                HabboTracking.getInstance().trackEventLog("Catalog", "bundlesInfoOpened", "client.bundle.discounts");
                _SafeStr_1658 = true;
            };
        }

        public function discountShownEventTrack():void
        {
            if (!_SafeStr_1659)
            {
                HabboTracking.getInstance().trackEventLog("Catalog", "discountItemShown", "client.bundle.discounts");
                _SafeStr_1659 = true;
            };
        }

        public function displayProductIcon(_arg_1:String, _arg_2:int, _arg_3:IBitmapWrapperWindow):void
        {
            var _local_4:_SafeStr_147;
            var _local_5:Vector.<IBitmapWrapperWindow> = undefined;
            if (_catalog == null)
            {
                return;
            };
            switch (_arg_1)
            {
                case "s":
                    _local_4 = _catalog.roomEngine.getFurnitureIcon(_arg_2, this);
                    break;
                case "i":
                    _local_4 = _catalog.roomEngine.getWallItemIcon(_arg_2, this);
                    break;
                case "e":
                    _arg_3.bitmap = _catalog.getPixelEffectIcon(_arg_2);
                    break;
                case "h":
                    _arg_3.bitmap = _catalog.getSubscriptionProductIcon(_arg_2);
                    break;
                default:
            };
            if (_local_4 != null)
            {
                _arg_3.bitmap = _local_4.data;
                if (_local_4.id != 0)
                {
                    _local_5 = _productBitmapWrappers[_local_4.id];
                    if (_local_5 == null)
                    {
                        _local_5 = new Vector.<IBitmapWrapperWindow>(0);
                        _productBitmapWrappers[_local_4.id] = _local_5;
                    };
                    _local_5.push(_arg_3);
                };
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:Vector.<IBitmapWrapperWindow> = _productBitmapWrappers[_arg_1];
            if (_local_3 == null)
            {
                return;
            };
            for each (var _local_4:IBitmapWrapperWindow in _local_3)
            {
                _local_4.bitmap = _arg_2;
            };
            delete _productBitmapWrappers[_arg_1]; //not popped
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}


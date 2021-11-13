package com.sulake.habbo.catalog.club
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import flash.utils.Timer;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.assets.XmlAsset;

    public class ClubExtendConfirmationDialog 
    {

        private static const CREDIT_IMAGE_COUNT:int = 7;
        private static const YOUR_PRICE_ICON_BITMAP_ELEMENT_NAME:String = "your_price_icon_left";
        private static const _SafeStr_1427:String = "${image.library.catalogue.url}catalogue/vip_extend_tsr.png";
        private static const TEASER_IMAGE_MIME_TYPE:String = "image/png";
        private static const ANIMATION_TRIGGER_INTERVAL:int = 2000;
        private static const _SafeStr_1428:int = 75;
        private static const LINK_COLOR_DEFAULT:uint = 0;
        private static const LINK_COLOR_HOVER:uint = 9552639;

        private var _SafeStr_1284:ClubExtendController;
        private var _SafeStr_570:IFrameWindow;
        private var _offer:ClubOfferExtendData;
        private var _maybeLaterRegion:IRegionWindow;
        private var _SafeStr_1429:ITextWindow;
        private var _SafeStr_1430:IBitmapWrapperWindow;
        private var _SafeStr_1431:Vector.<BitmapData>;
        private var _SafeStr_1432:Timer;
        private var _SafeStr_1433:Timer;
        private var _animationFrame:int = 0;
        private var _SafeStr_1434:int = 0;
        private var _disposed:Boolean = false;
        private var _localizationKey:String = "catalog.club.extend.";

        public function ClubExtendConfirmationDialog(_arg_1:ClubExtendController, _arg_2:ClubOfferExtendData)
        {
            _SafeStr_1284 = _arg_1;
            _offer = _arg_2;
            _SafeStr_1431 = new Vector.<BitmapData>(7);
        }

        public function dispose():void
        {
            var _local_1:int;
            if (_disposed)
            {
                return;
            };
            _offer = null;
            _SafeStr_1284 = null;
            clearAnimation();
            if (_maybeLaterRegion)
            {
                _maybeLaterRegion.removeEventListener("WME_OUT", onMouseOutLaterRegion);
                _maybeLaterRegion.removeEventListener("WME_OVER", onMouseOverLaterRegion);
                _maybeLaterRegion = null;
            };
            if (_SafeStr_1429)
            {
                _SafeStr_1429 = null;
            };
            if (_SafeStr_1430)
            {
                _SafeStr_1430 = null;
            };
            if (_SafeStr_1431)
            {
                while (_local_1 < 7)
                {
                    _SafeStr_1431[_local_1].dispose();
                    _SafeStr_1431[_local_1] = null;
                    _local_1++;
                };
                _SafeStr_1431 = null;
            };
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            _disposed = true;
        }

        public function showConfirmation():void
        {
            var _local_10:IIconWindow;
            var _local_11:String;
            var _local_8:int;
            var _local_6:BitmapDataAsset;
            var _local_12:BitmapData;
            if ((((!(_offer)) || (!(_SafeStr_1284))) || (_disposed)))
            {
                return;
            };
            _SafeStr_570 = (createWindow("club_extend_confirmation") as IFrameWindow);
            if (!_SafeStr_570)
            {
                return;
            };
            _SafeStr_570.procedure = windowEventHandler;
            _SafeStr_570.center();
            if (!_offer.vip)
            {
                _localizationKey = (_localizationKey + "basic.");
                _local_10 = (_SafeStr_570.findChildByName("club_level_icon") as IIconWindow);
                if (_local_10)
                {
                    _local_10.style = 17;
                    _local_10.x = (_local_10.x + 15);
                };
            };
            var _local_3:IHabboLocalizationManager = _SafeStr_1284.localization;
            _SafeStr_570.findChildByName("normal_price_price_left").caption = _offer.originalPrice.toString();
            _SafeStr_570.findChildByName("normal_price_price_right").caption = _offer.originalActivityPointPrice.toString();
            _SafeStr_570.findChildByName("you_save_price_left").caption = _offer.discountCreditAmount.toString();
            _SafeStr_570.findChildByName("you_save_price_right").caption = _offer.discountActivityPointAmount.toString();
            _SafeStr_570.findChildByName("your_price_price_left").caption = _offer.priceCredits.toString();
            _SafeStr_570.findChildByName("your_price_price_right").caption = _offer.priceActivityPoints.toString();
            _SafeStr_570.title.caption = _local_3.getLocalization((_localizationKey + "confirm.caption"));
            _SafeStr_570.findChildByName("extend_title").caption = _local_3.getLocalization((_localizationKey + "confirm.title"));
            _SafeStr_570.findChildByName("normal_price_label").caption = _local_3.getLocalization((_localizationKey + "normal.label"));
            _SafeStr_570.findChildByName("you_save_label").caption = _local_3.getLocalization((_localizationKey + "save.label"));
            _SafeStr_570.findChildByName("your_price_label").caption = _local_3.getLocalization((_localizationKey + "price.label"));
            _SafeStr_570.findChildByName("buy_now_button").caption = _local_3.getLocalization((_localizationKey + "buy.button"));
            _SafeStr_570.findChildByName("maybe_later_link").caption = _local_3.getLocalization((_localizationKey + "later.link"));
            if (_offer.subscriptionDaysLeft > 1)
            {
                _local_3.registerParameter((_localizationKey + "expiration_days_left"), "day", _offer.subscriptionDaysLeft.toString());
                _local_3.registerParameter((_localizationKey + "expiration_days_left"), "duration", (31 * _offer.months).toString());
                _local_11 = _local_3.getLocalization((_localizationKey + "expiration_days_left"));
            }
            else
            {
                _local_11 = _local_3.getLocalization((_localizationKey + "expires_today"));
            };
            _SafeStr_570.findChildByName("offer_expiration").caption = _local_11;
            _maybeLaterRegion = (_SafeStr_570.findChildByName("maybe_later_region") as IRegionWindow);
            _SafeStr_1429 = (_SafeStr_570.findChildByName("maybe_later_link") as ITextWindow);
            if (((!(_maybeLaterRegion)) || (!(_SafeStr_1429))))
            {
                return;
            };
            _maybeLaterRegion.addEventListener("WME_OUT", onMouseOutLaterRegion);
            _maybeLaterRegion.addEventListener("WME_OVER", onMouseOverLaterRegion);
            var _local_5:BitmapData = getBitmapDataFromAsset("icon_credit_0");
            setElementBitmapData("normal_price_icon_left", _local_5);
            setElementBitmapData("you_save_icon_left", _local_5);
            setActivityPointIconStyle("normal_price_icon_right");
            setActivityPointIconStyle("you_save_icon_right");
            setActivityPointIconStyle("your_price_icon_right");
            var _local_1:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("club_teaser") as IBitmapWrapperWindow);
            _local_1.x = 1;
            _local_1.y = (_SafeStr_570.height - 144);
            _local_1.height = 144;
            _local_1.width = 133;
            var _local_7:String = _SafeStr_1284.config.interpolate("${image.library.catalogue.url}catalogue/vip_extend_tsr.png");
            if (_SafeStr_1284.config)
            {
                _local_7 = _SafeStr_1284.config.updateUrlProtocol(_local_7);
            };
            loadAssetFromUrl("club_teaser", "club_teaser", _local_7, "image/png", onTeaserLoaded);
            var _local_9:IItemListWindow = (_SafeStr_570.findChildByName("itemlist_vertical") as IItemListWindow);
            if (!_local_9)
            {
                return;
            };
            var _local_4:IWindowContainer = (_SafeStr_570.findChildByName("total_amount_line") as IWindowContainer);
            if (!_local_4)
            {
                return;
            };
            var _local_2:IWindowContainer = (_SafeStr_570.findChildByName("background_container") as IWindowContainer);
            if (!_local_2)
            {
                return;
            };
            _local_2.height = ((_local_9.y + _local_4.height) + _local_4.y);
            _SafeStr_1430 = (_SafeStr_570.findChildByName("your_price_icon_left") as IBitmapWrapperWindow);
            if (_SafeStr_1430 == null)
            {
                return;
            };
            _local_8 = 0;
            while (_local_8 < 7)
            {
                _local_6 = (_SafeStr_1284.assets.getAssetByName(("icon_credit_" + _local_8)) as BitmapDataAsset);
                _local_12 = (_local_6.content as BitmapData);
                _SafeStr_1431[_local_8] = _local_12.clone();
                _local_8++;
            };
            startAnimation();
        }

        private function setActivityPointIconStyle(_arg_1:String):void
        {
            var _local_2:IWindow = _SafeStr_570.findChildByName(_arg_1);
            _local_2.style = _SafeStr_139.getIconStyleFor(_offer.originalActivityPointType, _SafeStr_1284.config, true);
        }

        private function onMouseOutLaterRegion(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_1429)
            {
                _SafeStr_1429.textColor = 0;
            };
        }

        private function onMouseOverLaterRegion(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_1429)
            {
                _SafeStr_1429.textColor = 9552639;
            };
        }

        private function startAnimation():void
        {
            if (_SafeStr_1432)
            {
                clearAnimation();
            };
            setAnimationFrame();
            _SafeStr_1432 = new Timer(2000);
            _SafeStr_1432.addEventListener("timer", onAnimationTrigger);
            _SafeStr_1432.start();
        }

        private function clearAnimation():void
        {
            _animationFrame = 0;
            _SafeStr_1434 = 0;
            if (_SafeStr_1433)
            {
                _SafeStr_1433.stop();
                _SafeStr_1433 = null;
            };
            if (_SafeStr_1432)
            {
                _SafeStr_1432.stop();
                _SafeStr_1432 = null;
            };
        }

        private function setAnimationFrame():void
        {
            if (!_SafeStr_1430)
            {
                return;
            };
            if (_SafeStr_1430.bitmap)
            {
                _SafeStr_1430.bitmap.dispose();
            };
            if (_animationFrame < 7)
            {
                _SafeStr_1430.bitmap = new BitmapData(_SafeStr_1430.width, _SafeStr_1430.height, true, 0);
                _SafeStr_1430.bitmap.copyPixels(_SafeStr_1431[_animationFrame], _SafeStr_1431[_animationFrame].rect, new Point(0, 0));
            }
            else
            {
                Logger.log(("Animation frame " + _animationFrame));
            };
        }

        private function startAnimationFrame():void
        {
            _SafeStr_1433 = new Timer(75, (7 - 1));
            _SafeStr_1433.addEventListener("timer", onAnimationFrame);
            _SafeStr_1433.addEventListener("timerComplete", onAnimationFrameComplete);
            _SafeStr_1433.start();
        }

        private function onAnimationTrigger(_arg_1:TimerEvent):void
        {
            startAnimationFrame();
        }

        private function onAnimationFrame(_arg_1:TimerEvent):void
        {
            _animationFrame = (_animationFrame + 1);
            setAnimationFrame();
        }

        private function onAnimationFrameComplete(_arg_1:TimerEvent):void
        {
            if (_SafeStr_1433)
            {
                _SafeStr_1433.stop();
                _SafeStr_1433 = null;
            };
            _animationFrame = 0;
            setAnimationFrame();
            if (_SafeStr_1434 == 0)
            {
                _SafeStr_1434 = 1;
                startAnimationFrame();
            }
            else
            {
                _SafeStr_1434 = 0;
            };
        }

        private function getBitmapDataFromAsset(_arg_1:String):BitmapData
        {
            var _local_2:BitmapDataAsset = (_SafeStr_1284.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 != null)
            {
                return (_local_2.content as BitmapData);
            };
            return (null);
        }

        private function setElementBitmapData(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (_SafeStr_570.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3.bitmap != null)
            {
                _local_3.bitmap.dispose();
            };
            if (((!(_arg_2 == null)) && (!(_local_3 == null))))
            {
                if (_local_3.width != _arg_2.width)
                {
                    _local_3.width = _arg_2.width;
                };
                if (_local_3.height != _arg_2.height)
                {
                    _local_3.height = _arg_2.height;
                };
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(0, 0));
            };
        }

        private function loadAssetFromUrl(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Function):Boolean
        {
            var _local_8:BitmapData = getBitmapDataFromAsset(_arg_2);
            if (_local_8 != null)
            {
                setElementBitmapData(_arg_1, _local_8);
                return (true);
            };
            var _local_6:URLRequest = new URLRequest(_arg_3);
            var _local_7:AssetLoaderStruct = _SafeStr_1284.assets.loadAssetFromFile(_arg_2, _local_6, _arg_4);
            if (!_local_7)
            {
                return (false);
            };
            _local_7.addEventListener("AssetLoaderEventComplete", _arg_5);
            return (true);
        }

        private function onTeaserLoaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            var _local_3:BitmapData;
            if (!_disposed)
            {
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2 != null)
                {
                    _local_3 = getBitmapDataFromAsset(_local_2.assetName);
                    setElementBitmapData("club_teaser", _local_3);
                };
            };
        }

        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((((!(_arg_1)) || (!(_arg_2))) || (!(_SafeStr_1284))) || (!(_offer))) || (_disposed)))
            {
                return;
            };
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "buy_now_button":
                    _SafeStr_1284.confirmSelection();
                    return;
                case "header_button_close":
                case "maybe_later_region":
                    _SafeStr_1284.closeConfirmation();
                    return;
            };
        }

        private function createWindow(_arg_1:String):IWindow
        {
            if (((((!(_SafeStr_1284)) || (!(_SafeStr_1284.assets))) || (!(_SafeStr_1284.windowManager))) || (_disposed)))
            {
                return (null);
            };
            var _local_3:XmlAsset = (_SafeStr_1284.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_3)) || (!(_local_3.content))))
            {
                return (null);
            };
            var _local_2:XML = (_local_3.content as XML);
            if (!_local_2)
            {
                return (null);
            };
            return (_SafeStr_1284.windowManager.buildFromXML(_local_2));
        }


    }
}


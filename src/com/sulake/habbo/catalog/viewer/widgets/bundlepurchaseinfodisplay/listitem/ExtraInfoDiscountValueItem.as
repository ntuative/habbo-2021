package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import flash.utils.Timer;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.HabboCatalogUtils;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.BitmapDataAsset;

    public class ExtraInfoDiscountValueItem extends UpdateableExtraInfoListItem 
    {

        private static const ELEMENT_SPLASH_STAR:String = "icon_splash_bitmap";
        private static const _SafeStr_1511:String = "icon_bitmap";
        private static const _SafeStr_1512:String = "total_currency_value_left";
        private static const _SafeStr_1513:String = "total_currency_icon_left";
        private static const ELEMENT_TOTAL_LEFT_CURRENCY_STRIKETHROUGH:String = "striketrough_total_currency_left";
        private static const _SafeStr_1514:String = "total_currency_value_right";
        private static const _SafeStr_1515:String = "total_currency_icon_right";
        private static const ELEMENT_TOTAL_RIGHT_CURRENCY_STRIKETHROUGH:String = "striketrough_total_currency_right";
        private static const _SafeStr_1516:String = "discount_currency_value_left";
        private static const _SafeStr_1517:String = "discount_currency_icon_left";
        private static const _SafeStr_1518:String = "discount_currency_value_right";
        private static const _SafeStr_1519:String = "discount_currency_icon_right";
        private static const STRIKETHROUGH_LEFT_MARGIN:int = 4;
        private static const STRIKETHROUGH_RIGHT_MARGIN:int = 20;

        private var _window:IWindowContainer = null;
        private var _SafeStr_1520:Boolean = true;
        private var _catalog:HabboCatalog;
        private var _starAnimationOffset:int = 0;
        private var _SafeStr_1510:Timer;
        private var _SafeStr_1521:Boolean;
        private var _SafeStr_1522:Boolean;
        private var _SafeStr_1523:Boolean;
        private var _SafeStr_1524:Boolean = false;

        public function ExtraInfoDiscountValueItem(_arg_1:int, _arg_2:ExtraInfoItemData, _arg_3:HabboCatalog)
        {
            super(null, _arg_1, _arg_2, 1, true);
            _catalog = _arg_3;
            _SafeStr_1510 = new Timer(150);
            _SafeStr_1510.addEventListener("timer", starAnimationTimerEvent);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_1510 != null)
                {
                    _SafeStr_1510.stop();
                    _SafeStr_1510 = null;
                };
                _catalog = null;
                super.dispose();
            };
        }

        override public function update(_arg_1:ExtraInfoItemData):void
        {
            super.update(_arg_1);
            _SafeStr_1521 = false;
            _SafeStr_1522 = false;
            _SafeStr_1523 = false;
            if (((_arg_1.priceCredits > 0) && (_arg_1.priceActivityPoints > 0)))
            {
                _SafeStr_1521 = true;
            }
            else
            {
                if (((_arg_1.priceActivityPoints > 0) && (_arg_1.priceCredits == 0)))
                {
                    _SafeStr_1523 = true;
                }
                else
                {
                    _SafeStr_1522 = true;
                };
            };
            _SafeStr_1520 = true;
            render();
            if (!_SafeStr_1524)
            {
                setCurrencyIcons();
            };
        }

        override public function getRenderedWindow():IWindowContainer
        {
            if (_SafeStr_1520)
            {
                render();
            };
            return (_window);
        }

        private function createWindow():void
        {
            _window = IWindowContainer(_catalog.utils.createWindow("discountValueItem"));
            setElementBitmap("icon_bitmap", "thumb_up");
            startSplashAnimation();
        }

        private function render():void
        {
            if (_window == null)
            {
                createWindow();
            };
            updateColumns();
            updatePriceIndicators();
            updateStrikeThroughElements();
            _SafeStr_1520 = false;
        }

        private function updateColumns():void
        {
            if (((_SafeStr_1523) || (_SafeStr_1522)))
            {
                setLeftColumnVisibility(false);
            }
            else
            {
                setLeftColumnVisibility(true);
            };
        }

        private function setCurrencyIcons():void
        {
            if (_SafeStr_1521)
            {
                setIconStyle("total_currency_icon_left", -1);
                setIconStyle("discount_currency_icon_left", -1);
            };
            if (_SafeStr_1522)
            {
                setIconStyle("total_currency_icon_right", -1);
                setIconStyle("discount_currency_icon_right", -1);
            }
            else
            {
                setIconStyle("total_currency_icon_right", data.activityPointType);
                setIconStyle("discount_currency_icon_right", data.activityPointType);
            };
            _SafeStr_1524 = true;
        }

        private function updatePriceIndicators():void
        {
            if (_SafeStr_1521)
            {
                setElementText("total_currency_value_left", (data.quantity * data.priceCredits).toString());
                setElementText("discount_currency_value_left", ((data.quantity * data.priceCredits) - data.discountPriceCredits).toString());
            };
            if (_SafeStr_1522)
            {
                setElementText("total_currency_value_right", (data.quantity * data.priceCredits).toString());
                setElementText("discount_currency_value_right", ((data.quantity * data.priceCredits) - data.discountPriceCredits).toString());
            }
            else
            {
                setElementText("total_currency_value_right", (data.quantity * data.priceActivityPoints).toString());
                setElementText("discount_currency_value_right", ((data.quantity * data.priceActivityPoints) - data.discountPriceActivityPoints).toString());
            };
        }

        private function updateStrikeThroughElements():void
        {
            var _local_4:ITextWindow = ITextWindow(_window.findChildByName("total_currency_value_left"));
            var _local_2:int = ((_local_4.x + _local_4.width) - _local_4.textWidth);
            var _local_5:IWindowContainer = IWindowContainer(_window.findChildByName("striketrough_total_currency_left"));
            _local_5.x = (_local_2 - 4);
            _local_5.width = ((4 + _local_4.textWidth) + 20);
            var _local_1:ITextWindow = ITextWindow(_window.findChildByName("total_currency_value_right"));
            var _local_3:int = ((_local_1.x + _local_1.width) - _local_1.textWidth);
            var _local_6:IWindowContainer = IWindowContainer(_window.findChildByName("striketrough_total_currency_right"));
            _local_6.x = (_local_3 - 4);
            _local_6.width = ((4 + _local_1.textWidth) + 20);
        }

        private function setElementText(_arg_1:String, _arg_2:String):void
        {
            _window.findChildByName(_arg_1).caption = _arg_2;
        }

        private function setElementBitmap(_arg_1:String, _arg_2:String):void
        {
            var _local_4:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName(_arg_1));
            var _local_3:BitmapData = BitmapData(_catalog.assets.getAssetByName(_arg_2).content);
            HabboCatalogUtils.replaceCenteredImage(_local_4, _local_3);
        }

        private function setIconStyle(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IWindow = _window.findChildByName(_arg_1);
            _local_3.style = _SafeStr_139.getIconStyleFor(_arg_2, _catalog, false);
        }

        private function setLeftColumnVisibility(_arg_1:Boolean):void
        {
            var _local_2:Array = ["discount_currency_icon_left", "discount_currency_value_left", "total_currency_icon_left", "striketrough_total_currency_left", "total_currency_value_left"];
            for each (var _local_3:String in _local_2)
            {
                _window.findChildByName(_local_3).visible = _arg_1;
            };
        }

        private function startSplashAnimation():void
        {
            var _local_1:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("icon_splash_bitmap"));
            _local_1.bitmap = new BitmapData(_local_1.width, _local_1.height, true, 0);
            starAnimationTimerEvent(new TimerEvent("timer"));
            _SafeStr_1510.start();
        }

        private function starAnimationTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_2:IBitmapWrapperWindow;
            var _local_3:IAsset;
            if (_window != null)
            {
                _local_2 = IBitmapWrapperWindow(_window.findChildByName("icon_splash_bitmap"));
                _local_3 = _catalog.assets.getAssetByName(("bundle_discount_star_" + _starAnimationOffset));
                HabboCatalogUtils.replaceCenteredImage(_local_2, BitmapData(_local_3.content), BitmapDataAsset(_local_3).rectangle);
                if (++_starAnimationOffset > 7)
                {
                    _starAnimationOffset = 0;
                };
            };
        }


    }
}


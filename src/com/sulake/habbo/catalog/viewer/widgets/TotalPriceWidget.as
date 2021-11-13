package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemListWindow;

    public class TotalPriceWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
        private static const ELEMENT_PLUS:String = "plus";
        private static const _SafeStr_1633:String = "amount_text_left";
        private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
        private static const _SafeStr_1634:String = "total_left";
        private static const ELEMENT_TOTAL_RIGHT:String = "total_right";
        private static const _SafeStr_1635:String = "currency_indicator_bitmap_left";
        private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";

        private var _catalog:HabboCatalog;
        private var _SafeStr_1545:int;
        private var _SafeStr_1546:int;
        private var _SafeStr_1547:int;
        private var _SafeStr_1636:IWindow;
        private var _SafeStr_1637:IWindow;
        private var _SafeStr_1638:IWindowContainer;
        private var _SafeStr_1639:IWindowContainer;
        private var _SafeStr_1482:int = 1;

        public function TotalPriceWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _catalog = null;
                events.removeEventListener("CWSE_VALUE_CHANGED", onSpinnerValueChangedEvent);
                events.removeEventListener("SELECT_PRODUCT", onSelectProductEvent);
                clear();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("totalPriceWidget");
            window.visible = false;
            if (!_catalog.multiplePurchaseEnabled)
            {
                return (true);
            };
            events.addEventListener("CWSE_VALUE_CHANGED", onSpinnerValueChangedEvent);
            events.addEventListener("SELECT_PRODUCT", onSelectProductEvent);
            events.dispatchEvent(new Event("TOTAL_PRICE_WIDGET_INITIALIZED"));
            return (true);
        }

        private function onSpinnerValueChangedEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            _SafeStr_1482 = _arg_1.value;
            updateCurrencyIndicators();
        }

        private function onSelectProductEvent(_arg_1:SelectProductEvent):void
        {
            window.visible = _arg_1.offer.bundlePurchaseAllowed;
            _SafeStr_1545 = _arg_1.offer.priceInCredits;
            _SafeStr_1546 = _arg_1.offer.priceInActivityPoints;
            _SafeStr_1547 = _arg_1.offer.activityPointType;
            _SafeStr_1482 = 1;
            clear();
            createCurrencyIndicators();
            updateCurrencyIndicators();
        }

        private function clear():void
        {
            _SafeStr_1636 = null;
            _SafeStr_1637 = null;
            _SafeStr_1638 = null;
            _SafeStr_1639 = null;
            _window.findChildByName("plus").visible = false;
            _window.findChildByName("amount_text_left").visible = false;
            if (_window.findChildByName("total_left"))
            {
                _window.findChildByName("total_left").visible = false;
            };
            if (_window.findChildByName("total_right"))
            {
                _window.findChildByName("total_right").visible = false;
            };
            _window.findChildByName("currency_indicator_bitmap_left").visible = false;
        }

        private function updateCurrencyIndicators():void
        {
            var _local_4:IWindow;
            var _local_6:IWindow;
            var _local_3:int = (_SafeStr_1482 * _SafeStr_1545);
            var _local_5:int = (_SafeStr_1482 * _SafeStr_1546);
            var _local_1:int = _local_3;
            var _local_2:int = _local_5;
            if (_catalog.bundleDiscountEnabled)
            {
                _local_1 = _catalog.utils.calculateBundlePrice(true, _SafeStr_1545, _SafeStr_1482);
                _local_2 = _catalog.utils.calculateBundlePrice(true, _SafeStr_1546, _SafeStr_1482);
            };
            if (_SafeStr_1636 != null)
            {
                _SafeStr_1636.caption = ((_catalog.bundleDiscountEnabled) ? _local_1.toString() : _local_3.toString());
            };
            if (_SafeStr_1637 != null)
            {
                _SafeStr_1637.caption = ((_catalog.bundleDiscountEnabled) ? _local_2.toString() : _local_5.toString());
            };
            if (_SafeStr_1638)
            {
                _SafeStr_1638.visible = (!(_local_3 == _local_1));
                _local_4 = _SafeStr_1638.findChildByName("text");
                _local_4.caption = ((_SafeStr_1638.visible) ? _local_3.toString() : "0");
                _SafeStr_1638.findChildByName("strike").width = _local_4.width;
            };
            if (_SafeStr_1639)
            {
                _SafeStr_1639.visible = (!(_local_5 == _local_2));
                _local_6 = _SafeStr_1639.findChildByName("text");
                _local_6.caption = ((_SafeStr_1639.visible) ? _local_5.toString() : "0");
                _SafeStr_1639.findChildByName("strike").width = _local_6.width;
            };
        }

        private function createCurrencyIndicators():void
        {
            var _local_1:IWindow;
            var _local_2:IWindow;
            if (_SafeStr_1545 > 0)
            {
                if (_SafeStr_1546 > 0)
                {
                    _SafeStr_1636 = _window.findChildByName("amount_text_left");
                    _SafeStr_1636.visible = true;
                    _SafeStr_1638 = (_window.findChildByName("total_left") as IWindowContainer);
                    if (_SafeStr_1638)
                    {
                        _SafeStr_1638.visible = false;
                    };
                    _local_1 = _window.findChildByName("currency_indicator_bitmap_left");
                    _local_1.visible = true;
                    _window.findChildByName("plus").visible = true;
                }
                else
                {
                    _SafeStr_1636 = _window.findChildByName("amount_text_right");
                    _SafeStr_1638 = (_window.findChildByName("total_right") as IWindowContainer);
                    if (_SafeStr_1638)
                    {
                        _SafeStr_1638.visible = false;
                    };
                    _local_1 = _window.findChildByName("currency_indicator_bitmap_right");
                };
                if (page.acceptSeasonCurrencyAsCredits)
                {
                    _local_1.style = _SafeStr_139.getIconStyleFor(_catalog.getSeasonalCurrencyActivityPointType(), _catalog, true, true);
                    _local_1.width = 53;
                }
                else
                {
                    _local_1.style = _SafeStr_139.getIconStyleFor(-1, _catalog, true);
                    _local_1.width = 22;
                };
            };
            if (_SafeStr_1546 > 0)
            {
                _SafeStr_1637 = ITextWindow(_window.findChildByName("amount_text_right"));
                _SafeStr_1639 = (_window.findChildByName("total_left") as IWindowContainer);
                if (_SafeStr_1639)
                {
                    _SafeStr_1639.visible = false;
                };
                _local_2 = _window.findChildByName("currency_indicator_bitmap_right");
                _local_2.style = _SafeStr_139.getIconStyleFor(_SafeStr_1547, _catalog, true);
            };
            IItemListWindow(_window.findChildByName("totalprice_container")).arrangeListItems();
        }


    }
}


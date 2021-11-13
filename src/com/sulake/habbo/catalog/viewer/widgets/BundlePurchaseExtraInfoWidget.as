package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoViewManager;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
    import flash.events.TimerEvent;

    public class BundlePurchaseExtraInfoWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const PROMO_ITEM_DROP_DELAY_MS:uint = 4000;

        private var _catalog:HabboCatalog;
        private var _SafeStr_1543:ExtraInfoViewManager;
        private var _SafeStr_1544:int = 1;
        private var _SafeStr_1545:int;
        private var _SafeStr_1546:int;
        private var _SafeStr_1547:int;
        private var _SafeStr_1548:String;
        private var _SafeStr_1549:int = -1;
        private var _SafeStr_1550:int = -1;
        private var _SafeStr_1551:int = -1;
        private var _SafeStr_1552:Boolean = false;
        private var _SafeStr_1553:Timer;

        public function BundlePurchaseExtraInfoWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _SafeStr_1543.dispose();
                _SafeStr_1543 = null;
                _catalog = null;
                _SafeStr_1553.stop();
                _SafeStr_1553.removeEventListener("timerComplete", onPromoItemDropDownTimerEvent);
                _SafeStr_1553 = null;
                events.removeEventListener("CWPPEIE_RESET", onResetEvent);
                events.removeEventListener("CWPPEIE_HIDE", onHideEvent);
                events.removeEventListener("CWSE_VALUE_CHANGED", onSpinnerEvent);
                events.removeEventListener("CWPPEIE_ITEM_CLICKED", onExtraInfoItemClickedEvent);
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!_catalog.multiplePurchaseEnabled)
            {
                return (true);
            };
            _SafeStr_1543 = new ExtraInfoViewManager(this, _catalog);
            events.addEventListener("CWPPEIE_RESET", onResetEvent);
            events.addEventListener("CWPPEIE_HIDE", onHideEvent);
            events.addEventListener("CWSE_VALUE_CHANGED", onSpinnerEvent);
            events.addEventListener("CWPPEIE_ITEM_CLICKED", onExtraInfoItemClickedEvent);
            _SafeStr_1553 = new Timer(4000, 1);
            _SafeStr_1553.addEventListener("timerComplete", onPromoItemDropDownTimerEvent);
            return (true);
        }

        private function createPromoItem():void
        {
            var _local_1:ExtraInfoItemData = new ExtraInfoItemData(0);
            _local_1.quantity = _SafeStr_1544;
            _SafeStr_1549 = _SafeStr_1543.addItem(_local_1);
        }

        private function updatePromoItem(_arg_1:int):void
        {
            var _local_3:UpdateableExtraInfoListItem;
            var _local_2:ExtraInfoItemData;
            if (_SafeStr_1549 != -1)
            {
                _local_3 = UpdateableExtraInfoListItem(_SafeStr_1543.getItem(_SafeStr_1549));
                _local_2 = _local_3.data;
                _local_2.quantity = _arg_1;
                _local_3.update(_local_2);
            };
        }

        private function removePromoItem():void
        {
            if (_SafeStr_1549 != -1)
            {
                _SafeStr_1543.removeItem(_SafeStr_1549);
                _SafeStr_1549 = -1;
            };
        }

        private function createDiscountValueItem():void
        {
            var _local_1:ExtraInfoItemData = new ExtraInfoItemData(2);
            _local_1.quantity = _SafeStr_1544;
            _local_1.priceActivityPoints = _SafeStr_1546;
            _local_1.activityPointType = _SafeStr_1547;
            _local_1.priceCredits = _SafeStr_1545;
            _SafeStr_1550 = _SafeStr_1543.addItem(_local_1);
            _catalog.utils.discountShownEventTrack();
        }

        private function updateDiscountValueItem(_arg_1:int):void
        {
            var _local_2:UpdateableExtraInfoListItem;
            var _local_3:ExtraInfoItemData;
            if (_SafeStr_1550 != -1)
            {
                _local_2 = UpdateableExtraInfoListItem(_SafeStr_1543.getItem(_SafeStr_1550));
                _local_3 = _local_2.data;
                _local_3.quantity = _arg_1;
                _local_3.discountPriceCredits = _catalog.utils.calculateBundlePrice(true, _SafeStr_1545, _arg_1);
                _local_3.discountPriceActivityPoints = _catalog.utils.calculateBundlePrice(true, _SafeStr_1546, _arg_1);
                _local_2.update(_local_3);
            };
        }

        private function removeDiscountValueItem():void
        {
            if (_SafeStr_1550 != -1)
            {
                _SafeStr_1543.removeItem(_SafeStr_1550);
                _SafeStr_1550 = -1;
            };
        }

        private function createBundleInfoItem():void
        {
            var _local_1:ExtraInfoItemData = new ExtraInfoItemData(1);
            _SafeStr_1551 = _SafeStr_1543.addItem(_local_1);
            _catalog.utils.bundlesInfoShownEventTrack();
        }

        private function removeBundleInfoItem():void
        {
            if (_SafeStr_1551 != -1)
            {
                _SafeStr_1543.removeItem(_SafeStr_1551);
                _SafeStr_1551 = -1;
            };
        }

        private function onResetEvent(_arg_1:CatalogWidgetBundleDisplayExtraInfoEvent):void
        {
            if (disposed)
            {
                return;
            };
            window.visible = true;
            _SafeStr_1545 = _arg_1.data.priceCredits;
            _SafeStr_1546 = _arg_1.data.priceActivityPoints;
            _SafeStr_1547 = _arg_1.data.activityPointType;
            _SafeStr_1548 = _arg_1.data.badgeCode;
            _SafeStr_1543.clear();
            _SafeStr_1550 = -1;
            _SafeStr_1549 = -1;
            _SafeStr_1553.start();
        }

        private function onSpinnerEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            if (disposed)
            {
                return;
            };
            if (!_catalog.bundleDiscountEnabled)
            {
                return;
            };
            if (_arg_1.type == "CWSE_VALUE_CHANGED")
            {
                if (_arg_1.value != _SafeStr_1544)
                {
                    if (((_arg_1.value >= _catalog.bundleDiscountRuleset.bundleSize) && (_SafeStr_1550 == -1)))
                    {
                        createDiscountValueItem();
                    }
                    else
                    {
                        if (_arg_1.value < _catalog.bundleDiscountRuleset.bundleSize)
                        {
                            removeDiscountValueItem();
                        };
                    };
                    updatePromoItem(_arg_1.value);
                    updateDiscountValueItem(_arg_1.value);
                    _SafeStr_1544 = _arg_1.value;
                    removeBundleInfoItem();
                    if (_SafeStr_1544 >= _catalog.utils.bundleDiscountHighestFlatPriceStep)
                    {
                        removePromoItem();
                        _SafeStr_1552 = true;
                    }
                    else
                    {
                        if (_SafeStr_1552)
                        {
                            createPromoItem();
                            _SafeStr_1552 = false;
                        };
                    };
                    _catalog.utils.spinnerValueChangedEventTrack();
                };
            };
        }

        private function onHideEvent(_arg_1:CatalogWidgetBundleDisplayExtraInfoEvent):void
        {
            window.visible = false;
        }

        private function onExtraInfoItemClickedEvent(_arg_1:CatalogWidgetBundleDisplayExtraInfoEvent):void
        {
            switch (_arg_1.id)
            {
                case _SafeStr_1549:
                    if (_SafeStr_1551 == -1)
                    {
                        createBundleInfoItem();
                    };
                    return;
                case _SafeStr_1551:
                    removeBundleInfoItem();
                    return;
            };
        }

        private function onPromoItemDropDownTimerEvent(_arg_1:TimerEvent):void
        {
            createPromoItem();
        }


    }
}


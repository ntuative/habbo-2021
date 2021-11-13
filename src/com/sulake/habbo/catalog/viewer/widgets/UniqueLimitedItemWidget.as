package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.window.utils.ILimitedItemOverlay;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import flash.utils.Timer;
    import com.sulake.habbo.window.widgets.ILimitedItemSupplyLeftOverlayWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import flash.events.TimerEvent;

    public class UniqueLimitedItemWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const SUPPLY_REFRESH_PERIOD_MS:int = 20000;

        private var _catalog:HabboCatalog;
        private var _overlay:ILimitedItemOverlay;
        private var _SafeStr_1642:IPurchasableOffer;
        private var _SafeStr_1643:Timer;
        private var _overlayWidget:ILimitedItemSupplyLeftOverlayWidget;

        public function UniqueLimitedItemWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_1643 != null)
                {
                    _SafeStr_1643.stop();
                    _SafeStr_1643.removeEventListener("timer", onSupplyLeftTimer);
                    _SafeStr_1643 = null;
                };
                window.visible = false;
                _catalog = null;
                _SafeStr_1642 = null;
                if (_overlay)
                {
                    _overlay.dispose();
                    _overlay = null;
                };
                events.removeEventListener("SELECT_PRODUCT", onSelectProduct);
                events.removeEventListener("CWE_PRODUCT_OFFER_UPDATED", onOfferUpdated);
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            var _local_1:IWidgetWindow = IWidgetWindow(_window.findChildByName("unique_item_overlay_container"));
            _overlayWidget = ILimitedItemSupplyLeftOverlayWidget(_local_1.widget);
            window.visible = false;
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            events.addEventListener("CWE_PRODUCT_OFFER_UPDATED", onOfferUpdated);
            _SafeStr_1643 = new Timer(20000);
            _SafeStr_1643.addEventListener("timer", onSupplyLeftTimer);
            return (true);
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_1642 = _arg_1.offer;
            update(_arg_1.offer, true);
        }

        private function onOfferUpdated(_arg_1:ProductOfferUpdatedEvent):void
        {
            _SafeStr_1642 = _arg_1.offer;
            update(_arg_1.offer);
        }

        private function update(_arg_1:IPurchasableOffer, _arg_2:Boolean=false):void
        {
            var _local_3:IProduct;
            if (((_arg_1.pricingModel == "pricing_model_single") && (_arg_1.product.isUniqueLimitedItem)))
            {
                _local_3 = _arg_1.product;
                _overlayWidget.supplyLeft = _local_3.uniqueLimitedItemsLeft;
                _overlayWidget.seriesSize = _local_3.uniqueLimitedItemSeriesSize;
                window.visible = true;
                if (_arg_2)
                {
                    _catalog.sendGetProductOffer(_arg_1.offerId);
                };
                _SafeStr_1643.start();
            }
            else
            {
                window.visible = false;
                _SafeStr_1643.stop();
            };
        }

        private function onSupplyLeftTimer(_arg_1:TimerEvent):void
        {
            if (((_window.visible) && (!(_SafeStr_1642 == null))))
            {
                update(_SafeStr_1642, true);
            };
        }


    }
}


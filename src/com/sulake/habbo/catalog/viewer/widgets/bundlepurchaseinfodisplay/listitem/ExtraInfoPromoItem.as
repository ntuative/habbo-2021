package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
    import flash.utils.Timer;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.HabboCatalogUtils;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ExtraInfoPromoItem extends UpdateableExtraInfoListItem 
    {

        private static const _SafeStr_1526:String = "catalog.bundlewidget.discount.promo";

        private var _window:IWindowContainer = null;
        private var _SafeStr_1520:Boolean = true;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1527:Map;
        private var _SafeStr_1528:int = 0;
        private var _SafeStr_1324:BundlePurchaseExtraInfoWidget;
        private var _SafeStr_1529:Number = 0;
        private var _SafeStr_1525:Timer;

        public function ExtraInfoPromoItem(_arg_1:BundlePurchaseExtraInfoWidget, _arg_2:int, _arg_3:ExtraInfoItemData, _arg_4:HabboCatalog)
        {
            super(null, _arg_2, _arg_3, 0);
            _SafeStr_1324 = _arg_1;
            _catalog = _arg_4;
            createNextDiscountMap();
            resolveNextDiscountLevel();
            _SafeStr_1525 = new Timer(50);
            _SafeStr_1525.addEventListener("timer", onEffectTimer);
            _SafeStr_1525.start();
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _SafeStr_1525.stop();
                _SafeStr_1525.removeEventListener("timer", onEffectTimer);
                _SafeStr_1525 = null;
                _SafeStr_1527 = null;
                _catalog = null;
                super.dispose();
            };
        }

        override public function update(_arg_1:ExtraInfoItemData):void
        {
            super.update(_arg_1);
            var _local_2:int = _SafeStr_1528;
            resolveNextDiscountLevel();
            if (_SafeStr_1528 != _local_2)
            {
                _SafeStr_1529 = 1;
            };
            _SafeStr_1520 = true;
            render();
        }

        override public function getRenderedWindow():IWindowContainer
        {
            if (_window == null)
            {
                createWindow();
            };
            if (_SafeStr_1520)
            {
                render();
            };
            return (_window);
        }

        private function createWindow():void
        {
            _window = IWindowContainer(_catalog.utils.createWindow("discountPromoItem"));
            _window.procedure = windowProcedure;
            var _local_1:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("icon_bitmap"));
            HabboCatalogUtils.replaceCenteredImage(_local_1, BitmapData(_catalog.assets.getAssetByName("thumb_up").content).clone());
        }

        private function render():void
        {
            _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo", "quantity", _SafeStr_1528.toString());
            _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo", "discount", _SafeStr_1527.getValue(_SafeStr_1528));
            var _local_1:String = _catalog.localization.getLocalizationRaw("catalog.bundlewidget.discount.promo").value;
            _window.findChildByName("promo_text").caption = _local_1;
            _window.findChildByName("promo_text_effect").caption = _local_1;
            _SafeStr_1520 = false;
        }

        private function resolveNextDiscountLevel():void
        {
            var _local_2:int;
            var _local_1:Array = _SafeStr_1527.getKeys();
            _local_2 = 0;
            while (_local_2 < _local_1.length)
            {
                if (_local_1[_local_2] > data.quantity)
                {
                    _SafeStr_1528 = _local_1[_local_2];
                    return;
                };
                _local_2++;
            };
        }

        private function createNextDiscountMap():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_1:int;
            _SafeStr_1527 = new Map();
            _local_2 = 1;
            _local_3 = 0;
            while (_local_2 <= 100)
            {
                _local_4 = _catalog.utils.calculateBundlePrice(true, 1, _local_2);
                _local_1 = (_local_2 - _local_4);
                if (((_local_1 > _local_3) && (_catalog.utils.bundleDiscountFlatPriceSteps.indexOf(_local_2) == -1)))
                {
                    _SafeStr_1527.add(_local_2, _local_1);
                    _local_3 = _local_1;
                };
                _local_2++;
            };
        }

        private function onEffectTimer(_arg_1:TimerEvent):void
        {
            if (_SafeStr_1529 > 0)
            {
                _SafeStr_1529 = (_SafeStr_1529 - 0.1);
                if (_SafeStr_1529 < 0)
                {
                    _SafeStr_1529 = 0;
                };
                _window.findChildByName("promo_text_effect").blend = _SafeStr_1529;
            };
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_2.name == "click_region")
            {
                switch (_arg_1.type)
                {
                    case "WME_CLICK":
                        _SafeStr_1324.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED", data, id));
                        return;
                    case "WME_OVER":
                        ITextWindow(_window.findChildByName("promo_text")).textColor = 12582911;
                        return;
                    case "WME_OUT":
                        ITextWindow(_window.findChildByName("promo_text")).textColor = 0xFFFFFF;
                        return;
                };
            };
        }


    }
}


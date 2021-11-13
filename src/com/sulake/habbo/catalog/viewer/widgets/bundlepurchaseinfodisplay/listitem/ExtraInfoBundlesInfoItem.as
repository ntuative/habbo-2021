package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ExtraInfoBundlesInfoItem extends ExtraInfoListItem 
    {

        private var _catalog:HabboCatalog;
        private var _window:IWindowContainer;
        private var _SafeStr_1324:BundlePurchaseExtraInfoWidget;

        public function ExtraInfoBundlesInfoItem(_arg_1:BundlePurchaseExtraInfoWidget, _arg_2:int, _arg_3:ExtraInfoItemData, _arg_4:HabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3, 2, true);
            _catalog = _arg_4;
            _SafeStr_1324 = _arg_1;
        }

        override public function getRenderedWindow():IWindowContainer
        {
            if (_window == null)
            {
                createWindow();
            };
            return (_window);
        }

        private function createWindow():void
        {
            _window = IWindowContainer(_catalog.utils.createWindow("bundlesInfoItem"));
            _window.procedure = windowProcedure;
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_1324.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED", data, id));
            };
        }


    }
}


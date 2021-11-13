package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class SimplePriceCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _catalog:HabboCatalog;
        private var _SafeStr_1590:IWindow;

        public function SimplePriceCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            return (true);
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            _SafeStr_1590 = _catalog.utils.showPriceOnProduct(_arg_1.offer, (_window as IWindowContainer), _SafeStr_1590, _window.findChildByName("fake_productimage"), 0, true, 0);
        }


    }
}


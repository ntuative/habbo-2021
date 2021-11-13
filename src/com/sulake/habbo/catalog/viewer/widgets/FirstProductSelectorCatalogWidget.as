package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;

    public class FirstProductSelectorCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function FirstProductSelectorCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
            return (true);
        }

        private function onWidgetsInitialized(_arg_1:CatalogWidgetEvent):void
        {
            if (page.offers.length == 0)
            {
                return;
            };
            var _local_2:IPurchasableOffer = page.offers[0];
            events.dispatchEvent(new SelectProductEvent(_local_2));
        }


    }
}
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.navigation.ICatalogNode;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class SoldLtdItemsCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _catalog:HabboCatalog;

        public function SoldLtdItemsCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                events.removeEventListener("SELECT_PRODUCT", onPreviewProduct);
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("soldLtdItemsWidget");
            window.visible = false;
            events.addEventListener("SELECT_PRODUCT", onPreviewProduct);
            return (true);
        }

        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            var _local_3:Vector.<ICatalogNode> = undefined;
            if ((((_arg_1 == null) || (_arg_1.offer == null)) || (_arg_1.offer.product == null)))
            {
                return;
            };
            if (page.mode == 1)
            {
                _local_3 = _catalog.currentCatalogNavigator.getNodesByOfferId(_arg_1.offer.offerId);
                if (!_local_3)
                {
                    _local_3 = new Vector.<ICatalogNode>(0);
                };
                for each (var _local_2:ICatalogNode in _local_3)
                {
                    if (_local_2.pageName.indexOf("limited_sold") > -1)
                    {
                        window.visible = true;
                        events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget", false));
                        return;
                    };
                };
            };
            if (page.layoutCode == "sold_ltd_items")
            {
                window.visible = true;
                events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget", false));
                return;
            };
            if (((_arg_1.offer.product.isUniqueLimitedItem) && (_arg_1.offer.product.uniqueLimitedItemsLeft == 0)))
            {
                window.visible = true;
                events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget", false));
            }
            else
            {
                window.visible = false;
                events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget", true));
            };
        }


    }
}
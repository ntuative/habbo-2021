package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.events.WindowEvent;

    public class BuilderLoyaltyCatalogWidget extends CatalogWidget implements ICatalogWidget, IDisposable 
    {

        private var _catalog:HabboCatalog;

        public function BuilderLoyaltyCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function init():Boolean
        {
            var _local_3:IWindowContainer;
            if (!super.init())
            {
                return (false);
            };
            _window.procedure = windowProcedure;
            var _local_4:IItemListWindow = (_window.findChildByName("loyalty_list") as IItemListWindow);
            var _local_2:IWindow = _local_4.removeListItemAt(0);
            var _local_5:int;
            for each (var _local_1:IPurchasableOffer in page.offers)
            {
                _local_3 = (_local_2.clone() as IWindowContainer);
                _local_3.findChildByName("item_header").caption = _local_1.localizationName;
                _catalog.utils.showPriceInContainer((_local_3.findChildByName("item_cost_box") as IWindowContainer), _local_1);
                _local_3.findChildByName("item_buy").id = _local_5;
                _local_5++;
                _local_4.addListItem(_local_3);
            };
            return (true);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_arg_2.name == "item_buy")
            {
                _catalog.showPurchaseConfirmation(page.offers[_arg_2.id], page.pageId);
            };
        }


    }
}
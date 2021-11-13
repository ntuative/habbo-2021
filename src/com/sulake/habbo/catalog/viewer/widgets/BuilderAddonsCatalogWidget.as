package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.events.WindowEvent;

    public class BuilderAddonsCatalogWidget extends CatalogWidget implements ICatalogWidget, IDisposable 
    {

        private var _catalog:HabboCatalog;

        public function BuilderAddonsCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
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
            var _local_5:IItemListWindow = (_window.findChildByName("addons_list") as IItemListWindow);
            var _local_2:IWindow = _local_5.removeListItemAt(0);
            var _local_6:int;
            var _local_4:Boolean = (_catalog.builderSecondsLeft > 0);
            _window.findChildByName("trial_warning").visible = (!(_local_4));
            for each (var _local_1:IPurchasableOffer in page.offers)
            {
                _local_3 = (_local_2.clone() as IWindowContainer);
                _local_3.findChildByName("item_header").caption = _local_1.localizationName;
                _local_3.findChildByName("item_price").caption = _local_1.priceInCredits.toString();
                _local_3.findChildByName("item_buy").id = _local_6;
                if (_local_1.priceInActivityPoints > 0)
                {
                    _local_3.findChildByName("diamonds_icon").visible = true;
                    _local_3.findChildByName("diamonds_price").visible = true;
                    _local_3.findChildByName("diamonds_price").caption = _local_1.priceInActivityPoints.toString();
                };
                if (!_local_4)
                {
                    _SafeStr_101(_local_3.findChildByName("item_buy")).disable();
                };
                _local_6++;
                _local_5.addListItem(_local_3);
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


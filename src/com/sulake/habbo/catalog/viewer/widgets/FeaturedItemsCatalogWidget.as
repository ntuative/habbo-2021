package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.catalog.FrontPageItem;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class FeaturedItemsCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _catalog:HabboCatalog;
        private var _SafeStr_1564:IItemListWindow;
        private var _SafeStr_1565:IWindowContainer;

        public function FeaturedItemsCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _catalog = null;
                _SafeStr_1564.dispose();
                _SafeStr_1564 = null;
                _SafeStr_1565.dispose();
                _SafeStr_1565 = null;
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            var _local_2:int;
            if (!super.init())
            {
                return (false);
            };
            _SafeStr_1564 = (window.findChildByName("itemlist_featured") as IItemListWindow);
            _SafeStr_1565 = (_SafeStr_1564.getListItemByName("featured_item_template") as IWindowContainer);
            _SafeStr_1564.removeListItems();
            if (((_catalog.frontPageItems == null) || (_catalog.frontPageItems.length == 0)))
            {
                return (true);
            };
            var _local_1:IWindowContainer = (_window.findChildByName("firstitem") as IWindowContainer);
            populateItem(_catalog.frontPageItems[0], _local_1);
            _local_2 = 1;
            while (_local_2 < Math.min(4, _catalog.frontPageItems.length))
            {
                _SafeStr_1564.addListItem(createItemFromTemplate(_catalog.frontPageItems[_local_2]));
                _local_2++;
            };
            return (true);
        }

        private function createItemFromTemplate(_arg_1:FrontPageItem):IWindowContainer
        {
            return (populateItem(_arg_1, (_SafeStr_1565.clone() as IWindowContainer)));
        }

        private function populateItem(_arg_1:FrontPageItem, _arg_2:IWindowContainer):IWindowContainer
        {
            var _local_3:String;
            var _local_4:IStaticBitmapWrapperWindow;
            var _local_5:ITextWindow = (_arg_2.findChildByName("item_title") as ITextWindow);
            _local_5.text = _arg_1.itemName;
            if (((!(_arg_1.itemPromoImage == null)) && (!(_arg_1.itemPromoImage == ""))))
            {
                _local_3 = _catalog.context.configuration.getProperty("image.library.url");
                _local_4 = (_arg_2.findChildByName("item_image") as IStaticBitmapWrapperWindow);
                _local_4.assetUri = (_local_3 + _arg_1.itemPromoImage);
            };
            var _local_6:IWindow = _arg_2.getChildByName("event_catcher_region");
            if (_local_6 != null)
            {
                _local_6.procedure = eventProc;
            };
            return (_arg_2);
        }

        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_3:FrontPageItem;
            if (_arg_1.type == "WME_DOWN")
            {
                _local_4 = _SafeStr_1564.getListItemIndex(_arg_2.parent);
                _local_4 = ((_local_4 < 0) ? 0 : (_local_4 + 1));
                _local_3 = _catalog.frontPageItems[_local_4];
                switch (_local_3.type)
                {
                    case 0:
                        if (_local_3.cataloguePageLocation == "room_bundles_mobile")
                        {
                            return (_catalog.openCatalogPage("room_bundles", "NORMAL"));
                        };
                        if (_local_3.cataloguePageLocation == "mobile_subscriptions")
                        {
                            return (_catalog.openCatalogPage("hc_membership", "NORMAL"));
                        };
                        _catalog.openCatalogPage(_local_3.cataloguePageLocation, "NORMAL");
                        return;
                    case 1:
                        _catalog.openCatalogPageByOfferId(_local_3.productOfferID, "NORMAL");
                    default:
                };
            };
        }


    }
}


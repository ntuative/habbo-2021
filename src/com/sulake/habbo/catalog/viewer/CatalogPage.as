package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.catalog.viewer.widgets.ICatalogWidget;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.AddOnBadgeViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RoomAdsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.VipBuyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.LoyaltyVipBuyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BuyGuildWidget;
    import com.sulake.habbo.catalog.viewer.widgets.GuildBadgeViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.GuildForumSelectorCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PetPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpinnerCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TotalPriceWidget;
    import com.sulake.habbo.catalog.viewer.widgets.UniqueLimitedItemWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SoldLtdItemsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.UserBadgeSelectorCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SimplePriceCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BuilderCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BuilderSubscriptionCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BuilderAddonsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BuilderLoyaltyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.WarningCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.FirstProductSelectorCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.FeaturedItemsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
    import flash.events.Event;
    import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;

    public class CatalogPage implements ICatalogPage 
    {

        protected static const LAYOUT_MAGIC_PREFIX:String = "layout_";
        public static const MODE_NORMAL:int = 0;
        public static const MODE_SEARCH:int = 1;

        protected var _layout:XML;
        protected var _window:IWindowContainer;
        private var _viewer:ICatalogViewer;
        private var _SafeStr_1425:int;
        private var _layoutCode:String;
        private var _offers:Vector.<IPurchasableOffer>;
        private var _localization:IPageLocalization;
        private var _SafeStr_1647:Array = [];
        private var _widgetEvents:EventDispatcherWrapper;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1648:int;
        private var _SafeStr_1649:ItemGridCatalogWidget;
        private var _acceptSeasonCurrencyAsCredits:Boolean;
        private var _mode:int;

        public function CatalogPage(_arg_1:ICatalogViewer, _arg_2:int, _arg_3:String, _arg_4:IPageLocalization, _arg_5:Vector.<IPurchasableOffer>, _arg_6:HabboCatalog, _arg_7:Boolean, _arg_8:int=-1)
        {
            _viewer = _arg_1;
            _SafeStr_1425 = _arg_2;
            _layoutCode = _arg_3;
            _localization = _arg_4;
            _offers = _arg_5;
            _catalog = _arg_6;
            for each (var _local_9:IPurchasableOffer in _arg_5)
            {
                _local_9.page = this;
            };
            _widgetEvents = new EventDispatcherWrapper();
            _SafeStr_1647 = [];
            _acceptSeasonCurrencyAsCredits = _arg_7;
            if (_arg_8 == -1)
            {
                _mode = 0;
            }
            else
            {
                _mode = _arg_8;
            };
            init();
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function get viewer():ICatalogViewer
        {
            return (_viewer);
        }

        public function get pageId():int
        {
            return ((_mode == 1) ? -12345678 : _SafeStr_1425);
        }

        public function get layoutCode():String
        {
            return (_layoutCode);
        }

        public function get offers():Vector.<IPurchasableOffer>
        {
            return (_offers);
        }

        public function get localization():IPageLocalization
        {
            return (_localization);
        }

        public function get links():Array
        {
            return (_localization.getLinks(_layoutCode));
        }

        public function get hasLinks():Boolean
        {
            return (_localization.hasLinks(_layoutCode));
        }

        public function get acceptSeasonCurrencyAsCredits():Boolean
        {
            return (_acceptSeasonCurrencyAsCredits);
        }

        public function get allowDragging():Boolean
        {
            return (!(_layoutCode == "sold_ltd_items"));
        }

        public function set searchPageId(_arg_1:int):void
        {
            _SafeStr_1648 = _arg_1;
        }

        public function get mode():int
        {
            return (_mode);
        }

        public function get isBuilderPage():Boolean
        {
            return (_catalog.catalogType == "BUILDERS_CLUB");
        }

        public function selectOffer(_arg_1:int):void
        {
            var _local_3:IGridItem;
            var _local_4:ITextFieldWindow;
            if (((!(_SafeStr_1649 == null)) && (_arg_1 > -1)))
            {
                Logger.log(("selecting offer " + _arg_1));
                for each (var _local_2:IPurchasableOffer in _offers)
                {
                    if (_local_2.offerId == _arg_1)
                    {
                        _local_3 = _local_2.gridItem;
                        _SafeStr_1649.select(_local_3, true);
                    };
                };
            };
            if (((_window) && (!(_window.findChildByName("trophyWidget") == null))))
            {
                _local_4 = (_window.findChildByName("input_text") as ITextFieldWindow);
                _local_4.focus();
                _local_4.activate();
            };
        }

        public function dispose():void
        {
            for each (var _local_2:ICatalogWidget in _SafeStr_1647)
            {
                _local_2.dispose();
            };
            _SafeStr_1647 = null;
            _localization.dispose();
            for each (var _local_1:IPurchasableOffer in _offers)
            {
                _local_1.dispose();
            };
            _offers = new Vector.<IPurchasableOffer>(0);
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (_widgetEvents != null)
            {
                _widgetEvents.dispose();
                _widgetEvents = null;
            };
            _viewer = null;
            _layout = null;
            _SafeStr_1425 = 0;
            _layoutCode = "";
            _acceptSeasonCurrencyAsCredits = false;
        }

        public function init():void
        {
            if (createWindow(layoutCode))
            {
                createWidgets();
            };
        }

        public function closed():void
        {
            if (_SafeStr_1647 != null)
            {
                for each (var _local_1:ICatalogWidget in _SafeStr_1647)
                {
                    _local_1.closed();
                };
            };
        }

        protected function createWindow(_arg_1:String):Boolean
        {
            if (_arg_1 == "frontpage4")
            {
                _arg_1 = "frontpage_featured";
            };
            var _local_2:String = ("layout_" + _arg_1);
            if (_viewer.viewerTags.indexOf("UBUNTU") > -1)
            {
                if (!viewer.catalog.assets.hasAsset(_local_2))
                {
                    _local_2 = ("old_" + _local_2);
                };
            }
            else
            {
                _local_2 = ("old_" + _local_2);
            };
            var _local_3:XmlAsset = (viewer.catalog.assets.getAssetByName(_local_2) as XmlAsset);
            if (_local_3 == null)
            {
                Logger.log(("Could not find asset for layout " + _local_2));
                return (false);
            };
            _layout = (_local_3.content as XML);
            _window = (viewer.catalog.windowManager.buildFromXML(_layout) as IWindowContainer);
            if (_window == null)
            {
                Logger.log(("Could not create layout " + _arg_1));
                return (false);
            };
            return (true);
        }

        private function localize():void
        {
        }

        private function createWidgets():void
        {
            createWidgetsRecursion(_window);
            initializeWidgets();
        }

        private function createWidgetsRecursion(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            var _local_3:IWindowContainer;
            if (_arg_1 != null)
            {
                _local_2 = 0;
                while (_local_2 < _arg_1.numChildren)
                {
                    _local_3 = (_arg_1.getChildAt(_local_2) as IWindowContainer);
                    if (_local_3 != null)
                    {
                        createWidget(_local_3);
                        createWidgetsRecursion(_local_3);
                    };
                    _local_2++;
                };
            };
        }

        private function createWidget(_arg_1:IWindowContainer):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            switch (_arg_1.name)
            {
                case "itemGridWidget":
                    if (_SafeStr_1649 == null)
                    {
                        _SafeStr_1649 = new ItemGridCatalogWidget(_arg_1, _catalog.sessionDataManager, _catalog.catalogType);
                        _SafeStr_1647.push(_SafeStr_1649);
                    };
                    return;
                case "productViewWidget":
                    _SafeStr_1647.push(new ProductViewCatalogWidget(_arg_1, _catalog));
                    return;
                case "songDiskProductViewWidget":
                    _SafeStr_1647.push(new SongDiskProductViewCatalogWidget(_arg_1, _catalog));
                    return;
                case "singleViewWidget":
                    _SafeStr_1647.push(new SingleViewCatalogWidget(_arg_1, _catalog));
                    return;
                case "purchaseWidget":
                    _SafeStr_1647.push(new PurchaseCatalogWidget(_arg_1, _catalog));
                    return;
                case "colourGridWidget":
                    _SafeStr_1647.push(new ColourGridCatalogWidget(_arg_1));
                    return;
                case "traxPreviewWidget":
                    _SafeStr_1647.push(new TraxPreviewCatalogWidget(_arg_1, _catalog.soundManager));
                    return;
                case "redeemItemCodeWidget":
                    _SafeStr_1647.push(new RedeemItemCodeCatalogWidget(_arg_1));
                    return;
                case "spacesNewWidget":
                    _SafeStr_1647.push(new SpacesNewCatalogWidget(_arg_1, _catalog.sessionDataManager, _catalog.catalogType));
                    return;
                case "roomPreviewWidget":
                    _SafeStr_1647.push(new RoomPreviewCatalogWidget(_arg_1));
                    return;
                case "trophyWidget":
                    _SafeStr_1647.push(new TrophyCatalogWidget(_arg_1, _catalog));
                    return;
                case "addOnBadgeViewWidget":
                    _SafeStr_1647.push(new AddOnBadgeViewCatalogWidget(_arg_1));
                    return;
                case "petsWidget":
                    _SafeStr_1647.push(new PetsCatalogWidget(_arg_1, _catalog));
                    return;
                case "newPetsWidget":
                    _SafeStr_1647.push(new NewPetsCatalogWidget(_arg_1, _catalog));
                    return;
                case "roomAdsCatalogWidget":
                    _SafeStr_1647.push(new RoomAdsCatalogWidget(_arg_1, _catalog));
                    return;
                case "textInputWidget":
                    _SafeStr_1647.push(new TextInputCatalogWidget(_arg_1));
                    return;
                case "specialInfoWidget":
                    _SafeStr_1647.push(new SpecialInfoWidget(_arg_1));
                    return;
                case "marketPlaceWidget":
                    _SafeStr_1647.push(new MarketPlaceCatalogWidget(_arg_1));
                    return;
                case "marketPlaceOwnItemsWidget":
                    _SafeStr_1647.push(new MarketPlaceOwnItemsCatalogWidget(_arg_1));
                    return;
                case "clubGiftWidget":
                    _SafeStr_1647.push(new ClubGiftWidget(_arg_1, _catalog.getClubGiftController(), _catalog));
                    return;
                case "clubBuyWidget":
                    _SafeStr_1647.push(new ClubBuyCatalogWidget(_arg_1));
                    return;
                case "vipBuyWidget":
                    _SafeStr_1647.push(new VipBuyCatalogWidget(_arg_1, _catalog));
                    return;
                case "loyaltyVipBuyWidget":
                    _SafeStr_1647.push(new LoyaltyVipBuyCatalogWidget(_arg_1, _catalog));
                    return;
                case "vipGiftWidget":
                    _SafeStr_1647.push(new VipBuyCatalogWidget(_arg_1, _catalog, true));
                    return;
                case "activityPointDisplayWidget":
                    _SafeStr_1647.push(new ActivityPointDisplayCatalogWidget(_arg_1));
                    return;
                case "madMoneyWidget":
                    _SafeStr_1647.push(new MadMoneyCatalogWidget(_arg_1));
                    return;
                case "buyGuildWidget":
                    _SafeStr_1647.push(new BuyGuildWidget(_arg_1));
                    return;
                case "guildBadgeViewWidget":
                    _SafeStr_1647.push(new GuildBadgeViewCatalogWidget(_arg_1, _catalog.getGroupMembershipsController()));
                    return;
                case "guildSelectorWidget":
                    _SafeStr_1647.push(new GuildSelectorCatalogWidget(_arg_1, _catalog.getGroupMembershipsController()));
                    return;
                case "guildForumSelectorWidget":
                    _SafeStr_1647.push(new GuildForumSelectorCatalogWidget(_arg_1, _catalog.getGroupMembershipsController()));
                    return;
                case "petPreviewWidget":
                    _SafeStr_1647.push(new PetPreviewCatalogWidget(_arg_1, _catalog));
                    return;
                case "spinnerWidget":
                    _SafeStr_1647.push(new SpinnerCatalogWidget(_arg_1, _catalog));
                    return;
                case "bundlePurchaseExtraInfoWidget":
                    _SafeStr_1647.push(new BundlePurchaseExtraInfoWidget(_arg_1, _catalog));
                    return;
                case "totalPriceWidget":
                    _SafeStr_1647.push(new TotalPriceWidget(_arg_1, _catalog));
                    return;
                case "limitedItemWidget":
                    _SafeStr_1647.push(new UniqueLimitedItemWidget(_arg_1, _catalog));
                    return;
                case "soldLtdItemsWidget":
                    _SafeStr_1647.push(new SoldLtdItemsCatalogWidget(_arg_1, _catalog));
                    return;
                case "userBadgeSelectorWidget":
                    _SafeStr_1647.push(new UserBadgeSelectorCatalogWidget(_arg_1, _catalog));
                    return;
                case "bundleGridScrollWidget":
                    _SafeStr_1647.push(new BundleGridViewCatalogWidget(_arg_1));
                    return;
                case "simplePriceWidget":
                    _SafeStr_1647.push(new SimplePriceCatalogWidget(_arg_1, _catalog));
                    return;
                case "builderWidget":
                    _SafeStr_1647.push(new BuilderCatalogWidget(_arg_1, _catalog));
                    return;
                case "builderSubscriptionWidget":
                    _SafeStr_1647.push(new BuilderSubscriptionCatalogWidget(_arg_1, _catalog));
                    return;
                case "builderAddonsWidget":
                    _SafeStr_1647.push(new BuilderAddonsCatalogWidget(_arg_1, _catalog));
                    return;
                case "builderLoyaltyWidget":
                    _SafeStr_1647.push(new BuilderLoyaltyCatalogWidget(_arg_1, _catalog));
                    return;
                case "warningWidget":
                    _SafeStr_1647.push(new WarningCatalogWidget(_arg_1));
                    return;
                case "firstProductAutoSelectorWidget":
                    _SafeStr_1647.push(new FirstProductSelectorCatalogWidget(_arg_1));
                    return;
                case "featuredItemsWidget":
                    _SafeStr_1647.push(new FeaturedItemsCatalogWidget(_arg_1, _catalog));
                    return;
            };
        }

        private function initializeWidgets():void
        {
            var _local_3:ICatalogWidget;
            var _local_6:ColourGridCatalogWidget;
            var _local_7:ItemGridCatalogWidget;
            var _local_1:IWindowContainer;
            var _local_4:int;
            var _local_5:IWindowContainer;
            var _local_2:Array = [];
            if (_layoutCode == "default_3x3_color_grouping")
            {
                _local_1 = (_window.findChildByName("itemGridWidget") as IWindowContainer);
                _local_4 = 3;
                _local_1.height = (104 - _local_4);
                _local_5 = (_window.findChildByName("colourGridWidget") as IWindowContainer);
                _local_5.visible = true;
                _local_5.width = 360;
                _local_5.x = _local_1.x;
                _local_5.y = ((_local_1.y + _local_1.height) + _local_4);
                _local_5.height = 51;
                _local_6 = new ColourGridCatalogWidget(_local_5);
                _SafeStr_1647.push(_local_6);
            };
            for each (_local_3 in _SafeStr_1647)
            {
                _local_3.page = this;
                if ((_local_3 is ItemGridCatalogWidget))
                {
                    _local_7 = (_local_3 as ItemGridCatalogWidget);
                };
                _local_3.events = _widgetEvents;
                if (!_local_3.init())
                {
                    _local_2.push(_local_3);
                };
            };
            removeWidgets(_local_2);
            initializeLocalizations();
            _widgetEvents.dispatchEvent(new CatalogWidgetEvent("WIDGETS_INITIALIZED"));
        }

        private function initializeLocalizations():void
        {
            var _local_1:ICatalogWidget = new LocalizationCatalogWidget(_window, _catalog);
            _SafeStr_1647.push(_local_1);
            _local_1.page = this;
            _local_1.events = _widgetEvents;
            _local_1.init();
        }

        private function removeWidgets(_arg_1:Array):void
        {
            var _local_3:ICatalogWidget;
            var _local_2:ICatalogWidget;
            var _local_4:int;
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                return;
            };
            for each (_local_3 in _SafeStr_1647)
            {
                if (_local_3.window != null)
                {
                    for each (_local_2 in _arg_1)
                    {
                        if (_local_2.window != null)
                        {
                            if (_local_2.window.getChildIndex(_local_3.window) >= 0)
                            {
                                if (_arg_1.indexOf(_local_3) < 0)
                                {
                                    _arg_1.push(_local_3);
                                };
                                break;
                            };
                        };
                    };
                };
            };
            for each (_local_2 in _arg_1)
            {
                if (_local_2.window != null)
                {
                    _window.removeChild(_local_2.window);
                    _local_2.window.dispose();
                };
                _local_4 = _SafeStr_1647.indexOf(_local_2);
                if (_local_4 >= 0)
                {
                    _SafeStr_1647.splice(_local_4, 1);
                };
                _local_2.dispose();
            };
        }

        public function dispatchWidgetEvent(_arg_1:Event):Boolean
        {
            if (_widgetEvents != null)
            {
                return (_widgetEvents.dispatchEvent(_arg_1));
            };
            return (false);
        }

        public function replaceOffers(_arg_1:Vector.<IPurchasableOffer>, _arg_2:Boolean=false):void
        {
            if (_arg_2)
            {
                for each (var _local_3:IPurchasableOffer in _offers)
                {
                    _local_3.dispose();
                };
            };
            _offers = _arg_1;
        }

        public function updateLimitedItemsLeft(_arg_1:int, _arg_2:int):void
        {
            for each (var _local_3:IPurchasableOffer in _offers)
            {
                if (_local_3.offerId == _arg_1)
                {
                    _local_3.product.uniqueLimitedItemsLeft = _arg_2;
                    _widgetEvents.dispatchEvent(new ProductOfferUpdatedEvent(_local_3));
                    return;
                };
            };
        }


    }
}


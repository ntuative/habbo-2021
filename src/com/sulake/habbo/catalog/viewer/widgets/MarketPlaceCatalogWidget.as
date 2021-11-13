package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.marketplace.MarketplaceChart;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.TimerEvent;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.geom.Point;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
    import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
    import flash.geom.Matrix;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class MarketPlaceCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IMarketPlaceVisualization 
    {

        private const STATUS_SEARCHING:int = 1;
        private const STATUS_LIST_AVAILABLE:int = 2;
        private const MAX_SEARCH_STRING_LENGTH:int = 40;
        private const MAX_PRICE_STRING_LENGTH:int = 10;

        private var _SafeStr_1577:Array = [];
        private var _SafeStr_1578:MarketPlaceOfferData;
        private var _itemList:IItemListWindow;
        private var _SafeStr_1579:IWindowContainer;
        private var _SafeStr_1580:Timer;
        private var _offers:Map;
        private var _SafeStr_1581:int;

        public function MarketPlaceCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_1578 = null;
            _offers = null;
            _itemList = null;
            if (_SafeStr_1579)
            {
                _SafeStr_1579.dispose();
                _SafeStr_1579 = null;
            };
            if (_SafeStr_1580)
            {
                _SafeStr_1580.removeEventListener("timer", onPopulationTimer);
                _SafeStr_1580 = null;
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (marketPlace == null)
            {
                return (false);
            };
            marketPlace.registerVisualization(this);
            displayMainView();
            var _local_1:IItemListWindow = (_window.findChildByName("offer_list") as IItemListWindow);
            _SafeStr_1579 = (_local_1.removeListItem(_local_1.getListItemByName("offer_item")) as IWindowContainer);
            return (true);
        }

        public function listUpdatedNotify():void
        {
            hideDetails();
            updateList();
        }

        public function updateStats():void
        {
            var _local_9:MarketplaceChart;
            var _local_3:BitmapData;
            var _local_10:String;
            if ((((!(marketPlace)) || (!(marketPlace.localization))) || (!(_window))))
            {
                return;
            };
            var _local_2:MarketplaceItemStats = marketPlace.itemStats;
            if (!_local_2)
            {
                return;
            };
            var _local_5:IWindowContainer = (_window.findChildByName("details_container") as IWindowContainer);
            if (((!(_local_5)) || (!(_local_5.visible))))
            {
                return;
            };
            var _local_4:IWindow = _local_5.findChildByName("offer_count");
            if (_local_4)
            {
                marketPlace.localization.registerParameter("catalog.marketplace.offer_details.offer_count", "count", _local_2.offerCount.toString());
                _local_4.visible = true;
            };
            var _local_6:ISelectorWindow = (_local_5.findChildByName("chart_selector") as ISelectorWindow);
            if (!_local_6)
            {
                return;
            };
            var _local_1:ISelectableWindow = _local_6.getSelected();
            if (!_local_1)
            {
                return;
            };
            switch (_local_1.name)
            {
                case "price_development":
                    _local_9 = new MarketplaceChart(_local_2.dayOffsets, _local_2.averagePrices);
                    break;
                case "trade_volume":
                    _local_9 = new MarketplaceChart(_local_2.dayOffsets, _local_2.soldAmounts);
                    break;
                default:
                    return;
            };
            if (!_local_9)
            {
                return;
            };
            var _local_7:IBitmapWrapperWindow = (_local_5.findChildByName("chart_bitmap") as IBitmapWrapperWindow);
            if (_local_7)
            {
                _local_7.bitmap = null;
                _local_7.bitmap = new BitmapData(_local_7.width, _local_7.height);
                _local_3 = _local_9.draw(_local_7.width, _local_7.height);
                _local_7.bitmap.draw(_local_3);
                _local_3.dispose();
            };
            var _local_8:IWindow = _local_5.findChildByName("chart_title");
            if (_local_8)
            {
                if (_local_9.available)
                {
                    _local_10 = ("catalog.marketplace.offer_details.chart_title." + _local_1.name);
                    marketPlace.localization.registerParameter(_local_10, "days", _local_2.historyLength.toString());
                }
                else
                {
                    _local_10 = "catalog.marketplace.offer_details.chart_title.not_available";
                };
                _local_8.caption = marketPlace.localization.getLocalization(_local_10);
            };
        }

        private function get marketPlace():IMarketPlace
        {
            if ((((page) && (page.viewer)) && (page.viewer.catalog)))
            {
                return (page.viewer.catalog.getMarketPlace());
            };
            return (null);
        }

        public function displayMainView():void
        {
            attachWidgetView("marketPlaceWidget");
            window.procedure = onWidgetEvent;
            _itemList = (window.findChildByName("offer_list") as IItemListWindow);
            selectSearchCategory("search_by_activity");
        }

        private function selectSearchCategory(_arg_1:String):void
        {
            var _local_5:String;
            var _local_4:ISelectorWindow = (_window.findChildByName("search_selector") as ISelectorWindow);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:ISelectableWindow = _local_4.getSelectableByName(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            _local_4.setSelected(_local_2);
            var _local_3:IWindowContainer = (_window.findChildByName("search_container") as IWindowContainer);
            if (_local_3 == null)
            {
                return;
            };
            while (_local_3.numChildren > 0)
            {
                _local_3.removeChildAt(0);
            };
            switch (_arg_1)
            {
                case "search_by_value":
                    _local_5 = "marketplace_search_simple";
                    _SafeStr_1577 = [1, 2];
                    break;
                case "search_by_activity":
                    _local_5 = "marketplace_search_simple";
                    _SafeStr_1577 = [3, 4, 5, 6];
                    break;
                case "search_advanced":
                    _local_5 = "marketplace_search_advanced";
                    _SafeStr_1577 = [1, 2, 3, 4, 5, 6];
                    break;
                default:
                    return;
            };
            var _local_7:IWindowContainer = (createWindow(_local_5) as IWindowContainer);
            _local_3.addChild(_local_7);
            var _local_6:IDropMenuWindow = (_window.findChildByName("sort_dropmenu") as IDropMenuWindow);
            if (_local_6 != null)
            {
                _local_6.populate(getSortKeys(_SafeStr_1577));
                _local_6.selection = 0;
            };
        }

        private function getSortKeys(_arg_1:Array):Array
        {
            var _local_2:Array = [];
            for each (var _local_3:int in _arg_1)
            {
                _local_2.push((("${catalog.marketplace.sort." + _local_3) + "}"));
            };
            return (_local_2);
        }

        private function createWindow(_arg_1:String):IWindow
        {
            if ((((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))) || (!(page.viewer.catalog.assets))) || (!(page.viewer.catalog.windowManager))))
            {
                return (null);
            };
            var _local_3:XmlAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_3)) || (!(_local_3.content))))
            {
                return (null);
            };
            var _local_2:XML = (_local_3.content as XML);
            if (!_local_2)
            {
                return (null);
            };
            return (page.viewer.catalog.windowManager.buildFromXML(_local_2));
        }

        private function updateStatusDisplay(_arg_1:int, _arg_2:int=-1, _arg_3:int=-1):void
        {
            var _local_6:String;
            var _local_4:IHabboLocalizationManager = marketPlace.localization;
            if (!_local_4)
            {
                return;
            };
            if (((((!(window)) || (!(page))) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return;
            };
            var _local_5:IWindow = window.findChildByName("status_text");
            if (_local_5 == null)
            {
                return;
            };
            if (_arg_1 == 1)
            {
                _local_6 = _local_4.getLocalization("catalog.marketplace.searching");
            }
            else
            {
                if (_arg_3 > 0)
                {
                    _local_6 = _local_4.getLocalization("catalog.marketplace.items_found");
                    _local_6 = _local_6.replace("%count%", _arg_3);
                    if (((_arg_2 > 0) && (_arg_2 < _arg_3)))
                    {
                        _local_6 = (_local_6 + ((". " + _local_4.getLocalization("catalog.marketplace.items_shown")) + "."));
                        _local_6 = _local_6.replace("%count%", _arg_2);
                    };
                }
                else
                {
                    _local_6 = _local_4.getLocalization("catalog.marketplace.no_items");
                };
            };
            _local_5.caption = _local_6;
        }

        private function updateList():void
        {
            if (((!(marketPlace)) || (!(window))))
            {
                return;
            };
            var _local_1:Map = marketPlace.latestOffers();
            if (!_local_1)
            {
                return;
            };
            var _local_3:int = marketPlace.totalItemsFound();
            _offers = _local_1;
            if (!_itemList)
            {
                return;
            };
            _itemList.destroyListItems();
            if (!_SafeStr_1579)
            {
                return;
            };
            var _local_2:Array = _local_1.getKeys();
            if (_local_2 == null)
            {
                return;
            };
            updateStatusDisplay(2, _local_2.length, _local_3);
            if (!_SafeStr_1580)
            {
                _SafeStr_1580 = new Timer(25);
                _SafeStr_1580.addEventListener("timer", onPopulationTimer);
            };
            _SafeStr_1581 = 0;
            populateList();
            _SafeStr_1580.start();
        }

        private function onPopulationTimer(_arg_1:TimerEvent):void
        {
            if (!_SafeStr_1580)
            {
                return;
            };
            if (populateList())
            {
                _SafeStr_1580.stop();
            };
        }

        private function populateList():Boolean
        {
            var _local_1:int;
            if (!_offers)
            {
                return (true);
            };
            _local_1 = 0;
            while (_local_1 < 5)
            {
                if (_SafeStr_1581 >= _offers.length)
                {
                    return (true);
                };
                addListItem(_offers.getWithIndex(_SafeStr_1581));
                _SafeStr_1581++;
                _local_1++;
            };
            return (false);
        }

        private function addListItem(_arg_1:MarketPlaceOfferData):void
        {
            var _local_17:String;
            var _local_6:String;
            var _local_4:_SafeStr_147;
            var _local_5:IBitmapWrapperWindow;
            var _local_12:Point;
            var _local_13:IWindow;
            var _local_3:IWidgetWindow;
            var _local_10:ILimitedItemGridOverlayWidget;
            var _local_7:IWidgetWindow;
            var _local_2:IRarityItemGridOverlayWidget;
            var _local_8:IWindow;
            if (((((!(_arg_1)) || (!(_itemList))) || (!(_SafeStr_1579))) || (!(marketPlace.localization))))
            {
                return;
            };
            var _local_14:IWindowContainer = (_SafeStr_1579.clone() as IWindowContainer);
            if (((!(_local_14)) || (_local_14.disposed)))
            {
                return;
            };
            var _local_9:IWindow = _local_14.findChildByName("item_name");
            if (_local_9 != null)
            {
                _local_9.caption = (("${" + marketPlace.getNameLocalizationKey(_arg_1)) + "}");
            };
            var _local_15:IWindow = _local_14.findChildByName("item_desc");
            if (_local_15 != null)
            {
                _local_15.caption = (("${" + marketPlace.getDescriptionLocalizationKey(_arg_1)) + "}");
            };
            var _local_16:IWindow = _local_14.findChildByName("item_price");
            if (_local_16 != null)
            {
                _local_17 = marketPlace.localization.getLocalization("catalog.marketplace.offer.price_public_item");
                _local_17 = _local_17.replace("%price%", _arg_1.price);
                _local_17 = _local_17.replace("%average%", ((_arg_1.averagePrice != 0) ? _arg_1.averagePrice.toString() : " - "));
                _local_16.caption = _local_17;
            };
            var _local_11:IWindow = _local_14.findChildByName("offer_count");
            if (_local_11)
            {
                _local_6 = marketPlace.localization.getLocalization("catalog.marketplace.offer_count");
                _local_6 = _local_6.replace("%count%", _arg_1.offerCount);
                _local_11.caption = _local_6;
            };
            if (_arg_1.image == null)
            {
                _local_4 = getFurniImageResult(_arg_1.furniId, _arg_1.furniType, _arg_1.extraData);
                if (((!(_local_4 == null)) && (!(_local_4.data == null))))
                {
                    _arg_1.image = (_local_4.data as BitmapData);
                    _arg_1.imageCallback = _local_4.id;
                };
                _local_14.id = _local_4.id;
            };
            if (_arg_1.image != null)
            {
                _local_5 = (_local_14.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_local_5 != null)
                {
                    _local_12 = new Point(((_local_5.width - _arg_1.image.width) / 2), ((_local_5.height - _arg_1.image.height) / 2));
                    if (_local_5.bitmap == null)
                    {
                        _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
                    };
                    _local_5.bitmap.copyPixels(_arg_1.image, _arg_1.image.rect, _local_12);
                };
            };
            if (_arg_1.isUniqueLimitedItem)
            {
                _local_13 = _local_14.findChildByName("unique_item_background_bitmap");
                _local_3 = IWidgetWindow(_local_14.findChildByName("unique_item_overlay_widget"));
                _local_10 = ILimitedItemGridOverlayWidget(_local_3.widget);
                _local_10.serialNumber = _arg_1.stuffData.uniqueSerialNumber;
                _local_10.animated = true;
                _local_13.visible = true;
                _local_3.visible = true;
            };
            if (((_arg_1.stuffData) && (_arg_1.stuffData.rarityLevel >= 0)))
            {
                _local_7 = IWidgetWindow(_local_14.findChildByName("rarity_item_overlay_widget"));
                _local_2 = IRarityItemGridOverlayWidget(_local_7.widget);
                _local_7.visible = true;
                _local_2.rarityLevel = _arg_1.stuffData.rarityLevel;
            };
            if (marketPlace.isAccountSafetyLocked())
            {
                _local_8 = _local_14.findChildByName("buy_button");
                if (_local_8 != null)
                {
                    _local_8.disable();
                };
            };
            _itemList.addListItem(_local_14);
            _local_14.procedure = onOfferListEvent;
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_5:IWindowContainer;
            var _local_7:IBitmapWrapperWindow;
            var _local_6:Point;
            if ((((((disposed) || (!(marketPlace))) || (!(_arg_2))) || (!(_itemList))) || (!(_offers))))
            {
                return;
            };
            var _local_4:Array = [];
            if (_itemList.groupListItemsWithID(_arg_1, _local_4))
            {
                for each (_local_5 in _local_4)
                {
                    if (_local_5)
                    {
                        _local_7 = (_local_5.findChildByName("item_image") as IBitmapWrapperWindow);
                        if (_local_7 != null)
                        {
                            _local_7.bitmap = new BitmapData(_local_7.width, _local_7.height, true, 0xFFFFFF);
                            _local_6 = new Point(((_local_7.width - _arg_2.width) / 2), ((_local_7.height - _arg_2.height) / 2));
                            _local_7.bitmap.copyPixels(_arg_2, _arg_2.rect, _local_6, null, null, true);
                        };
                        _local_5.id = 0;
                    };
                };
            };
            for each (var _local_3:MarketPlaceOfferData in _offers)
            {
                if (_local_3.imageCallback == _arg_1)
                {
                    _local_3.imageCallback = 0;
                    _local_3.image = _arg_2;
                };
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function getFurniImageResult(_arg_1:int, _arg_2:int, _arg_3:String=null):_SafeStr_147
        {
            if ((((!(page)) || (!(page.viewer))) || (!(page.viewer.roomEngine))))
            {
                return (null);
            };
            if (_arg_2 == 1)
            {
                return (page.viewer.roomEngine.getFurnitureIcon(_arg_1, this));
            };
            if (_arg_2 == 2)
            {
                return (page.viewer.roomEngine.getWallItemIcon(_arg_1, this, _arg_3));
            };
            return (null);
        }

        private function onOfferListEvent(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_5:int;
            var _local_3:Map;
            var _local_4:MarketPlaceOfferData;
            if (_arg_1.type == "WME_CLICK")
            {
                if ((((!(window)) || (!(marketPlace))) || (!(_arg_2))))
                {
                    return;
                };
                if (_itemList == null)
                {
                    return;
                };
                _local_5 = _itemList.getListItemIndex(_arg_1.window.parent);
                _local_3 = marketPlace.latestOffers();
                _local_4 = (_local_3.getWithIndex(_local_5) as MarketPlaceOfferData);
                if (!_local_4)
                {
                    return;
                };
                switch (_arg_2.name)
                {
                    case "buy_button":
                        marketPlace.buyOffer(_local_4.offerId);
                        return;
                    case "more_button":
                        showDetails(_local_4);
                        return;
                };
            };
        }

        private function showDetails(_arg_1:MarketPlaceOfferData):void
        {
            var _local_6:_SafeStr_147;
            var _local_7:IBitmapWrapperWindow;
            var _local_11:ILimitedItemPreviewOverlayWidget;
            var _local_3:IRarityItemGridOverlayWidget;
            var _local_10:IWindow;
            if ((((!(_arg_1)) || (!(_window))) || (!(marketPlace))))
            {
                return;
            };
            _SafeStr_1578 = _arg_1;
            var _local_2:IHabboLocalizationManager = marketPlace.localization;
            if (!_local_2)
            {
                return;
            };
            _window.getChildAt(0).visible = false;
            var _local_12:IWindowContainer = (_window.findChildByName("details_container") as IWindowContainer);
            if (_local_12)
            {
                _local_12.visible = true;
            }
            else
            {
                _local_12 = (createWindow("marketplace_offer_details") as IWindowContainer);
                _window.addChild(_local_12);
                _local_12.procedure = detailsEventHandler;
            };
            var _local_8:IWindow = _local_12.findChildByName("item_name");
            if (_local_8)
            {
                _local_8.caption = (("${" + marketPlace.getNameLocalizationKey(_arg_1)) + "}");
            };
            _local_8 = _local_12.findChildByName("item_description");
            if (_local_8)
            {
                _local_8.caption = (("${" + marketPlace.getDescriptionLocalizationKey(_arg_1)) + "}");
            };
            _local_8 = _local_12.findChildByName("item_count");
            if (_local_8)
            {
                _local_8.visible = false;
            };
            _local_2.registerParameter("catalog.marketplace.offer_details.price", "price", _arg_1.price.toString());
            _local_2.registerParameter("catalog.marketplace.offer_details.average_price", "days", marketPlace.averagePricePeriod.toString());
            var _local_4:String = ((_arg_1.averagePrice == 0) ? " - " : _arg_1.averagePrice.toString());
            _local_2.registerParameter("catalog.marketplace.offer_details.average_price", "average", _local_4);
            if (_arg_1.image == null)
            {
                _local_6 = getFurniImageResult(_arg_1.furniId, _arg_1.furniType, _arg_1.extraData);
                if (((!(_local_6 == null)) && (!(_local_6.data == null))))
                {
                    _arg_1.image = (_local_6.data as BitmapData);
                    _arg_1.imageCallback = _local_6.id;
                };
            };
            if (_arg_1.image != null)
            {
                _local_7 = (_local_12.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_local_7 != null)
                {
                    _local_7.bitmap = null;
                    _local_7.bitmap = new BitmapData(_local_7.width, _local_7.height, true, 0);
                    _local_7.bitmap.draw(_arg_1.image, new Matrix(1, 0, 0, 1, ((_local_7.width - _arg_1.image.width) / 2), ((_local_7.height - _arg_1.image.height) / 2)));
                };
            };
            var _local_13:ISelectorWindow = (_local_12.findChildByName("chart_selector") as ISelectorWindow);
            if (_local_13)
            {
                _local_13.setSelected(_local_13.getSelectableAt(0));
            };
            var _local_14:IBitmapWrapperWindow = (_local_12.findChildByName("chart_bitmap") as IBitmapWrapperWindow);
            if (_local_14)
            {
                _local_14.bitmap = null;
            };
            var _local_5:IWidgetWindow = IWidgetWindow(_local_12.findChildByName("unique_item_overlay_widget"));
            if (_arg_1.isUniqueLimitedItem)
            {
                _local_11 = ILimitedItemPreviewOverlayWidget(_local_5.widget);
                _local_11.serialNumber = _arg_1.stuffData.uniqueSerialNumber;
                _local_11.seriesSize = _arg_1.stuffData.uniqueSeriesSize;
                _local_5.visible = true;
            }
            else
            {
                _local_5.visible = false;
            };
            var _local_9:IWidgetWindow = IWidgetWindow(_local_12.findChildByName("rarity_item_overlay_widget"));
            if (((_arg_1.stuffData) && (_arg_1.stuffData.rarityLevel >= 0)))
            {
                _local_3 = IRarityItemGridOverlayWidget(_local_9.widget);
                _local_9.visible = true;
                _local_3.rarityLevel = _arg_1.stuffData.rarityLevel;
            }
            else
            {
                _local_9.visible = false;
            };
            if (marketPlace.isAccountSafetyLocked())
            {
                _local_10 = _local_12.findChildByName("buy_button");
                if (_local_10 != null)
                {
                    _local_10.disable();
                };
            };
            marketPlace.requestItemStats(_arg_1.furniType, _arg_1.furniId);
        }

        private function hideDetails():void
        {
            if (!_window)
            {
                return;
            };
            _SafeStr_1578 = null;
            var _local_1:IWindow = _window.findChildByName("details_container");
            if (_local_1)
            {
                _local_1.visible = false;
            };
            _window.getChildAt(0).visible = true;
        }

        private function doSearch():void
        {
            var _local_1:IWindow;
            updateStatusDisplay(1);
            var _local_4:int = -1;
            var _local_6:int = -1;
            var _local_2:String = "";
            var _local_3:int = 1;
            _local_1 = _window.findChildByName("min_price_input");
            if (_local_1)
            {
                if (_local_1.caption == "")
                {
                    _local_4 = -1;
                }
                else
                {
                    _local_4 = parseInt(_local_1.caption);
                };
            };
            _local_1 = _window.findChildByName("max_price_input");
            if (_local_1)
            {
                if (_local_1.caption == "")
                {
                    _local_6 = -1;
                }
                else
                {
                    _local_6 = parseInt(_local_1.caption);
                };
            };
            _local_1 = _window.findChildByName("search_input");
            if (_local_1)
            {
                _local_2 = _local_1.caption;
            };
            var _local_5:IDropMenuWindow = (_window.findChildByName("sort_dropmenu") as IDropMenuWindow);
            if ((((_local_5) && (_local_5.selection >= 0)) && (_local_5.selection < _SafeStr_1577.length)))
            {
                _local_3 = _SafeStr_1577[_local_5.selection];
            };
            marketPlace.requestOffers(_local_4, _local_6, _local_2, _local_3);
        }

        private function onWidgetEvent(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_7:ISelectorWindow;
            var _local_6:ISelectableWindow;
            var _local_5:ITextFieldWindow;
            var _local_8:int;
            if ((((!(_arg_1)) || (!(_arg_2))) || (!(marketPlace))))
            {
                return;
            };
            var _local_3:IHabboLocalizationManager = marketPlace.localization;
            var _local_4:IWindow = window.findChildByName("search_input");
            if (_arg_1.type == "WE_SELECTED")
            {
                switch (_arg_2.name)
                {
                    case "sort_dropmenu":
                        _local_7 = (_window.findChildByName("search_selector") as ISelectorWindow);
                        if (!_local_7)
                        {
                            return;
                        };
                        _local_6 = _local_7.getSelected();
                        if (!_local_6)
                        {
                            return;
                        };
                        if (((_local_6.name == "search_by_value") || (_local_6.name == "search_by_activity")))
                        {
                            doSearch();
                        };
                        break;
                    case "search_by_value":
                    case "search_by_activity":
                    case "search_advanced":
                        selectSearchCategory(_arg_2.name);
                };
            }
            else
            {
                if (_arg_1.type == "WME_CLICK")
                {
                    switch (_arg_2.name)
                    {
                        case "search_input":
                            if ((((_local_3) && (_local_4)) && (_local_4.caption == _local_3.getLocalization("catalog.marketplace.search_name"))))
                            {
                                _local_4.caption = "";
                            };
                            break;
                        case "search_button":
                            if ((((_local_3) && (_local_4)) && (_local_4.caption == _local_3.getLocalization("catalog.marketplace.search_name"))))
                            {
                                return;
                            };
                            doSearch();
                    };
                }
                else
                {
                    if (_arg_1.type == "WE_CHANGE")
                    {
                        _local_5 = (_arg_2 as ITextFieldWindow);
                        if (!_local_5)
                        {
                            return;
                        };
                        switch (_local_5.name)
                        {
                            case "min_price_input":
                            case "max_price_input":
                                _local_8 = 10;
                                break;
                            case "search_input":
                                _local_8 = 40;
                                break;
                            default:
                                return;
                        };
                        if (_local_5.text.length > _local_8)
                        {
                            _local_5.text = _local_5.text.substr(0, _local_8);
                        };
                        _local_5.scrollH = 0;
                    };
                };
            };
        }

        private function detailsEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1)) || (!(_arg_2))))
            {
                return;
            };
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "back_button":
                        hideDetails();
                        return;
                    case "buy_button":
                        marketPlace.buyOffer(_SafeStr_1578.offerId);
                        return;
                };
                return;
            };
            if (_arg_1.type == "WE_SELECTED")
            {
                switch (_arg_2.name)
                {
                    case "price_development":
                    case "trade_volume":
                        updateStats();
                        return;
                };
            };
        }


    }
}


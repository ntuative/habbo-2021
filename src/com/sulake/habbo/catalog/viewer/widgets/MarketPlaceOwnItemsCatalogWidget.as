package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
    import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowEvent;

    public class MarketPlaceOwnItemsCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IMarketPlaceVisualization 
    {

        private const STATUS_SEARCHING:int = 1;
        private const STATUS_LIST_AVAILABLE:int = 2;

        private var _SafeStr_1582:Map;
        private var _itemList:IItemListWindow;
        private var _offers:Map;

        public function MarketPlaceOwnItemsCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
            _SafeStr_1582 = new Map();
        }

        override public function dispose():void
        {
            super.dispose();
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
            var _local_2:IHabboWindowManager = marketPlace.windowManager;
            if (_local_2 == null)
            {
                return (false);
            };
            displayMainView();
            var _local_1:IItemListWindow = (_window.findChildByName("item_list") as IItemListWindow);
            _SafeStr_1582.add(1, _local_1.removeListItem(_local_1.getListItemByName("ongoing_item")));
            _SafeStr_1582.add(2, _local_1.removeListItem(_local_1.getListItemByName("sold_item")));
            _SafeStr_1582.add(3, _local_1.removeListItem(_local_1.getListItemByName("expired_item")));
            marketPlace.registerVisualization(this);
            marketPlace.requestOwnItems();
            updateStatusDisplay(1);
            showRedeemInfo(false);
            return (true);
        }

        private function showRedeemInfo(_arg_1:Boolean):void
        {
            if (!window)
            {
                return;
            };
            var _local_2:IWindowContainer = (window.findChildByName("redeem_border") as IWindowContainer);
            if (_local_2)
            {
                _local_2.visible = _arg_1;
            };
        }

        public function listUpdatedNotify():void
        {
            if (marketPlace == null)
            {
                return;
            };
            updateList(marketPlace.latestOwnOffers());
        }

        private function updateStatusDisplay(_arg_1:int, _arg_2:int=-1):void
        {
            var _local_5:String;
            if (((!(marketPlace)) || (!(window))))
            {
                return;
            };
            var _local_3:IHabboLocalizationManager = marketPlace.localization;
            if (!_local_3)
            {
                return;
            };
            var _local_4:IWindow = window.findChildByName("status_text");
            if (_local_4 == null)
            {
                return;
            };
            if (_arg_1 == 1)
            {
                _local_5 = _local_3.getLocalization("catalog.marketplace.searching");
            }
            else
            {
                if (_arg_2 > 0)
                {
                    _local_5 = _local_3.getLocalization("catalog.marketplace.items_found");
                    _local_5 = _local_5.replace("%count%", _arg_2);
                }
                else
                {
                    _local_5 = _local_3.getLocalization("catalog.marketplace.no_items");
                };
            };
            _local_4.caption = _local_5;
        }

        private function get marketPlace():IMarketPlace
        {
            if ((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return (null);
            };
            return (page.viewer.catalog.getMarketPlace());
        }

        private function updateList(_arg_1:Map):void
        {
            var _local_24:IWindowContainer;
            var _local_21:int;
            var _local_14:int;
            var _local_17:MarketPlaceOfferData;
            var _local_4:IWindowContainer;
            var _local_8:IWindow;
            var _local_11:IWindow;
            var _local_31:IWindow;
            var _local_12:String;
            var _local_10:IWindow;
            var _local_26:int;
            var _local_18:int;
            var _local_20:int;
            var _local_13:String;
            var _local_29:String;
            var _local_22:IWindow;
            var _local_16:IWindow;
            var _local_6:_SafeStr_147;
            var _local_23:IBitmapWrapperWindow;
            var _local_9:Point;
            var _local_28:IWindow;
            var _local_19:IWidgetWindow;
            var _local_27:ILimitedItemGridOverlayWidget;
            var _local_25:IWidgetWindow;
            var _local_3:IRarityItemGridOverlayWidget;
            if ((((!(_arg_1)) || (!(marketPlace))) || (!(window))))
            {
                return;
            };
            _offers = _arg_1;
            var _local_2:IHabboLocalizationManager = marketPlace.localization;
            if (!_local_2)
            {
                return;
            };
            var _local_30:IItemListWindow = (window.findChildByName("item_list") as IItemListWindow);
            if (!_local_30)
            {
                return;
            };
            _local_30.destroyListItems();
            var _local_7:int;
            var _local_5:Array = _arg_1.getKeys();
            if (!_local_5)
            {
                return;
            };
            updateStatusDisplay(2, _local_5.length);
            _local_21 = 0;
            while (_local_21 < _local_5.length)
            {
                _local_14 = _local_5[_local_21];
                _local_17 = (_arg_1.getValue(_local_14) as MarketPlaceOfferData);
                if (_local_17.status == 2)
                {
                    _local_7++;
                };
                _local_24 = _SafeStr_1582.getValue(_local_17.status);
                if (_local_24)
                {
                    _local_4 = (_local_24.clone() as IWindowContainer);
                    if (!((!(_local_4)) || (_local_4.disposed)))
                    {
                        _local_8 = _local_4.findChildByName("item_name");
                        if (_local_8 != null)
                        {
                            _local_8.caption = ((marketPlace != null) ? (("${" + marketPlace.getNameLocalizationKey(_local_17)) + "}") : "");
                        };
                        _local_11 = _local_4.findChildByName("item_desc");
                        if (_local_11 != null)
                        {
                            _local_11.caption = ((marketPlace != null) ? (("${" + marketPlace.getDescriptionLocalizationKey(_local_17)) + "}") : "");
                        };
                        _local_31 = _local_4.findChildByName("item_price");
                        if (_local_31 != null)
                        {
                            _local_12 = _local_2.getLocalization("catalog.marketplace.offer.price_own_item");
                            _local_12 = _local_12.replace("%price%", _local_17.price);
                            _local_31.caption = _local_12;
                        };
                        if (_local_17.status == 1)
                        {
                            _local_10 = _local_4.findChildByName("item_time");
                            if (_local_10 != null)
                            {
                                _local_26 = Math.max(1, _local_17.timeLeftMinutes);
                                _local_18 = int(Math.floor((_local_26 / 60)));
                                _local_20 = (_local_26 - (_local_18 * 60));
                                _local_13 = ((_local_20 + " ") + _local_2.getLocalization("catalog.marketplace.offer.minutes"));
                                if (_local_18 > 0)
                                {
                                    _local_13 = ((((_local_18 + " ") + _local_2.getLocalization("catalog.marketplace.offer.hours")) + " ") + _local_13);
                                };
                                _local_29 = _local_2.getLocalization("catalog.marketplace.offer.time_left");
                                _local_29 = _local_29.replace("%time%", _local_13);
                                _local_10.caption = _local_29;
                            };
                        };
                        if (_local_17.status == 2)
                        {
                            _local_22 = _local_4.findChildByName("item_sold");
                            if (_local_22 != null)
                            {
                                _local_22.caption = _local_2.getLocalization("catalog.marketplace.offer.sold");
                            };
                        };
                        if (_local_17.status == 3)
                        {
                            _local_16 = _local_4.findChildByName("item_expired");
                            if (_local_16 != null)
                            {
                                _local_16.caption = _local_2.getLocalization("catalog.marketplace.offer.expired");
                            };
                        };
                        if (_local_17.image == null)
                        {
                            _local_6 = getFurniImageResult(_local_17.furniId, _local_17.furniType, _local_17.extraData);
                            if (((!(_local_6 == null)) && (!(_local_6.data == null))))
                            {
                                _local_17.image = (_local_6.data as BitmapData);
                                _local_17.imageCallback = _local_6.id;
                                _local_4.id = _local_6.id;
                            };
                        };
                        if (_local_17.image != null)
                        {
                            _local_23 = (_local_4.findChildByName("item_image") as IBitmapWrapperWindow);
                            if (_local_23 != null)
                            {
                                _local_9 = new Point(((_local_23.width - _local_17.image.width) / 2), ((_local_23.height - _local_17.image.height) / 2));
                                if (_local_23.bitmap == null)
                                {
                                    _local_23.bitmap = new BitmapData(_local_23.width, _local_23.height, true, 0);
                                };
                                _local_23.bitmap.copyPixels(_local_17.image, _local_17.image.rect, _local_9);
                            };
                        };
                        if (_local_17.isUniqueLimitedItem)
                        {
                            _local_28 = _local_4.findChildByName("unique_item_background_bitmap");
                            _local_19 = IWidgetWindow(_local_4.findChildByName("unique_item_overlay_widget"));
                            _local_27 = ILimitedItemGridOverlayWidget(_local_19.widget);
                            _local_27.serialNumber = _local_17.stuffData.uniqueSerialNumber;
                            _local_27.animated = true;
                            _local_28.visible = true;
                            _local_19.visible = true;
                        };
                        if (((_local_17.stuffData) && (_local_17.stuffData.rarityLevel >= 0)))
                        {
                            _local_25 = IWidgetWindow(_local_4.findChildByName("rarity_item_overlay_widget"));
                            _local_3 = IRarityItemGridOverlayWidget(_local_25.widget);
                            _local_25.visible = true;
                            _local_3.rarityLevel = _local_17.stuffData.rarityLevel;
                        };
                        _local_30.addListItem(_local_4);
                        _local_4.procedure = onGridEvent;
                    };
                };
                _local_21++;
            };
            showRedeemInfo(true);
            var _local_15:IWindow = window.findChildByName("redeem_info");
            if (_local_15)
            {
                if (_local_7 > 0)
                {
                    _local_2.registerParameter("catalog.marketplace.redeem.get_credits", "count", _local_7.toString());
                    _local_2.registerParameter("catalog.marketplace.redeem.get_credits", "credits", marketPlace.creditsWaiting.toString());
                    _local_15.caption = "${catalog.marketplace.redeem.get_credits}";
                }
                else
                {
                    _local_15.caption = "${catalog.marketplace.redeem.no_sold_items}";
                };
            };
        }

        public function displayMainView():void
        {
            attachWidgetView("marketPlaceOwnItemsWidget");
            window.procedure = onWidgetEvent;
            _itemList = (window.findChildByName("item_list") as IItemListWindow);
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

        private function onGridEvent(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_5:IItemListWindow;
            var _local_6:int;
            var _local_3:Map;
            var _local_4:MarketPlaceOfferData;
            if (_arg_1.type == "WME_CLICK")
            {
                if ((((!(marketPlace)) || (!(_arg_2))) || (!(window))))
                {
                    return;
                };
                if (_arg_2.name == "pick_button")
                {
                    _local_5 = (window.findChildByName("item_list") as IItemListWindow);
                    if (_local_5 == null)
                    {
                        return;
                    };
                    _local_6 = _local_5.getListItemIndex(_arg_1.window.parent);
                    _local_3 = marketPlace.latestOwnOffers();
                    if (!_local_3)
                    {
                        return;
                    };
                    _local_4 = (_local_3.getWithIndex(_local_6) as MarketPlaceOfferData);
                    if (_local_4)
                    {
                        marketPlace.redeemExpiredOffer(_local_4.offerId);
                    };
                };
            };
        }

        private function onWidgetEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_2 == null)
            {
                _arg_2 = (_arg_1.target as IWindow);
            };
            if (_arg_1.type == "WME_CLICK")
            {
            };
        }

        public function updateStats():void
        {
        }


    }
}


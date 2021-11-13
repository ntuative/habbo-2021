package com.sulake.habbo.catalog.marketplace
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.communication.messages.outgoing.marketplace._SafeStr_19;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultParser;
    import com.sulake.habbo.session.furniture.IFurnitureData;

    public class MarketPlaceLogic implements IMarketPlace
    {

        private static const TYPE_POSTER:String = "poster";

        public const PURCHASE_CONFIRM_TYPE_NORMAL:int = 1;
        public const PURCHASE_CONFIRM_TYPE_HIGHER:int = 2;
        public const _SafeStr_1452:int = 3;

        private var _catalog:HabboCatalog;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _visualization:IMarketPlaceVisualization;
        private var _SafeStr_516:MarketplaceConfirmationDialog;
        private var _latestOffers:Map;
        private var _latestOwnOffers:Map;
        private var _creditsWaiting:int;
        private var _averagePricePeriod:int = -1;
        private var _itemStats:MarketplaceItemStats;
        private var _SafeStr_1453:int;
        private var _SafeStr_1454:int;
        private var _SafeStr_1455:int;
        private var _minPrice:int = 0;
        private var _maxPrice:int = 0;
        private var _searchString:String = "";
        private var _SafeStr_1456:int = -1;
        private var _disposed:Boolean = false;

        public function MarketPlaceLogic(_arg_1:HabboCatalog, _arg_2:IHabboWindowManager, _arg_3:IRoomEngine)
        {
            _catalog = _arg_1;
            _windowManager = _arg_2;
            _roomEngine = _arg_3;
            getConfiguration();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _catalog = null;
            _windowManager = null;
            if (_latestOffers != null)
            {
                disposeOffers(_latestOffers);
                _latestOffers = null;
            };
            if (_latestOwnOffers != null)
            {
                disposeOffers(_latestOwnOffers);
                _latestOwnOffers = null;
            };
            _disposed = true;
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_catalog.localization);
        }

        public function registerVisualization(_arg_1:IMarketPlaceVisualization=null):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _visualization = _arg_1;
        }

        private function getConfiguration():void
        {
            if (((!(_catalog)) || (!(_catalog.connection))))
            {
                return;
            };
            _catalog.connection.send(new _SafeStr_19());
        }

        private function showConfirmation(_arg_1:int, _arg_2:MarketPlaceOfferData):void
        {
            if (!_SafeStr_516)
            {
                _SafeStr_516 = new MarketplaceConfirmationDialog(this, _catalog, _roomEngine);
            };
            _SafeStr_516.showConfirmation(_arg_1, _arg_2);
        }

        public function requestOffersByName(_arg_1:String):void
        {
            if (_catalog)
            {
                _catalog.getPublicMarketPlaceOffers(-1, -1, _arg_1, -1);
            };
        }

        public function requestOffersByPrice(_arg_1:int):void
        {
            if (_catalog)
            {
                _catalog.getPublicMarketPlaceOffers(_arg_1, -1, "", -1);
            };
        }

        public function requestOffers(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):void
        {
            _minPrice = _arg_1;
            _maxPrice = _arg_2;
            _searchString = _arg_3;
            _SafeStr_1456 = _arg_4;
            if (_catalog)
            {
                _catalog.getPublicMarketPlaceOffers(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        public function refreshOffers():void
        {
            requestOffers(_minPrice, _maxPrice, _searchString, _SafeStr_1456);
        }

        public function requestOwnItems():void
        {
            if (_catalog)
            {
                _catalog.getOwnMarketPlaceOffers();
            };
        }

        public function requestItemStats(_arg_1:int, _arg_2:int):void
        {
            if (_catalog)
            {
                _SafeStr_1454 = _arg_2;
                _SafeStr_1453 = _arg_1;
                _catalog.getMarketplaceItemStats(_arg_1, _arg_2);
            };
        }

        public function buyOffer(_arg_1:int):void
        {
            if ((((!(_latestOffers)) || (!(_catalog))) || (!(_catalog.getPurse()))))
            {
                return;
            };
            var _local_2:MarketPlaceOfferData = (_latestOffers.getValue(_arg_1) as MarketPlaceOfferData);
            if (!_local_2)
            {
                return;
            };
            if (_catalog.getPurse().credits < _local_2.price)
            {
                _catalog.showNotEnoughCreditsAlert();
                return;
            };
            showConfirmation(1, _local_2);
        }

        public function redeemExpiredOffer(_arg_1:int):void
        {
            if (_catalog)
            {
                _catalog.redeemExpiredMarketPlaceOffer(_arg_1);
            };
        }

        private function disposeOffers(_arg_1:Map):void
        {
            if (_arg_1 != null)
            {
                for each (var _local_2:MarketPlaceOfferData in _arg_1)
                {
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                };
                _arg_1.dispose();
            };
        }

        public function onOffers(_arg_1:IMessageEvent):void
        {
            var _local_3:MarketPlaceOfferData;
            var _local_4:MarketPlaceOffersEvent = (_arg_1 as MarketPlaceOffersEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:MarketPlaceOffersParser = (_local_4.getParser() as MarketPlaceOffersParser);
            if (_local_2 == null)
            {
                return;
            };
            disposeOffers(_latestOffers);
            _latestOffers = new Map();
            for each (var _local_5:MarketPlaceOffer in _local_2.offers)
            {
                _local_3 = new MarketPlaceOfferData(_local_5.offerId, _local_5.furniId, _local_5.furniType, _local_5.extraData, _local_5.stuffData, _local_5.price, _local_5.status, _local_5.averagePrice, _local_5.offerCount);
                _local_3.timeLeftMinutes = _local_5.timeLeftMinutes;
                _latestOffers.add(_local_5.offerId, _local_3);
            };
            _SafeStr_1455 = _local_2.totalItemsFound;
            if (_visualization != null)
            {
                _visualization.listUpdatedNotify();
            };
        }

        public function onOwnOffers(_arg_1:IMessageEvent):void
        {
            var _local_3:MarketPlaceOfferData;
            var _local_4:MarketPlaceOwnOffersEvent = (_arg_1 as MarketPlaceOwnOffersEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:MarketPlaceOwnOffersParser = (_local_4.getParser() as MarketPlaceOwnOffersParser);
            if (_local_2 == null)
            {
                return;
            };
            disposeOffers(_latestOwnOffers);
            _latestOwnOffers = new Map();
            _creditsWaiting = _local_2.creditsWaiting;
            for each (var _local_5:MarketPlaceOffer in _local_2.offers)
            {
                _local_3 = new MarketPlaceOfferData(_local_5.offerId, _local_5.furniId, _local_5.furniType, _local_5.extraData, _local_5.stuffData, _local_5.price, _local_5.status, _local_5.averagePrice);
                _local_3.timeLeftMinutes = _local_5.timeLeftMinutes;
                _latestOwnOffers.add(_local_5.offerId, _local_3);
            };
            if (_visualization != null)
            {
                _visualization.listUpdatedNotify();
            };
        }

        public function onBuyResult(_arg_1:IMessageEvent):void
        {
            var event:IMessageEvent = _arg_1;
            var buyEvent:MarketplaceBuyOfferResultEvent = (event as MarketplaceBuyOfferResultEvent);
            if (event == null)
            {
                return;
            };
            var parser:MarketplaceBuyOfferResultParser = (buyEvent.getParser() as MarketplaceBuyOfferResultParser);
            if (parser == null)
            {
                return;
            };
            if (parser.result == 1)
            {
                refreshOffers();
            }
            else
            {
                if (parser.result == 2)
                {
                    var item:MarketPlaceOfferData = _latestOffers.remove(parser.requestedOfferId);
                    if (item != null)
                    {
                        item.dispose();
                    };
                    if (_visualization != null)
                    {
                        _visualization.listUpdatedNotify();
                    };
                    if (_windowManager != null)
                    {
                        _windowManager.alert("${catalog.marketplace.not_available_title}", "${catalog.marketplace.not_available_header}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                    };
                }
                else
                {
                    if (parser.result == 3)
                    {
                        var updateItem:MarketPlaceOfferData = (_latestOffers.getValue(parser.requestedOfferId) as MarketPlaceOfferData);
                        if (updateItem)
                        {
                            updateItem.offerId = parser.offerId;
                            updateItem.price = parser.newPrice;
                            updateItem.offerCount--;
                            _latestOffers.add(parser.offerId, updateItem);
                        };
                        _latestOffers.remove(parser.requestedOfferId);
                        showConfirmation(2, updateItem);
                        if (_visualization != null)
                        {
                            _visualization.listUpdatedNotify();
                        };
                    }
                    else
                    {
                        if (parser.result == 4)
                        {
                            if (_windowManager != null)
                            {
                                _windowManager.alert("${catalog.alert.notenough.title}", "${catalog.alert.notenough.credits.description}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                                {
                                    _arg_1.dispose();
                                });
                            };
                        };
                    };
                };
            };
        }

        public function onCancelResult(_arg_1:IMessageEvent):void
        {
            var event:IMessageEvent = _arg_1;
            var cancelEvent:MarketplaceCancelOfferResultEvent = (event as MarketplaceCancelOfferResultEvent);
            if (event == null)
            {
                return;
            };
            var parser:MarketplaceCancelOfferResultParser = (cancelEvent.getParser() as MarketplaceCancelOfferResultParser);
            if (parser == null)
            {
                return;
            };
            if (parser.success)
            {
                var item:MarketPlaceOfferData = _latestOwnOffers.remove(parser.offerId);
                if (item != null)
                {
                    item.dispose();
                };
                if (_visualization != null)
                {
                    _visualization.listUpdatedNotify();
                };
            }
            else
            {
                if (_windowManager != null)
                {
                    _windowManager.alert("${catalog.marketplace.operation_failed.topic}", "${catalog.marketplace.cancel_failed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                };
            };
        }

        public function latestOffers():Map
        {
            return (_latestOffers);
        }

        public function latestOwnOffers():Map
        {
            return (_latestOwnOffers);
        }

        public function totalItemsFound():int
        {
            return (_SafeStr_1455);
        }

        public function set itemStats(_arg_1:MarketplaceItemStats):void
        {
            if (((!(_arg_1.furniCategoryId == _SafeStr_1453)) || (!(_arg_1.furniTypeId == _SafeStr_1454))))
            {
                return;
            };
            _itemStats = _arg_1;
            if (_visualization != null)
            {
                _visualization.updateStats();
            };
        }

        public function get itemStats():MarketplaceItemStats
        {
            return (_itemStats);
        }

        public function get creditsWaiting():int
        {
            return (_creditsWaiting);
        }

        public function get averagePricePeriod():int
        {
            return (_averagePricePeriod);
        }

        public function set averagePricePeriod(_arg_1:int):void
        {
            _averagePricePeriod = _arg_1;
        }

        private function isPosterItem(_arg_1:IMarketPlaceOfferData):Boolean
        {
            var _local_2:IFurnitureData;
            var _local_3:String;
            var _local_4:Boolean;
            if (((_arg_1.furniType == 2) && (!(_arg_1.extraData == null))))
            {
                _local_2 = _catalog.getFurnitureData(_arg_1.furniId, "i");
                if (_local_2)
                {
                    _local_3 = _local_2.className;
                    if (((!(_local_3 == null)) && (_local_3 == "poster")))
                    {
                        _local_4 = true;
                    };
                };
            };
            return (_local_4);
        }

        public function getNameLocalizationKey(_arg_1:IMarketPlaceOfferData):String
        {
            var _local_2:String = "";
            if (_arg_1 != null)
            {
                if (isPosterItem(_arg_1))
                {
                    _local_2 = (("poster_" + _arg_1.extraData) + "_name");
                }
                else
                {
                    if (_arg_1.furniType == 1)
                    {
                        _local_2 = ("roomItem.name." + _arg_1.furniId);
                    }
                    else
                    {
                        if (_arg_1.furniType == 2)
                        {
                            _local_2 = ("wallItem.name." + _arg_1.furniId);
                        };
                    };
                };
            };
            return (_local_2);
        }

        public function getDescriptionLocalizationKey(_arg_1:IMarketPlaceOfferData):String
        {
            var _local_2:String = "";
            if (_arg_1 != null)
            {
                if (isPosterItem(_arg_1))
                {
                    _local_2 = (("poster_" + _arg_1.extraData) + "_desc");
                }
                else
                {
                    if (_arg_1.furniType == 1)
                    {
                        _local_2 = ("roomItem.desc." + _arg_1.furniId);
                    }
                    else
                    {
                        if (_arg_1.furniType == 2)
                        {
                            _local_2 = ("wallItem.desc." + _arg_1.furniId);
                        };
                    };
                };
            };
            return (_local_2);
        }

        public function isAccountSafetyLocked():Boolean
        {
            if (_catalog)
            {
                return (_catalog.sessionDataManager.isAccountSafetyLocked());
            };
            return (false);
        }


    }
}
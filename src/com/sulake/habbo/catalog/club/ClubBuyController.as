package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.widgets.IVipBuyCatalogWidget;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubBuyController 
    {

        private var _visualization:IVipBuyCatalogWidget;
        private var _catalog:HabboCatalog;
        private var _offers:Array;
        private var _SafeStr_516:ClubBuyConfirmationDialog;
        private var _connection:IConnection;
        private var _disposed:Boolean = false;

        public function ClubBuyController(_arg_1:HabboCatalog, _arg_2:IConnection)
        {
            _catalog = _arg_1;
            _connection = _arg_2;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_visualization != null)
            {
                _visualization.dispose();
                _visualization = null;
            };
            reset();
            closeConfirmation();
            _catalog = null;
            _disposed = true;
        }

        public function get catalog():HabboCatalog
        {
            return (_catalog);
        }

        public function reset():void
        {
            for each (var _local_1:ClubBuyOfferData in _offers)
            {
                _local_1.dispose();
            };
            _offers = [];
        }

        public function onOffers(_arg_1:HabboClubOffersMessageParser):void
        {
            var _local_9:ClubBuyOfferData = null;
            var _local_6:ClubBuyOfferData;
            var _local_7:Boolean;
            var _local_3:Array;
            var _local_8:int;
            if (_disposed)
            {
                return;
            };
            reset();
            var _local_5:int;
            for each (var _local_2:ClubOfferData in _arg_1.offers)
            {
                _local_6 = new ClubBuyOfferData(_local_2.offerId, _local_2.productCode, _local_2.priceCredits, _local_2.priceActivityPoints, _local_2.priceActivityPointType, _local_2.vip, _local_2.months, _local_2.extraDays, _local_2.daysLeftAfterPurchase, _local_2.year, _local_2.month, _local_2.day, _local_2.isGiftable);
                _offers.push(_local_6);
                if (_local_2.vip)
                {
                    _local_5++;
                    _local_9 = _local_6;
                };
            };
            if (_local_5 == 1)
            {
                _local_9.upgradeHcPeriodToVip = true;
            };
            _offers.sort(orderByPrecedence);
            if (_visualization != null)
            {
                _visualization.reset();
                _visualization.initClubType(getClubType());
                _local_7 = _visualization.isGift;
                _local_3 = getPromotedMonths(_local_7);
                for each (var _local_4:ClubBuyOfferData in _offers)
                {
                    if (_local_4.months > 0)
                    {
                        if (_local_3.length > 0)
                        {
                            _local_8 = _local_4.months;
                            if (_local_3.indexOf(_local_8) == -1) continue;
                        };
                        _visualization.showOffer(_local_4);
                    };
                };
            };
        }

        private function getPromotedMonths(_arg_1:Boolean):Array
        {
            var _local_4:String;
            var _local_3:Array;
            var _local_6:Number;
            var _local_2:Array = [];
            var _local_7:String = ((_arg_1) ? "catalog.vip.gift.promo" : "catalog.vip.buy.promo");
            if (_catalog.propertyExists(_local_7))
            {
                _local_4 = _catalog.getProperty(_local_7, null);
                if (((!(_local_4 == null)) && (_local_4.length > 0)))
                {
                    _local_3 = _local_4.split(",");
                    if (_local_3.length > 0)
                    {
                        for each (var _local_5:String in _local_3)
                        {
                            _local_6 = parseInt(_local_5);
                            if (((!(isNaN(_local_6))) && (_local_6 > 0)))
                            {
                                _local_2.push(_local_6);
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }

        public function unRegisterVisualization(_arg_1:IVipBuyCatalogWidget):void
        {
            if (_visualization == _arg_1)
            {
                _visualization = null;
            };
        }

        public function registerVisualization(_arg_1:IVipBuyCatalogWidget):void
        {
            _visualization = _arg_1;
        }

        public function requestOffers(_arg_1:int):void
        {
            _catalog.getHabboClubOffers(_arg_1);
        }

        public function showConfirmation(_arg_1:ClubBuyOfferData, _arg_2:int):void
        {
            closeConfirmation();
            _SafeStr_516 = new ClubBuyConfirmationDialog(this, _arg_1, _arg_2);
        }

        public function confirmSelection(_arg_1:ClubBuyOfferData, _arg_2:int):void
        {
            if (((!(_catalog)) || (!(_catalog.connection))))
            {
                return;
            };
            _catalog.purchaseProduct(_arg_2, _arg_1.offerId);
            closeConfirmation();
        }

        public function closeConfirmation():void
        {
            if (_SafeStr_516)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
        }

        public function getClubType():int
        {
            var _local_1:int;
            if (_catalog.getPurse().hasClubLeft)
            {
                _local_1 = ((_catalog.getPurse().isVIP) ? 2 : 1);
            };
            return (_local_1);
        }

        public function get hasClub():Boolean
        {
            if (((!(_catalog)) || (!(_catalog.getPurse()))))
            {
                return (false);
            };
            return (_catalog.getPurse().clubDays > 0);
        }

        public function get windowManager():IHabboWindowManager
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.localization);
        }

        public function get assets():IAssetLibrary
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.assets);
        }

        public function get roomEngine():IRoomEngine
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.roomEngine);
        }

        public function getProductData(_arg_1:String):IProductData
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.getProductData(_arg_1));
        }

        public function getPurse():IPurse
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.getPurse());
        }

        private function orderByPrecedence(_arg_1:ClubBuyOfferData, _arg_2:ClubBuyOfferData):Number
        {
            var _local_3:Number = _arg_1.months;
            var _local_4:Number = _arg_2.months;
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            return (0);
        }


    }
}


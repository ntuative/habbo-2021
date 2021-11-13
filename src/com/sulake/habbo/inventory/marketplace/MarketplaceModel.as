package com.sulake.habbo.inventory.marketplace
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.inventory.items.FurnitureItem;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.communication.messages.outgoing.marketplace._SafeStr_29;
    import com.sulake.habbo.communication.messages.outgoing.marketplace._SafeStr_20;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace._SafeStr_19;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MarketplaceModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_2080:FurnitureItem;
        private var _isEnabled:Boolean;
        private var _commission:int;
        private var _tokenBatchPrice:int;
        private var _tokenBatchSize:int;
        private var _offerMinPrice:int;
        private var _offerMaxPrice:int;
        private var _expirationHours:int;
        private var _SafeStr_2765:int;
        private var _sellingFeePercentage:int;
        private var _revenueLimit:int;
        private var _halfTaxLimit:int;
        private var _SafeStr_1453:int;
        private var _SafeStr_1454:int;
        private var _SafeStr_570:MarketplaceView;
        private var _SafeStr_2766:Boolean = false;

        public function MarketplaceModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboLocalizationManager)
        {
            _controller = _arg_1;
            _communication = _arg_3;
            _windowManager = _arg_2;
            _assets = _arg_4;
            _roomEngine = _arg_5;
            _SafeStr_570 = new MarketplaceView(this, _windowManager, _assets, _arg_5, _arg_6, _arg_1);
        }

        public function get id():String
        {
            return ("marketplace");
        }

        public function set isEnabled(_arg_1:Boolean):void
        {
            _isEnabled = _arg_1;
        }

        public function set commission(_arg_1:int):void
        {
            _commission = _arg_1;
        }

        public function set tokenBatchPrice(_arg_1:int):void
        {
            _tokenBatchPrice = _arg_1;
        }

        public function set tokenBatchSize(_arg_1:int):void
        {
            _tokenBatchSize = _arg_1;
        }

        public function set offerMinPrice(_arg_1:int):void
        {
            _offerMinPrice = _arg_1;
        }

        public function set offerMaxPrice(_arg_1:int):void
        {
            _offerMaxPrice = _arg_1;
        }

        public function set expirationHours(_arg_1:int):void
        {
            _expirationHours = _arg_1;
        }

        public function set averagePricePeriod(_arg_1:int):void
        {
            _SafeStr_2765 = _arg_1;
        }

        public function set sellingFeePercentage(_arg_1:int):void
        {
            _sellingFeePercentage = _arg_1;
        }

        public function set revenueLimit(_arg_1:int):void
        {
            _revenueLimit = _arg_1;
        }

        public function set halfTaxLimit(_arg_1:int):void
        {
            _halfTaxLimit = _arg_1;
        }

        public function get isEnabled():Boolean
        {
            return (_isEnabled);
        }

        public function get commission():int
        {
            return (_commission);
        }

        public function get tokenBatchPrice():int
        {
            return (_tokenBatchPrice);
        }

        public function get tokenBatchSize():int
        {
            return (_tokenBatchSize);
        }

        public function get offerMinPrice():int
        {
            return (_offerMinPrice);
        }

        public function get offerMaxPrice():int
        {
            return (_offerMaxPrice);
        }

        public function get expirationHours():int
        {
            return (_expirationHours);
        }

        public function get sellingFeePercentage():int
        {
            return (_sellingFeePercentage);
        }

        public function get revenueLimit():int
        {
            return (_revenueLimit);
        }

        public function get halfTaxLimit():int
        {
            return (_halfTaxLimit);
        }

        public function get controller():HabboInventory
        {
            return (_controller);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            _controller = null;
            _communication = null;
            _windowManager = null;
            _assets = null;
            _roomEngine = null;
        }

        public function releaseItem():void
        {
            if ((((!(_controller == null)) && (!(_controller.furniModel == null))) && (!(_SafeStr_2080 == null))))
            {
                _controller.furniModel.removeLockFrom(_SafeStr_2080.id);
                _SafeStr_2080 = null;
            };
        }

        public function startOfferMaking(_arg_1:FurnitureItem):void
        {
            if (((!(_SafeStr_2080 == null)) || (_arg_1 == null)))
            {
                return;
            };
            if (_controller == null)
            {
                return;
            };
            var _local_2:FurniModel = _controller.furniModel;
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_2080 = _arg_1;
            _local_2.addLockTo(_arg_1.id);
            send(new _SafeStr_29());
        }

        public function buyMarketplaceTokens():void
        {
            send(new _SafeStr_20());
            _SafeStr_2766 = true;
        }

        public function makeOffer(_arg_1:int):void
        {
            if (_SafeStr_2080 == null)
            {
                return;
            };
            var _local_2:int = ((_SafeStr_2080.isWallItem) ? 2 : 1);
            send(new MakeOfferMessageComposer(_arg_1, _local_2, _SafeStr_2080.ref));
            releaseItem();
        }

        public function getItemStats():void
        {
            if (_SafeStr_2080 == null)
            {
                return;
            };
            var _local_1:int = ((_SafeStr_2080.isWallItem) ? 2 : 1);
            _SafeStr_1453 = _local_1;
            _SafeStr_1454 = _SafeStr_2080.type;
            send(new GetMarketplaceItemStatsComposer(_local_1, _SafeStr_2080.type));
        }

        public function proceedOfferMaking(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_2766 = false;
            switch (_arg_1)
            {
                case 1:
                    _SafeStr_570.showMakeOffer(_SafeStr_2080);
                    return;
                case 2:
                    _SafeStr_570.showAlert("${inventory.marketplace.no_trading_privilege.title}", "${inventory.marketplace.no_trading_privilege.info}");
                    return;
                case 3:
                    _SafeStr_570.showAlert("${inventory.marketplace.no_trading_pass.title}", "${inventory.marketplace.no_trading_pass.info}");
                    return;
                case 4:
                    _SafeStr_570.showBuyTokens(_tokenBatchPrice, _tokenBatchSize);
                    return;
                case 5:
                    return;
                case 6:
                    _SafeStr_570.showAlert("${inventory.marketplace.trading_lock.title}", "${inventory.marketplace.trading_lock.info}");
                default:
            };
        }

        public function endOfferMaking(_arg_1:int):void
        {
            if (!_SafeStr_570)
            {
                return;
            };
            _SafeStr_570.showResult(_arg_1);
        }

        public function setAveragePrice(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (((!(_arg_1 == _SafeStr_1453)) || (!(_arg_2 == _SafeStr_1454))))
            {
                return;
            };
            if (!_SafeStr_570)
            {
                return;
            };
            _SafeStr_570.updateAveragePrice(_arg_3, _SafeStr_2765);
        }

        public function onNotEnoughCredits():void
        {
            if (_SafeStr_2766)
            {
                _SafeStr_2766 = false;
                releaseItem();
            };
        }

        public function requestInitialization():void
        {
            send(new _SafeStr_19());
        }

        public function getOfferItem():IFurnitureItem
        {
            return (_SafeStr_2080);
        }

        public function getWindowContainer():IWindowContainer
        {
            return (null);
        }

        public function categorySwitch(_arg_1:String):void
        {
        }

        public function subCategorySwitch(_arg_1:String):void
        {
        }

        public function closingInventoryView():void
        {
        }

        public function updateView():void
        {
        }

        private function send(_arg_1:IMessageComposer):void
        {
            if (((!(_communication == null)) && (!(_communication.connection == null))))
            {
                _communication.connection.send(_arg_1);
            };
        }

        public function selectItemById(_arg_1:String):void
        {
            Logger.log("NOT SUPPORTED: MARKETPLACE SELECT BY ID");
        }


    }
}


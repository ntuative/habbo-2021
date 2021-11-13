package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.inventory.purse.Purse;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.configuration.enum.HabboComponentFlags;
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.inventory.bots.BotsModel;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import flash.events.TimerEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.inventory.badges.Badge;
    import com.sulake.iid.*;

    public class HabboInventory extends Component implements IHabboInventory, ILinkEventTracker
    {

        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_457:IncomingMessages;
        private var _windowManager:IHabboWindowManager;
        private var _sessionData:ISessionDataManager;
        private var _localization:IHabboLocalizationManager;
        private var _soundManager:IHabboSoundManager;
        private var _view:InventoryMainView;
        private var _SafeStr_550:Map;
        private var _roomEngine:IRoomEngine;
        private var _roomSession:IRoomSession;
        private var _SafeStr_551:Array;
        private var _SafeStr_529:Purse;
        private var _avatarRenderer:IAvatarRenderManager;
        private var _catalog:IHabboCatalog;
        private var _isInitialized:Boolean;
        private var _unseenItemTracker:UnseenItemTracker;
        private var _SafeStr_552:Boolean = false;
        private var _currentCategoryId:String;
        private var _SafeStr_553:Vector.<int>;
        private var _SafeStr_554:Vector.<String>;
        private var _SafeStr_549:Timer;

        public function HabboInventory(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_529 = new Purse();
            _SafeStr_551 = [];
            _SafeStr_553 = new Vector.<int>(0);
        }

        public function get isVisible():Boolean
        {
            return (_view.isVisible);
        }

        public function get isMainViewActive():Boolean
        {
            return (_view.isActive);
        }

        public function get isInitialized():Boolean
        {
            return (_isInitialized);
        }

        public function get unseenItemTracker():IUnseenItemTracker
        {
            return (_unseenItemTracker);
        }

        public function get view():InventoryMainView
        {
            return (_view);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionData = _arg_1;
            }), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderer = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), null, false, [{
                "type":"RSE_STARTED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSE_ENDED",
                "callback":roomSessionEventHandler
            }, {
                "type":"RSDUE_ALLOW_PETS",
                "callback":roomSessionEventHandler
            }]), new ComponentDependency(new IIDHabboToolbar(), null, false, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":habboToolbarEventHandler
            }]), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            })]));
        }

        private function habboToolbarEventHandler(_arg_1:HabboToolbarEvent):void
        {
            if (_view != null)
            {
                _view.onHabboToolbarEvent(_arg_1);
            };
        }

        override protected function initComponent():void
        {
            if (HabboComponentFlags.isRoomViewerMode(flags))
            {
                return;
            };
            _SafeStr_457 = new IncomingMessages(this);
            context.addLinkEventTracker(this);
            _unseenItemTracker = new UnseenItemTracker(_communication, events, this);
            _view = new InventoryMainView(this, _windowManager, assets);
            _communication.connection.send(new GetCreditsInfoComposer());
            _communication.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
            _communication.connection.send(new GetBadgePointLimitsComposer());
        }

        override public function dispose():void
        {
            var _local_4:Array;
            var _local_1:int;
            var _local_3:String;
            var _local_2:IInventoryModel;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_549 != null)
            {
                _SafeStr_549.stop();
                _SafeStr_549.removeEventListener("timer", onPurseTimer);
                _SafeStr_549 = null;
            };
            if (_SafeStr_550)
            {
                _local_4 = _SafeStr_550.getKeys();
                _local_1 = 0;
                while (_local_1 < _local_4.length)
                {
                    _local_3 = _local_4[_local_1];
                    _local_2 = (_SafeStr_550.getValue(_local_3) as IInventoryModel);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                _SafeStr_550.dispose();
                _SafeStr_550 = null;
            };
            if (_view != null)
            {
                _view.dispose();
                _view = null;
            };
            _roomSession = null;
            if (_unseenItemTracker != null)
            {
                _unseenItemTracker.dispose();
                _unseenItemTracker = null;
            };
            if (_SafeStr_457 != null)
            {
                _SafeStr_457.dispose();
                _SafeStr_457 = null;
            };
            super.dispose();
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function getModel(_arg_1:String):IInventoryModel
        {
            if (!_isInitialized)
            {
                init();
            };
            return (_SafeStr_550.getValue(_arg_1));
        }

        public function get furniModel():FurniModel
        {
            return ((disposed) ? null : FurniModel(getModel("furni")));
        }

        public function get tradingModel():TradingModel
        {
            return ((disposed) ? null : TradingModel(getModel("trading")));
        }

        public function get effectsModel():EffectsModel
        {
            return ((disposed) ? null : EffectsModel(getModel("effects")));
        }

        public function get badgesModel():BadgesModel
        {
            return ((disposed) ? null : BadgesModel(getModel("badges")));
        }

        public function get petsModel():PetsModel
        {
            return ((disposed) ? null : PetsModel(getModel("pets")));
        }

        public function get botsModel():BotsModel
        {
            return ((disposed) ? null : BotsModel(getModel("bots")));
        }

        public function get marketplaceModel():MarketplaceModel
        {
            return ((disposed) ? null : MarketplaceModel(getModel("marketplace")));
        }

        public function get sessionData():ISessionDataManager
        {
            return (_sessionData);
        }

        public function get roomSession():IRoomSession
        {
            return (_roomSession);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get clubDays():int
        {
            return (_SafeStr_529.clubDays);
        }

        public function get clubPeriods():int
        {
            return (_SafeStr_529.clubPeriods);
        }

        public function get clubPastPeriods():int
        {
            return (_SafeStr_529.clubPastPeriods);
        }

        public function get clubHasEverBeenMember():Boolean
        {
            return (_SafeStr_529.clubHasEverBeenMember);
        }

        public function get clubIsExpiring():Boolean
        {
            return (_SafeStr_529.clubIsExpiring);
        }

        public function get citizenshipVipIsExpiring():Boolean
        {
            return (_SafeStr_529.citizenshipVipIsExpiring);
        }

        public function get clubMinutesUntilExpiration():int
        {
            return (_SafeStr_529.minutesUntilExpiration);
        }

        public function get clubLevel():int
        {
            if (((clubDays == 0) && (clubPeriods == 0)))
            {
                return (0);
            };
            if (_SafeStr_529.isVIP)
            {
                return (2);
            };
            return (1);
        }

        public function get hasRoomSession():Boolean
        {
            return (!(_roomSession == null));
        }

        public function getSubCategoryViewId():String
        {
            return (_view.getSubCategoryViewId());
        }

        public function setClubStatus(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:int, _arg_8:int):void
        {
            _SafeStr_529.clubPeriods = _arg_1;
            _SafeStr_529.clubDays = _arg_2;
            _SafeStr_529.clubHasEverBeenMember = _arg_3;
            _SafeStr_529.isVIP = _arg_4;
            _SafeStr_529.clubIsExpiring = _arg_5;
            _SafeStr_529.citizenshipVipIsExpiring = _arg_6;
            _SafeStr_529.minutesUntilExpiration = _arg_7;
            _SafeStr_529.minutesSinceLastModified = _arg_8;
            if (((_arg_7 > 0) && (_arg_7 < 86400000)))
            {
                if (_SafeStr_549 == null)
                {
                    _SafeStr_549 = new Timer(60000, 0);
                    _SafeStr_549.addEventListener("timer", onPurseTimer);
                };
                if (!_SafeStr_549.running)
                {
                    _SafeStr_549.start();
                };
            }
            else
            {
                if (_SafeStr_549 != null)
                {
                    _SafeStr_549.stop();
                    _SafeStr_549.removeEventListener("timer", onPurseTimer);
                    _SafeStr_549 = null;
                };
            };
        }

        private function onPurseTimer(_arg_1:TimerEvent):void
        {
            _communication.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
        }

        private function roomSessionEventHandler(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type)
            {
                case "RSE_STARTED":
                    _roomSession = _arg_1.session;
                    if (_isInitialized)
                    {
                        if (petsModel != null)
                        {
                            petsModel.updatePetsAllowed();
                        };
                        if (furniModel != null)
                        {
                            furniModel.updateView();
                        };
                    };
                    return;
                case "RSE_ENDED":
                    _roomSession = null;
                    if (_isInitialized)
                    {
                        deselectAllEffects();
                    };
                    return;
                case "RSDUE_ALLOW_PETS":
                    if (_isInitialized)
                    {
                        if (petsModel != null)
                        {
                            petsModel.updatePetsAllowed();
                        };
                    };
                    return;
            };
        }

        private function init():void
        {
            if (!allRequiredDependenciesInjected)
            {
                return;
            };
            _SafeStr_550 = new Map();
            var _local_6:MarketplaceModel = new MarketplaceModel(this, _windowManager, _communication, assets, _roomEngine, _localization);
            _SafeStr_550.add("marketplace", _local_6);
            var _local_1:FurniModel = new FurniModel(this, _local_6, _windowManager, _communication, assets, _roomEngine, _catalog, _soundManager, _localization);
            _SafeStr_550.add("furni", _local_1);
            _SafeStr_550.add("rentables", _local_1);
            var _local_2:BadgesModel = new BadgesModel(this, _windowManager, _communication, assets);
            _SafeStr_550.add("badges", _local_2);
            var _local_3:EffectsModel = new EffectsModel(this, _windowManager, _communication, assets, _localization);
            _SafeStr_550.add("effects", _local_3);
            var _local_4:TradingModel = new TradingModel(this, _windowManager, _communication, assets, _roomEngine, _localization, _soundManager);
            _SafeStr_550.add("trading", _local_4);
            var _local_7:PetsModel = new PetsModel(this, _windowManager, _communication, assets, _roomEngine, _catalog);
            _SafeStr_550.add("pets", _local_7);
            var _local_5:BotsModel = new BotsModel(this, _windowManager, _communication, assets, _roomEngine, _catalog, _avatarRenderer);
            _SafeStr_550.add("bots", _local_5);
            _isInitialized = true;
        }

        public function getCategoryWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:IInventoryModel = IInventoryModel(_SafeStr_550.getValue(_arg_1));
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2.getWindowContainer());
        }

        public function updateView(_arg_1:String):void
        {
            var _local_2:IInventoryModel = IInventoryModel(_SafeStr_550.getValue(_arg_1));
            if (_local_2 == null)
            {
                return;
            };
            return (_local_2.updateView());
        }

        public function getCategorySubWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:IInventoryModel = IInventoryModel(_SafeStr_550.getValue(_arg_1));
            return ((_local_2 == null) ? null : _local_2.getWindowContainer());
        }

        public function getActivatedAvatarEffects():Array
        {
            return ((effectsModel == null) ? [] : effectsModel.getEffects(1));
        }

        public function getAvatarEffects():Array
        {
            return ((effectsModel == null) ? [] : effectsModel.getEffects());
        }

        public function setEffectSelected(_arg_1:int):void
        {
            var _local_2:EffectsModel = effectsModel;
            if (_local_2 == null)
            {
                return;
            };
            _local_2.useEffect(_arg_1);
            notifyChangedEffects();
        }

        public function setEffectDeselected(_arg_1:int):void
        {
            var _local_2:EffectsModel = effectsModel;
            if (_local_2 == null)
            {
                return;
            };
            _local_2.stopUsingEffect(_arg_1, true);
            notifyChangedEffects();
        }

        public function deselectAllEffects(_arg_1:Boolean=false):void
        {
            var _local_2:EffectsModel = effectsModel;
            if (_local_2 == null)
            {
                return;
            };
            _local_2.stopUsingAllEffects(true, true, _arg_1);
            notifyChangedEffects();
        }

        public function getAvatarEffect(_arg_1:int):IAvatarEffect
        {
            return ((effectsModel == null) ? null : effectsModel.getEffectInterface(_arg_1));
        }

        public function closeView():void
        {
            if (((_view) && (_view.isVisible)))
            {
                _view.hideInventory();
            };
        }

        public function showView():void
        {
            if (_view)
            {
                _view.showInventory();
            };
        }

        public function get isMainViewInitialized():Boolean
        {
            return (!(_view.mainContainer == null));
        }

        public function initializeFurniturePage():void
        {
            if (_view)
            {
                toggleInventoryPage("furni");
                _view.hideInventory();
            };
        }

        public function toggleInventoryPage(_arg_1:String, _arg_2:String=null, _arg_3:Boolean=false):void
        {
            _currentCategoryId = _arg_1;
            var _local_4:Boolean = _view.toggleCategoryView(_arg_1, false, _arg_3);
            if (_local_4)
            {
                inventoryViewOpened(_arg_1);
                if (_arg_2 != null)
                {
                    IInventoryModel(_SafeStr_550.getValue(_currentCategoryId)).selectItemById(_arg_2);
                };
            };
            if (!_local_4)
            {
                events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_CLOSED"));
            };
        }

        public function toggleInventorySubPage(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:IInventoryModel;
            _view.toggleSubCategoryView(_arg_1, false);
            _local_2 = 0;
            while (_local_2 < _SafeStr_550.length)
            {
                _local_3 = (_SafeStr_550.getWithIndex(_local_2) as IInventoryModel);
                _local_3.subCategorySwitch(_arg_1);
                _local_2++;
            };
            switch (_arg_1)
            {
                case "trading":
                    _view.toggleCategoryView("furni", false);
                    return;
            };
        }

        public function updateSubView():void
        {
            _view.updateSubCategoryView();
        }

        public function closingInventoryView():void
        {
            var _local_1:int;
            var _local_2:IInventoryModel;
            if (_SafeStr_550)
            {
                _local_1 = 0;
                while (_local_1 < _SafeStr_550.length)
                {
                    _local_2 = (_SafeStr_550.getWithIndex(_local_1) as IInventoryModel);
                    _local_2.closingInventoryView();
                    _local_1++;
                };
            };
            events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_CLOSED"));
        }

        public function preparingInventoryView():void
        {
            if (!_isInitialized)
            {
                init();
            };
        }

        public function inventoryViewOpened(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:IInventoryModel;
            _local_2 = 0;
            while (_local_2 < _SafeStr_550.length)
            {
                _local_3 = (_SafeStr_550.getWithIndex(_local_2) as IInventoryModel);
                _local_3.categorySwitch(_arg_1);
                _local_2++;
            };
        }

        public function setupTrading(_arg_1:int, _arg_2:String):void
        {
            if (!_isInitialized)
            {
                init();
            };
            var _local_3:TradingModel = tradingModel;
            if (_local_3 == null)
            {
                return;
            };
            _local_3.requestOpenTrading(_arg_1);
        }

        public function get tradingActive():Boolean
        {
            return ((tradingModel == null) ? false : tradingModel.running);
        }

        public function canUserOfferToTrade():Boolean
        {
            var _local_1:TradingModel = tradingModel;
            return ((_local_1 != null) ? _local_1.ownUserCanTrade : false);
        }

        public function setInventoryCategoryInit(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_3:int;
            if (_arg_2)
            {
                if (_SafeStr_551.indexOf(_arg_1) == -1)
                {
                    _SafeStr_551.push(_arg_1);
                };
            }
            else
            {
                _local_3 = _SafeStr_551.indexOf(_arg_1);
                if (_local_3 >= 0)
                {
                    _SafeStr_551.splice(_local_3, 1);
                };
                if (((!(_view == null)) && (_view.isVisible)))
                {
                    if (_arg_1 != "rentables")
                    {
                        requestInventoryCategoryInit(_arg_1);
                    };
                };
            };
        }

        public function isInventoryCategoryInit(_arg_1:String):Boolean
        {
            return (_SafeStr_551.indexOf(_arg_1) >= 0);
        }

        public function checkCategoryInitilization(_arg_1:String):Boolean
        {
            if (isInventoryCategoryInit(_arg_1))
            {
                return (true);
            };
            requestInventoryCategoryInit(_arg_1);
            return (false);
        }

        public function requestInventoryCategoryInit(_arg_1:String):void
        {
            var _local_2:IInventoryModel = (_SafeStr_550.getValue(_arg_1) as IInventoryModel);
            if (_local_2 != null)
            {
                _local_2.requestInitialization();
            };
        }

        public function notifyChangedEffects():void
        {
            events.dispatchEvent(new HabboInventoryEffectsEvent("HIEE_EFFECTS_CHANGED"));
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function requestSelectedFurniToMover(_arg_1:IFurnitureItem):Boolean
        {
            var _local_3:int;
            var _local_2:Boolean;
            if (_arg_1.isWallItem)
            {
                _local_3 = 20;
            }
            else
            {
                _local_3 = 10;
            };
            if (_arg_1.category == 6)
            {
                _local_2 = _roomEngine.initializeRoomObjectInsert("inventory", _arg_1.id, _local_3, _arg_1.type, _arg_1.stuffData.getLegacyString());
            }
            else
            {
                _local_2 = _roomEngine.initializeRoomObjectInsert("inventory", _arg_1.id, _local_3, _arg_1.type, _arg_1.extra.toString(), _arg_1.stuffData);
            };
            return (_local_2);
        }

        public function getFloorItemById(_arg_1:int):IFurnitureItem
        {
            var _local_2:IFurnitureItem;
            for each (var _local_3:GroupItem in furniModel.furniData)
            {
                _local_2 = _local_3.getItem(_arg_1);
                if (((!(_local_2 == null)) && (!(_local_2.isWallItem))))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getWallItemById(_arg_1:int):IFurnitureItem
        {
            var _local_2:IFurnitureItem;
            for each (var _local_3:GroupItem in furniModel.furniData)
            {
                _local_2 = _local_3.getItem(_arg_1);
                if (((!(_local_2 == null)) && (_local_2.isWallItem)))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getNonRentedInventoryIds(_arg_1:String, _arg_2:int):Array
        {
            var _local_4:FurniModel = _SafeStr_550.getValue(_arg_1);
            if (!_local_4)
            {
                return (null);
            };
            var _local_3:GroupItem = furniModel.getGroupItemByItemTypeId(_arg_2);
            if (!_local_3)
            {
                return (null);
            };
            return (_local_3.getNonRentedFurnitureIds());
        }

        public function placePetToRoom(_arg_1:int, _arg_2:Boolean=false):Boolean
        {
            return (petsModel.placePetToRoom(_arg_1, _arg_2));
        }

        public function updateUnseenItemCounts():void
        {
            var _local_4:int;
            _local_4 = _unseenItemTracker.getCount(1);
            _view.updateUnseenFurniCount(_local_4);
            _local_4 = _unseenItemTracker.getCount(2);
            _view.updateUnseenRentedFurniCount(_local_4);
            var _local_1:int = _unseenItemTracker.getCount(3);
            _view.updateUnseenPetsCount(_local_1);
            var _local_3:int = _unseenItemTracker.getCount(4);
            _view.updateUnseenBadgeCount(_local_3);
            var _local_2:int = _unseenItemTracker.getCount(5);
            _view.updateUnseenBotCount(_local_2);
        }

        public function removeUnseenFurniCounter(_arg_1:int):Boolean
        {
            var _local_2:Boolean = furniModel.removeUnseenFurniCounter(_arg_1);
            if (_local_2)
            {
                updateUnseenItemCounts();
            };
            return (_local_2);
        }

        public function removeUnseenPetCounter(_arg_1:int):Boolean
        {
            var _local_2:Boolean = petsModel.removeUnseenFurniCounter(_arg_1);
            if (_local_2)
            {
                updateUnseenItemCounts();
            };
            return (_local_2);
        }

        public function get botsMax():int
        {
            return (getInteger("inventory.bots.max", 150));
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get currentCategoryId():String
        {
            return (_currentCategoryId);
        }

        public function getFurnitureData(_arg_1:int, _arg_2:String):IFurnitureData
        {
            var _local_3:IFurnitureData;
            if (_sessionData == null)
            {
                return (null);
            };
            if (_arg_2 == "s")
            {
                _local_3 = _sessionData.getFloorItemData(_arg_1);
            };
            if (_arg_2 == "i")
            {
                _local_3 = _sessionData.getWallItemData(_arg_1);
            };
            return (_local_3);
        }

        public function getFurnitureDataByName(_arg_1:String, _arg_2:String, _arg_3:int=0):IFurnitureData
        {
            var _local_4:IFurnitureData;
            if (_sessionData == null)
            {
                return (null);
            };
            if (_arg_2 == "s")
            {
                _local_4 = _sessionData.getFloorItemDataByName(_arg_1);
            };
            if (_arg_2 == "i")
            {
                _local_4 = _sessionData.getWallItemDataByName(_arg_1);
            };
            return (_local_4);
        }

        public function get linkPattern():String
        {
            return ("inventory/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "open":
                    if (_local_2.length == 2)
                    {
                        toggleInventoryPage("furni");
                    }
                    else
                    {
                        if (_local_2.length == 3)
                        {
                            toggleInventoryPage(_local_2[2]);
                        }
                        else
                        {
                            if (_local_2.length == 4)
                            {
                                toggleInventoryPage(_local_2[2], _local_2[3]);
                            };
                        };
                    };
                    return;
                default:
                    Logger.log(("Inventory unknown link-type received: " + _local_2[1]));
                    return;
            };
        }

        public function getAllMyBadgeIds(_arg_1:Array):Array
        {
            var _local_2:BadgesModel = _SafeStr_550.getValue("badges");
            var _local_4:Array = [];
            if (((_local_2.getBadges().length == 0) && (!(_SafeStr_552))))
            {
                badgesModel.requestInitialization();
                _SafeStr_552 = true;
            };
            for each (var _local_3:Badge in _local_2.getBadges())
            {
                if (((_arg_1 == null) || (_arg_1.indexOf(_local_3.badgeId) == -1)))
                {
                    _local_4.push(_local_3.badgeId);
                };
            };
            return (_local_4);
        }

        public function hasFigureSetIdInInventory(_arg_1:int):Boolean
        {
            return (_SafeStr_553.indexOf(_arg_1) > -1);
        }

        public function hasBoundFigureSetFurniture(_arg_1:String):Boolean
        {
            return (_SafeStr_554.indexOf(_arg_1) > -1);
        }

        public function updatePurchasedFigureSetIds(_arg_1:Vector.<int>, _arg_2:Vector.<String>):void
        {
            _SafeStr_553 = _arg_1;
            _SafeStr_554 = _arg_2;
        }

        public function getLastActivatedEffect():int
        {
            return (effectsModel.lastActivatedEffect);
        }


    }
}
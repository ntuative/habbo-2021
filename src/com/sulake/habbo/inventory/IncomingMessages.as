package com.sulake.habbo.inventory
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotAddedToInventoryEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListAddOrUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeOpenFailedParser;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.clothing.FigureSetIdsEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotRemovedFromInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.GoToBreedingNestFailureEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
    import com.sulake.habbo.inventory.items.FurnitureItem;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.communication.messages.parser.inventory.furni._SafeStr_66;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.habbo.inventory.effects.Effect;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsParser;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeAndPointLimit;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;
    import com.sulake.habbo.inventory.bots.BotsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotInventoryMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotRemovedFromInventoryParser;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotAddedToInventoryParser;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;

        public class IncomingMessages 
    {

        private static const GROUPED_FURNI_TYPE:String = "credit_groupitem_type_id";

        private var _inventory:HabboInventory;
        private var _com:IHabboCommunicationManager;
        private var _SafeStr_2777:Vector.<Map>;
        private var _SafeStr_2778:Vector.<Map>;
        private var _SafeStr_2779:Vector.<Map>;
        private var _SafeStr_1445:Vector.<Map>;
        private var _SafeStr_2780:int;

        public function IncomingMessages(_arg_1:HabboInventory)
        {
            _inventory = _arg_1;
            _com = _inventory.communication;
            _com.addHabboConnectionMessageEvent(new TradingAcceptEvent(onTradingAccepted, TradingAcceptParser));
            _com.addHabboConnectionMessageEvent(new TradingYouAreNotAllowedEvent(onTradingYouAreNotAllowed, TradingYouAreNotAllowedParser));
            _com.addHabboConnectionMessageEvent(new TradingConfirmationEvent(onTradingConfirmation, TradingConfirmationParser));
            _com.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(onAvatarEffectAdded));
            _com.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
            _com.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _com.addHabboConnectionMessageEvent(new MarketplaceConfigurationEvent(onMarketplaceConfiguration));
            _com.addHabboConnectionMessageEvent(new BotInventoryEvent(onBots));
            _com.addHabboConnectionMessageEvent(new FurniListInvalidateEvent(onFurniListInvalidate));
            _com.addHabboConnectionMessageEvent(new PostItPlacedEvent(onPostItPlaced));
            _com.addHabboConnectionMessageEvent(new AchievementsScoreEvent(onAchievementsScore));
            _com.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onClubStatus));
            _com.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(onAvatarEffectExpired));
            _com.addHabboConnectionMessageEvent(new MarketplaceItemStatsEvent(onMarketplaceItemStats));
            _com.addHabboConnectionMessageEvent(new TradingCompletedEvent(onTradingCompleted, TradingCompletedParser));
            _com.addHabboConnectionMessageEvent(new TradingItemListEvent(onTradingItemList, TradingItemListParser));
            _com.addHabboConnectionMessageEvent(new BadgeReceivedEvent(onBadgeReceived));
            _com.addHabboConnectionMessageEvent(new BadgePointLimitsEvent(onBadgePointLimits));
            _com.addHabboConnectionMessageEvent(new BotAddedToInventoryEvent(onBotAdded));
            _com.addHabboConnectionMessageEvent(new OpenConnectionMessageEvent(onRoomLeft));
            _com.addHabboConnectionMessageEvent(new AvatarEffectsMessageEvent(onAvatarEffects));
            _com.addHabboConnectionMessageEvent(new PetRemovedFromInventoryEvent(onPetRemoved));
            _com.addHabboConnectionMessageEvent(new TradingCloseEvent(onTradingClose, TradingCloseParser));
            _com.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomLeft));
            _com.addHabboConnectionMessageEvent(new NotEnoughBalanceMessageEvent(onNotEnoughCredits));
            _com.addHabboConnectionMessageEvent(new MarketplaceCanMakeOfferResult(onMarketplaceCanMakeOfferResult));
            _com.addHabboConnectionMessageEvent(new BadgesEvent(onBadges));
            _com.addHabboConnectionMessageEvent(new FurniListAddOrUpdateEvent(onFurnitureAddOrUpdate));
            _com.addHabboConnectionMessageEvent(new PetAddedToInventoryEvent(onPetAdded));
            _com.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(onAvatarEffectActivated));
            _com.addHabboConnectionMessageEvent(new FurniListRemoveEvent(onFurniListRemove));
            _com.addHabboConnectionMessageEvent(new TradingNotOpenEvent(onTradingNotOpen, TradingNotOpenParser));
            _com.addHabboConnectionMessageEvent(new PetInventoryEvent(onPets));
            _com.addHabboConnectionMessageEvent(new TradeOpenFailedEvent(onTradingOpenFailed, TradeOpenFailedParser));
            _com.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
            _com.addHabboConnectionMessageEvent(new FigureSetIdsEvent(onFigureSetIds));
            _com.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementReceived));
            _com.addHabboConnectionMessageEvent(new FurniListEvent(onFurniList));
            _com.addHabboConnectionMessageEvent(new TradingOpenEvent(onTradingOpen, TradingOpenParser));
            _com.addHabboConnectionMessageEvent(new HabboUserBadgesMessageEvent(onUserBadges));
            _com.addHabboConnectionMessageEvent(new BotRemovedFromInventoryEvent(onBotRemoved));
            _com.addHabboConnectionMessageEvent(new MarketplaceMakeOfferResult(onMarketplaceMakeOfferResult));
            _com.addHabboConnectionMessageEvent(new TradingOtherNotAllowedEvent(onTradingOtherNotAllowed, TradingOtherNotAllowedParser));
            _com.addHabboConnectionMessageEvent(new GoToBreedingNestFailureEvent(onGoToBreedingNestFailure));
        }

        public function dispose():void
        {
            _inventory = null;
            _com = null;
        }

        public function onFurniList(_arg_1:FurniListEvent):void
        {
            var _local_4:FurniListParser = _arg_1.getParser();
            if (_local_4 == null)
            {
                return;
            };
            if (!_inventory.isMainViewInitialized)
            {
                _inventory.initializeFurniturePage();
            };
            var _local_2:FurniModel = _inventory.furniModel;
            if (_local_2 == null)
            {
                return;
            };
            if (_SafeStr_2778 == null)
            {
                _SafeStr_2778 = new Vector.<Map>(_local_4.totalFragments, true);
            };
            var _local_5:Map = new Map();
            _local_5.concatenate(_local_4.furniFragment);
            var _local_3:Map = addMessageFragment(_local_5, _local_4.totalFragments, _local_4.fragmentNo, _SafeStr_2778);
            if (!_local_3)
            {
                return;
            };
            _local_2.insertFurniture(_local_3);
            _SafeStr_2778 = null;
            _inventory.events.dispatchEvent(new HabboInventoryFurniListParsedEvent("furni"));
        }

        public function onFurnitureAddOrUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:FurnitureItem;
            var _local_5:GroupItem;
            var _local_3:_SafeStr_66 = (_arg_1 as FurniListAddOrUpdateEvent).getParser();
            if (_local_3 == null)
            {
                return;
            };
            var _local_7:FurniModel = _inventory.furniModel;
            if (((_local_7 == null) || (!(_local_7.isListInited()))))
            {
                return;
            };
            var _local_6:Vector.<FurniData> = _local_3.getFurni();
            for each (var _local_4:FurniData in _local_6)
            {
                _local_5 = _local_7.getItemWithStripId(_local_4.itemId);
                if (_local_5)
                {
                    _local_2 = _local_5.getItem(_local_4.itemId);
                    if (_local_2)
                    {
                        _local_2.update(_local_4);
                        _local_5.hasUnseenItems = true;
                    };
                }
                else
                {
                    _local_2 = new FurnitureItem(_local_4);
                    _local_7.addOrUpdateItem(_local_2, false);
                };
            };
            _local_7.setViewToState();
            _local_7.updateView();
        }

        public function onFurniListRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:FurniListRemoveParser = (_arg_1 as FurniListRemoveEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_5:FurniModel = _inventory.furniModel;
            if (_local_5 == null)
            {
                return;
            };
            var _local_4:int = _local_2.stripId;
            var _local_3:GroupItem = _local_5.removeFurni(_local_4);
            if (_local_3)
            {
                _local_5.resetUnseenItems();
            };
        }

        public function onFurniListInvalidate(_arg_1:IMessageEvent):void
        {
            _inventory.setInventoryCategoryInit("furni", false);
            _inventory.setInventoryCategoryInit("rentables", false);
        }

        public function onPostItPlaced(_arg_1:IMessageEvent):void
        {
            var _local_2:PostItPlacedParser = (_arg_1 as PostItPlacedEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:FurniModel = _inventory.furniModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:int = _local_2.id;
            var _local_5:int = _local_2.itemsLeft;
            _local_3.updatePostItCount(_local_4, _local_5);
        }

        public function onAvatarEffects(_arg_1:IMessageEvent):void
        {
            var _local_5:int;
            var _local_4:AvatarEffect;
            var _local_7:Effect;
            if (_inventory == null)
            {
                return;
            };
            var _local_6:EffectsModel = _inventory.effectsModel;
            if (_local_6 == null)
            {
                return;
            };
            var _local_3:AvatarEffectsMessageParser = (_arg_1 as AvatarEffectsMessageEvent).getParser();
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:Array = _local_3.effects;
            _local_5 = 0;
            while (_local_5 < _local_2.length)
            {
                _local_4 = (_local_2[_local_5] as AvatarEffect);
                _local_7 = new Effect();
                _local_7.type = _local_4.type;
                _local_7.subType = _local_4.subType;
                _local_7.duration = _local_4.duration;
                _local_7.isPermanent = _local_4.isPermanent;
                _local_7.amountInInventory = _local_4.inactiveEffectsInInventory;
                if (_local_4.secondsLeftIfActive >= 0)
                {
                    _local_7.isActive = true;
                    _local_7.secondsLeft = _local_4.secondsLeftIfActive;
                    _local_7.amountInInventory++;
                }
                else
                {
                    if (_local_4.secondsLeftIfActive == -1)
                    {
                        _local_7.isActive = false;
                        _local_7.secondsLeft = _local_4.duration;
                    };
                };
                _local_6.addEffect(_local_7, false);
                _local_5++;
            };
            _inventory.setInventoryCategoryInit("effects");
            _local_6.refreshViews();
            _inventory.notifyChangedEffects();
        }

        public function onAvatarEffectAdded(_arg_1:IMessageEvent):void
        {
            var _local_5:EffectsModel = _inventory.effectsModel;
            if (_local_5 == null)
            {
                return;
            };
            var _local_2:AvatarEffectAddedMessageParser = (_arg_1 as AvatarEffectAddedMessageEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_7:int = _local_2.type;
            var _local_6:int = _local_2.subType;
            var _local_8:int = _local_2.duration;
            var _local_3:Boolean = _local_2.isPermanent;
            var _local_4:Effect = new Effect();
            _local_4.type = _local_7;
            _local_4.subType = _local_6;
            _local_4.duration = _local_8;
            _local_4.isPermanent = _local_3;
            _local_4.secondsLeft = _local_8;
            _local_5.addEffect(_local_4);
            _inventory.notifyChangedEffects();
        }

        public function onAvatarEffectActivated(_arg_1:IMessageEvent):void
        {
            var _local_3:EffectsModel = _inventory.effectsModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:AvatarEffectActivatedMessageParser = (_arg_1 as AvatarEffectActivatedMessageEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:int = _local_2.type;
            _local_3.setEffectActivated(_local_4);
            _inventory.notifyChangedEffects();
        }

        public function onAvatarEffectExpired(_arg_1:IMessageEvent):void
        {
            var _local_3:EffectsModel = _inventory.effectsModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:AvatarEffectExpiredMessageParser = (_arg_1 as AvatarEffectExpiredMessageEvent).getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:int = _local_2.type;
            _local_3.setEffectExpired(_local_4);
            _inventory.notifyChangedEffects();
        }

        public function onClubStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:ScrSendUserInfoMessageParser = (_arg_1 as ScrSendUserInfoEvent).getParser();
            if (((_local_2.productName == "habbo_club") || (_local_2.productName == "club_habbo")))
            {
                _inventory.setClubStatus(_local_2.periodsSubscribedAhead, _local_2.daysToPeriodEnd, _local_2.hasEverBeenMember, _local_2.isVIP, (_local_2.responseType == 3), (_local_2.responseType == 4), _local_2.minutesUntilExpiration, _local_2.minutesSinceLastModified);
                _inventory.events.dispatchEvent(new HabboInventoryHabboClubEvent());
            };
        }

        public function onBadges(_arg_1:IMessageEvent):void
        {
            var _local_3:BadgesParser = (_arg_1 as BadgesEvent).getParser();
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:BadgesModel = _inventory.badgesModel;
            if (_local_4 == null)
            {
                return;
            };
            if (_SafeStr_1445 == null)
            {
                _SafeStr_2780 = getTimer();
                _SafeStr_1445 = new Vector.<Map>(_local_3.totalFragments, true);
            };
            var _local_5:Map = new Map();
            _local_5.concatenate(_local_3.currentFragment);
            var _local_2:Map = addMessageFragment(_local_5, _local_3.totalFragments, _local_3.fragmentNo, _SafeStr_1445);
            if (!_local_2)
            {
                return;
            };
            _SafeStr_1445 = null;
            var _local_6:int = (getTimer() - _SafeStr_2780);
            _SafeStr_2780 = 0;
            Logger.log((("Parsing badges took: " + _local_6) + "ms"));
            _SafeStr_2780 = getTimer();
            _local_4.initBadges(_local_2);
            _local_6 = (getTimer() - _SafeStr_2780);
            _SafeStr_2780 = 0;
            Logger.log((("Initializing badges took: " + _local_6) + "ms"));
            _local_4.updateView();
            _inventory.setInventoryCategoryInit("badges");
        }

        public function onBadgePointLimits(_arg_1:IMessageEvent):void
        {
            var _local_2:BadgePointLimitsParser = (_arg_1 as BadgePointLimitsEvent).getParser();
            for each (var _local_3:BadgeAndPointLimit in _local_2.data)
            {
                _inventory.localization.setBadgePointLimit(_local_3.badgeId, _local_3.limit);
            };
        }

        public function onUserBadges(_arg_1:IMessageEvent):void
        {
            var _local_3:HabboUserBadgesMessageEvent = (_arg_1 as HabboUserBadgesMessageEvent);
            if (_local_3.userId != _inventory.sessionData.userId)
            {
                return;
            };
            var _local_4:BadgesModel = _inventory.badgesModel;
            if (_local_4 == null)
            {
                return;
            };
            _SafeStr_2780 = getTimer();
            for each (var _local_2:String in _local_3.badges)
            {
                _local_4.updateBadge(_local_2, true);
            };
            var _local_5:int = (getTimer() - _SafeStr_2780);
            _SafeStr_2780 = 0;
            Logger.log((((("Updating badges " + _local_3.badges.length) + "took: ") + _local_5) + "ms"));
            _SafeStr_2780 = getTimer();
            _local_4.updateView();
            _local_5 = (getTimer() - _SafeStr_2780);
            _SafeStr_2780 = 0;
            Logger.log((("Updating badge view took: " + _local_5) + "ms"));
        }

        public function onAchievementReceived(_arg_1:IMessageEvent):void
        {
            var _local_4:HabboAchievementNotificationMessageEvent = (_arg_1 as HabboAchievementNotificationMessageEvent);
            var _local_3:HabboAchievementNotificationMessageParser = _local_4.getParser();
            var _local_2:BadgesModel = _inventory.badgesModel;
            if (_local_2 != null)
            {
                _local_2.updateBadge(_local_3.data.badgeCode, false, _local_3.data.badgeId);
                _local_2.removeBadge(_local_3.data.removedBadgeCode);
                _local_2.updateView();
            };
        }

        public function onBadgeReceived(_arg_1:IMessageEvent):void
        {
            var _local_3:BadgeReceivedParser = BadgeReceivedEvent(_arg_1).getParser();
            var _local_2:BadgesModel = _inventory.badgesModel;
            if (_local_2 != null)
            {
                _local_2.updateBadge(_local_3.badgeCode, false, _local_3.badgeId);
                _local_2.updateView();
            };
        }

        public function onAchievementsScore(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementsScoreEvent = (_arg_1 as AchievementsScoreEvent);
            var _local_3:AchievementsScoreMessageParser = (_local_2.getParser() as AchievementsScoreMessageParser);
            if (_local_3 == null)
            {
                return;
            };
            _inventory.localization.registerParameter("achievements_score_description", "score", _local_3.score.toString());
        }

        private function onTradingOpen(_arg_1:IMessageEvent):void
        {
            var _local_13:int;
            if (!_inventory)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - inventory is null!");
                return;
            };
            var _local_2:ISessionDataManager = _inventory.sessionData;
            var _local_16:IRoomSession = _inventory.roomSession;
            if (!_local_2)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - sessionData not available!");
                return;
            };
            if (!_local_16)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - roomSession not available!");
                return;
            };
            _inventory.toggleInventorySubPage("trading");
            var _local_5:TradingOpenEvent = (_arg_1 as TradingOpenEvent);
            if (!_local_5)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", (("event is of unknown type:" + _arg_1) + "!"));
                return;
            };
            var _local_8:int = _local_5.userID;
            var _local_3:IUserData = _local_16.userDataManager.getUserData(_local_8);
            if (!_local_3)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve own user data!");
                return;
            };
            var _local_6:String = _local_3.name;
            var _local_4:Boolean = (_local_5.userCanTrade > 0);
            var _local_14:int = _local_5.otherUserID;
            var _local_15:IUserData = _local_16.userDataManager.getUserData(_local_14);
            if (!_local_15)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve other user data!");
                return;
            };
            var _local_11:String = _local_15.name;
            var _local_10:Boolean = (_local_5.otherUserCanTrade > 0);
            if (_local_14 == _local_2.userId)
            {
                _local_13 = _local_8;
                var _local_9:String = _local_6;
                var _local_7:Boolean = _local_4;
                _local_8 = _local_14;
                _local_6 = _local_11;
                _local_4 = _local_10;
                _local_4;
                _local_14 = _local_13;
                _local_11 = _local_9;
                _local_10 = _local_7;
                _local_10;
            };
            var _local_12:TradingModel = _inventory.tradingModel;
            if (_local_12 != null)
            {
                _local_12.startTrading(_local_8, _local_6, _local_4, _local_14, _local_11, _local_10);
            };
        }

        private function onTradingOpenFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingClose(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingCompleted(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingAccepted(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingConfirmation(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingItemList(_arg_1:IMessageEvent):void
        {
            var _local_8:GroupItem;
            var _local_2:TradingItemListEvent = (_arg_1 as TradingItemListEvent);
            var _local_4:Map = new Map();
            var _local_5:Map = new Map();
            var _local_6:int = _inventory.sessionData.userId;
            var _local_3:FurniModel = _inventory.furniModel;
            if (_local_3 == null)
            {
                return;
            };
            if (((_inventory.getBoolean("trading.warning.enabled")) && (_local_2.secondUserNumCredits > 0)))
            {
                _local_8 = _inventory.furniModel.createCreditGroupItem(_local_2.secondUserNumCredits);
                _local_5.add("credit_groupitem_type_id", _local_8);
            };
            populateItemGroups(_local_2.firstUserItemArray, _local_4, (_local_2.firstUserID == _local_6));
            populateItemGroups(_local_2.secondUserItemArray, _local_5, (_local_2.secondUserID == _local_6));
            var _local_7:TradingModel = _inventory.tradingModel;
            if (_local_7 != null)
            {
                _local_7.updateItemGroupMaps(_local_2, _local_4, _local_5);
            };
        }

        private function populateItemGroups(_arg_1:Array, _arg_2:Map, _arg_3:Boolean):void
        {
            var _local_9:GroupItem;
            var _local_7:int;
            var _local_8:int;
            var _local_5:String;
            var _local_4:ItemDataStructure;
            var _local_6:int;
            var _local_10:uint = _arg_1.length;
            _local_6 = 0;
            while (_local_6 < _local_10)
            {
                _local_4 = (_arg_1[_local_6] as ItemDataStructure);
                _local_7 = _local_4.itemTypeId;
                _local_8 = _local_4.category;
                _local_5 = (_local_4.itemType + _local_7);
                if (((!(_local_4.isGroupable)) || (isFurniExternalImage(_local_4.itemTypeId))))
                {
                    _local_5 = ("itemid" + _local_4.itemId);
                };
                if (_local_4.category == 6)
                {
                    _local_5 = ((_local_7 + "poster") + _local_4.stuffData.getLegacyString());
                }
                else
                {
                    if (_local_4.category == 17)
                    {
                        _local_5 = TradingModel.getGuildFurniType(_local_7, _local_4.stuffData);
                    };
                };
                _local_9 = (((_local_4.isGroupable) && (!(isFurniExternalImage(_local_4.itemTypeId)))) ? (_arg_2.getValue(_local_5) as GroupItem) : null);
                if (_local_9 == null)
                {
                    _local_9 = _inventory.furniModel.createGroupItem(_local_7, _local_8, _local_4.stuffData);
                    _arg_2.add(_local_5, _local_9);
                };
                _local_9.push(new FurnitureItem(_local_4));
                _local_6++;
            };
        }

        private function isFurniExternalImage(_arg_1:int):Boolean
        {
            var _local_2:IFurnitureData = _inventory.getFurnitureData(_arg_1, "i");
            return ((_local_2) && (_local_2.isExternalImageType));
        }

        private function onTradingNotOpen(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingOtherNotAllowed(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onTradingYouAreNotAllowed(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = _inventory.tradingModel;
            if (_local_2 != null)
            {
                _local_2.handleMessageEvent(_arg_1);
            };
        }

        private function onRoomLeft(_arg_1:IMessageEvent):void
        {
            _inventory.closeView();
            _inventory.furniModel.roomLeft();
        }

        private function onFlatAccessDenied(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatAccessDeniedMessageParser = (_arg_1 as FlatAccessDeniedMessageEvent).getParser();
            if (((_inventory.sessionData == null) || (!(_local_2.userName == _inventory.sessionData.userName))))
            {
                return;
            };
            _inventory.closeView();
            _inventory.furniModel.roomLeft();
        }

        private function onPets(_arg_1:PetInventoryEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_4:PetsModel = _inventory.petsModel;
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:PetInventoryMessageParser = _arg_1.getParser();
            if (_SafeStr_2777 == null)
            {
                _SafeStr_2777 = new Vector.<Map>(_local_3.totalFragments, true);
            };
            var _local_5:Map = new Map();
            _local_5.concatenate(_local_3.petListFragment);
            var _local_2:Map = addMessageFragment(_local_5, _local_3.totalFragments, _local_3.fragmentNo, _SafeStr_2777);
            if (!_local_2)
            {
                return;
            };
            _inventory.petsModel.updatePets(_local_2);
            _SafeStr_2777 = null;
        }

        private function onPetAdded(_arg_1:PetAddedToInventoryEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:PetsModel = _inventory.petsModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:PetAddedToInventoryParser = _arg_1.getParser();
            _local_3.addPet(_local_2.pet);
            if (_local_2.openInventory())
            {
            };
        }

        private function onGoToBreedingNestFailure(_arg_1:GoToBreedingNestFailureEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_2:String = "${gotobreedingnestfailure.getnest}";
            var _local_3:Function = getNest;
            if (_arg_1.getParser().reason == 6)
            {
                _local_2 = "${gotobreedingnestfailure.getfood}";
                _local_3 = getFood;
            };
            _inventory.windowManager.simpleAlert("${gotobreedingnestfailure.caption}", "${gotobreedingnestfailure.subtitle}", (("${gotobreedingnestfailure.message." + _arg_1.getParser().reason) + "}"), _local_2, "", null, null, _local_3);
        }

        private function getNest():void
        {
            var _local_1:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.nests");
            _inventory.catalog.openCatalogPage(_local_1);
        }

        private function getFood():void
        {
            var _local_1:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.food");
            _inventory.catalog.openCatalogPage(_local_1);
        }

        private function onPetRemoved(_arg_1:PetRemovedFromInventoryEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:PetsModel = _inventory.petsModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:PetRemovedFromInventoryParser = _arg_1.getParser();
            _local_3.removePet(_local_2.petId);
        }

        private function onBots(_arg_1:BotInventoryEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:BotsModel = _inventory.botsModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:BotInventoryMessageParser = _arg_1.getParser();
            _local_3.updateItems(_local_2.items);
            _inventory.setInventoryCategoryInit("bots");
            _local_3.setListInitialized();
        }

        private function onBotRemoved(_arg_1:BotRemovedFromInventoryEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:BotsModel = _inventory.botsModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:BotRemovedFromInventoryParser = _arg_1.getParser();
            _local_3.removeItem(_local_2.itemId);
        }

        private function onBotAdded(_arg_1:BotAddedToInventoryEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:BotsModel = _inventory.botsModel;
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.items.length >= _inventory.botsMax)
            {
                return;
            };
            var _local_2:BotAddedToInventoryParser = _arg_1.getParser();
            _local_3.addItem(_local_2.item);
        }

        private function onMarketplaceConfiguration(_arg_1:MarketplaceConfigurationEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_4:MarketplaceModel = _inventory.marketplaceModel;
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:MarketplaceConfigurationParser = _arg_1.getParser();
            _local_4.isEnabled = _local_3.isEnabled;
            _local_4.commission = _local_3.commission;
            _local_4.tokenBatchPrice = _local_3.tokenBatchPrice;
            _local_4.tokenBatchSize = _local_3.tokenBatchSize;
            _local_4.offerMinPrice = _local_3.offerMinPrice;
            _local_4.offerMaxPrice = _local_3.offerMaxPrice;
            _local_4.expirationHours = _local_3.expirationHours;
            _local_4.averagePricePeriod = _local_3.averagePricePeriod;
            _local_4.sellingFeePercentage = _local_3.sellingFeePercentage;
            _local_4.revenueLimit = _local_3.revenueLimit;
            _local_4.halfTaxLimit = _local_3.halfTaxLimit;
            _inventory.setInventoryCategoryInit("marketplace");
            var _local_2:FurniModel = _inventory.furniModel;
            if (_local_2 != null)
            {
                _local_2.updateView();
            };
        }

        private function onMarketplaceCanMakeOfferResult(_arg_1:MarketplaceCanMakeOfferResult):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:MarketplaceModel = _inventory.marketplaceModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:MarketplaceCanMakeOfferResultParser = _arg_1.getParser();
            _local_3.proceedOfferMaking(_local_2.resultCode, _local_2.tokenCount);
        }

        private function onMarketplaceMakeOfferResult(_arg_1:MarketplaceMakeOfferResult):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:MarketplaceModel = _inventory.marketplaceModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:MarketplaceMakeOfferResultParser = _arg_1.getParser();
            _local_3.endOfferMaking(_local_2.result);
        }

        private function onMarketplaceItemStats(_arg_1:MarketplaceItemStatsEvent):void
        {
            if (((_arg_1 == null) || (_inventory == null)))
            {
                return;
            };
            var _local_3:MarketplaceModel = _inventory.marketplaceModel;
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:MarketplaceItemStatsParser = _arg_1.getParser();
            _local_3.setAveragePrice(_local_2.furniCategoryId, _local_2.furniTypeId, _local_2.averagePrice);
        }

        private function onNotEnoughCredits(_arg_1:NotEnoughBalanceMessageEvent):void
        {
            if (((!(_arg_1)) || (!(_inventory))))
            {
                return;
            };
            var _local_2:MarketplaceModel = _inventory.marketplaceModel;
            if (_local_2 == null)
            {
                return;
            };
            _local_2.onNotEnoughCredits();
        }

        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:MarketplaceModel;
            if (_inventory.isInventoryCategoryInit("marketplace"))
            {
                _local_2 = _inventory.marketplaceModel;
                if (_local_2 == null)
                {
                    return;
                };
                _local_2.requestInitialization();
            };
        }

        private function onFigureSetIds(_arg_1:FigureSetIdsEvent):void
        {
            _inventory.updatePurchasedFigureSetIds(_arg_1.getParser().figureSetIds, _arg_1.getParser().boundFurnitureNames);
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            if (_inventory.getBoolean("effects.reactivate.on.room.entry"))
            {
                _inventory.effectsModel.reactivateLastEffect();
            };
            _inventory.furniModel.roomEntered();
        }

        private function addMessageFragment(_arg_1:Map, _arg_2:int, _arg_3:int, _arg_4:Vector.<Map>):Map
        {
            if (_arg_2 == 1)
            {
                return (_arg_1);
            };
            _arg_4[_arg_3] = _arg_1;
            for each (var _local_5:Map in _arg_4)
            {
                if (_local_5 == null)
                {
                    return (null);
                };
            };
            var _local_6:Map = new Map();
            for each (var _local_7:Map in _arg_4)
            {
                _local_6.concatenate(_local_7);
                _local_7.dispose();
            };
            _arg_4 = null;
            return (_local_6);
        }


    }
}


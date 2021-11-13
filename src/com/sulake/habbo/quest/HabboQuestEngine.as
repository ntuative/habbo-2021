package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.IHabboNewNavigator;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboNewNavigator;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_28;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_35;
    import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;

    public class HabboQuestEngine extends Component implements IHabboQuestEngine, IUpdateReceiver, ILinkEventTracker
    {

        private static const _SafeStr_3122:int = 5;
        private static const TWINKLE_ANIMATION_START_TIME:int = 800;
        private static const TWINKLE_ANIMATION_OBJECT_COUNT:int = 15;
        private static const DELAY_BETWEEN_TWINKLE_STARTS:int = 300;
        private static const _SafeStr_602:Array = ["MOVEITEM", "ENTEROTHERSROOM", "CHANGEFIGURE", "FINDLIFEGUARDTOWER", "SCRATCHAPET"];

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:ICoreConfiguration;
        private var _SafeStr_457:IncomingMessages;
        private var _questController:QuestController;
        private var _achievementController:AchievementController;
        private var _roomCompetitionController:RoomCompetitionController;
        private var _toolbar:IHabboToolbar;
        private var _catalog:IHabboCatalog;
        private var _navigator:IHabboNewNavigator;
        private var _notifications:IHabboNotifications;
        private var _sessionDataManager:ISessionDataManager;
        private var _habboHelp:IHabboHelp;
        private var _tracking:IHabboTracking;
        private var _SafeStr_601:TwinkleImages;
        private var _currentlyInRoom:Boolean = false;
        private var _roomEngine:IRoomEngine;
        private var _SafeStr_3123:Boolean = false;
        private var _achievementsResolutionController:AchievementsResolutionController;

        public function HabboQuestEngine(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _questController = new QuestController(this);
            _achievementController = new AchievementController(this);
            _achievementsResolutionController = new AchievementsResolutionController(this);
            _roomCompetitionController = new RoomCompetitionController(this);
            queueInterface(new IIDHabboCommunicationManager(), onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), onConfigurationReady);
            queueInterface(new IIDHabboToolbar(), onToolbarReady);
            queueInterface(new IIDHabboCatalog(), onCatalogReady);
            queueInterface(new IIDHabboNotifications(), onNotificationsReady);
            queueInterface(new IIDHabboHelp(), onHabboHelpReady);
            queueInterface(new IIDHabboNewNavigator(), onHabboNavigatorReady);
            queueInterface(new IIDSessionDataManager(), onSessionDataManagerReady);
            queueInterface(new IIDRoomEngine(), onRoomEngineReady);
            queueInterface(new IIDHabboTracking(), onTrackingReady);
            _arg_1.addLinkEventTracker(this);
            registerUpdateReceiver(this, 5);
        }

        public static function moveChildrenToRow(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            var _local_6:IWindow;
            for each (var _local_5:String in _arg_2)
            {
                _local_6 = _arg_1.getChildByName(_local_5);
                if (((!(_local_6 == null)) && (_local_6.visible)))
                {
                    _local_6.x = _arg_3;
                    _arg_3 = (_arg_3 + (_local_6.width + _arg_4));
                };
            };
        }


        override public function dispose():void
        {
            removeUpdateReceiver(this);
            context.removeLinkEventTracker(this);
            if (_toolbar)
            {
                _toolbar.release(new IIDHabboToolbar());
                _toolbar = null;
            };
            if (_catalog != null)
            {
                _catalog.release(new IIDHabboCatalog());
                _catalog = null;
            };
            if (_notifications != null)
            {
                _notifications.release(new IIDHabboNotifications());
                _notifications = null;
            };
            if (_windowManager != null)
            {
                _windowManager.release(new IIDHabboWindowManager());
                _windowManager = null;
            };
            if (_localization != null)
            {
                _localization.release(new IIDHabboLocalizationManager());
                _localization = null;
            };
            if (_configuration != null)
            {
                _configuration.release(new IIDHabboConfigurationManager());
                _configuration = null;
            };
            if (_communication != null)
            {
                _communication.release(new IIDHabboCommunicationManager());
                _communication = null;
            };
            if (_sessionDataManager != null)
            {
                _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", _achievementController.onBadgeImageReady);
                _sessionDataManager.release(new IIDSessionDataManager());
                _sessionDataManager = null;
            };
            if (_SafeStr_457)
            {
                _SafeStr_457.dispose();
            };
            if (_habboHelp != null)
            {
                _habboHelp.release(new IIDHabboHelp());
                _habboHelp = null;
            };
            if (_navigator != null)
            {
                _navigator.release(new IIDHabboNewNavigator());
                _navigator = null;
            };
            if (_tracking != null)
            {
                _tracking.release(new IIDHabboTracking());
                _tracking = null;
            };
            if (_SafeStr_601)
            {
                _SafeStr_601.dispose();
                _SafeStr_601 = null;
            };
            if (_roomEngine)
            {
                _roomEngine.release(new IIDRoomEngine());
                _roomEngine = null;
            };
            if (_achievementsResolutionController)
            {
                _achievementsResolutionController.dispose();
                _achievementsResolutionController = null;
            };
            super.dispose();
        }

        public function getXmlWindow(_arg_1:String, _arg_2:int=1):IWindow
        {
            var _local_5:IAsset;
            var _local_3:XmlAsset;
            var _local_4:IWindow;
            try
            {
                _local_5 = assets.getAssetByName(_arg_1);
                _local_3 = XmlAsset(_local_5);
                _local_4 = _windowManager.buildFromXML(XML(_local_3.content), _arg_2);
            }
            catch(e:Error)
            {
            };
            return (_local_4);
        }

        private function onCommunicationComponentInit(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _communication = IHabboCommunicationManager(_arg_2);
            _SafeStr_457 = new IncomingMessages(this);
        }

        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _windowManager = IHabboWindowManager(_arg_2);
        }

        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _localization = IHabboLocalizationManager(_arg_2);
        }

        private function onConfigurationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            _configuration = (_arg_2 as ICoreConfiguration);
        }

        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _catalog = (_arg_2 as IHabboCatalog);
        }

        private function onNotificationsReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _notifications = (_arg_2 as IHabboNotifications);
        }

        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _sessionDataManager = (_arg_2 as ISessionDataManager);
            _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY", _achievementController.onBadgeImageReady);
        }

        private function onHabboHelpReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _habboHelp = (_arg_2 as IHabboHelp);
        }

        private function onHabboNavigatorReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _navigator = (_arg_2 as IHabboNewNavigator);
        }

        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _roomEngine = (_arg_2 as IRoomEngine);
        }

        private function onTrackingReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _tracking = (_arg_2 as IHabboTracking);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get questController():QuestController
        {
            return (_questController);
        }

        public function get roomCompetitionController():RoomCompetitionController
        {
            return (_roomCompetitionController);
        }

        public function get achievementController():AchievementController
        {
            return (_achievementController);
        }

        public function get achievementsResolutionController():AchievementsResolutionController
        {
            return (_achievementsResolutionController);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get tracking():IHabboTracking
        {
            return (_tracking);
        }

        public function openCatalog(_arg_1:QuestMessageData):void
        {
            var _local_2:String = _arg_1.catalogPageName;
            if (_local_2 != "")
            {
                Logger.log(("Questing->Open Catalog: " + _local_2));
                _catalog.openCatalogPage(_local_2);
            }
            else
            {
                Logger.log("Questing->Open Catalog: Quest Catalog page name not defined");
                _catalog.openCatalog();
            };
        }

        public function openNavigator(_arg_1:QuestMessageData):void
        {
            var _local_3:String;
            var _local_2:Boolean = hasLocalizedValue((_arg_1.getQuestLocalizationKey() + ".searchtag"));
            if (_local_2)
            {
                _local_3 = (_arg_1.getQuestLocalizationKey() + ".searchtag");
            }
            else
            {
                _local_3 = (_arg_1.getCampaignLocalizationKey() + ".searchtag");
            };
            var _local_4:String = _localization.getLocalization(_local_3);
            Logger.log(("Questing->Open Navigator: " + _local_4));
            _navigator.performTagSearch(_local_4);
        }

        public function hasQuestRoomsIds():Boolean
        {
            var _local_1:String = getQuestRoomIds();
            return ((!(_local_1 == null)) && (!(_local_1 == "")));
        }

        private function getQuestRoomIds():String
        {
            return (_localization.getLocalization((("quests." + getSeasonalCampaignCodePrefix()) + ".roomids")));
        }

        public function goToQuestRooms():void
        {
            if (!hasQuestRoomsIds())
            {
                return;
            };
            var _local_4:String = getQuestRoomIds();
            var _local_2:Array = _local_4.split(",");
            if (_local_2.length == 0)
            {
                return;
            };
            var _local_3:int = Math.max(0, Math.min((_local_2.length - 1), Math.floor((Math.random() * _local_2.length))));
            var _local_1:String = _local_2[_local_3];
            var _local_5:int = int(_local_1);
            Logger.log(("Forwarding to a guest room: " + _local_5));
            _navigator.goToRoom(_local_5);
        }

        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _toolbar = (IHabboToolbar(_arg_2) as IHabboToolbar);
            _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onHabboToolbarEvent);
        }

        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == "HTE_TOOLBAR_CLICK")
            {
                if (_arg_1.iconId == "HTIE_ICON_QUESTS")
                {
                    _questController.onToolbarClick();
                };
                if (_arg_1.iconId == "HTIE_ICON_ACHIEVEMENTS")
                {
                    _achievementController.onToolbarClick();
                };
            };
        }

        public function ensureAchievementsInitialized():void
        {
            if (_achievementController != null)
            {
                _achievementController.ensureAchievementsInitialized();
            };
        }

        public function showAchievements():void
        {
            if (_achievementController != null)
            {
                _achievementController.show();
            };
        }

        public function showQuests():void
        {
        }

        public function getAchievementLevel(_arg_1:String, _arg_2:String):int
        {
            if (_achievementController != null)
            {
                return (_achievementController.getAchievementLevel(_arg_1, _arg_2));
            };
            return (0);
        }

        public function reenableRoomCompetitionWindow():void
        {
            _roomCompetitionController.dontShowAgain = false;
        }

        public function get notifications():IHabboNotifications
        {
            return (_notifications);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function send(_arg_1:IMessageComposer):void
        {
            communication.connection.send(_arg_1);
        }

        public function isTrackerVisible():Boolean
        {
            return (_questController.questTracker.isVisible());
        }

        public function getQuestRowTitle(_arg_1:QuestMessageData):String
        {
            var _local_2:String = ((_arg_1.waitPeriodSeconds < 1) ? (_arg_1.getQuestLocalizationKey() + ".name") : "quests.list.questdelayed");
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function getQuestName(_arg_1:QuestMessageData):String
        {
            var _local_2:String = (_arg_1.getQuestLocalizationKey() + ".name");
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function getQuestDesc(_arg_1:QuestMessageData):String
        {
            var _local_2:String = (_arg_1.getQuestLocalizationKey() + ".desc");
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function getQuestHint(_arg_1:QuestMessageData):String
        {
            var _local_2:String = (_arg_1.getQuestLocalizationKey() + ".hint");
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function getActivityPointName(_arg_1:int):String
        {
            var _local_2:String = ("achievements.activitypoint." + _arg_1);
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function getCampaignNameByCode(_arg_1:String):String
        {
            var _local_2:String = (_arg_1 + ".name");
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function getCampaignName(_arg_1:QuestMessageData):String
        {
            return (getCampaignNameByCode(_arg_1.getCampaignLocalizationKey()));
        }

        public function getAchievementCategoryName(_arg_1:String):String
        {
            var _local_2:String = (("quests." + _arg_1) + ".name");
            return (_localization.getLocalization(_local_2, _local_2));
        }

        public function setupQuestImage(_arg_1:IWindowContainer, _arg_2:QuestMessageData):void
        {
            var _local_3:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("quest_pic_bitmap") as IStaticBitmapWrapperWindow);
            var _local_4:String = ((_arg_2.waitPeriodSeconds > 0) ? "quest_timer_questionmark" : ((((_arg_2.campaignCode + "_") + _arg_2.localizationCode) + _arg_2.imageVersion) + ((isQuestWithPrompts(_arg_2)) ? "_a" : "")).toLowerCase());
            _local_3.assetUri = (("${image.library.questing.url}" + _local_4) + ".png");
        }

        public function setupPromptFrameImage(_arg_1:IWindowContainer, _arg_2:QuestMessageData, _arg_3:String):void
        {
            var _local_4:IStaticBitmapWrapperWindow = (_arg_1.findChildByName(("prompt_pic_" + _arg_3)) as IStaticBitmapWrapperWindow);
            _local_4.assetUri = (("${image.library.questing.url}" + (((((_arg_2.campaignCode + "_") + _arg_2.localizationCode) + _arg_2.imageVersion) + "_") + _arg_3).toLowerCase()) + ".png");
        }

        public function setupRewardImage(_arg_1:IWindowContainer, _arg_2:int):void
        {
            var _local_3:IWindow = _arg_1.findChildByName("currency_icon");
            _local_3.style = _SafeStr_139.getIconStyleFor(_arg_2, this, true);
        }

        public function setupCampaignImage(_arg_1:IWindowContainer, _arg_2:QuestMessageData, _arg_3:Boolean):void
        {
            var _local_4:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("campaign_pic_bitmap") as IStaticBitmapWrapperWindow);
            if (!_arg_3)
            {
                _local_4.visible = false;
                return;
            };
            _local_4.visible = true;
            var _local_5:String = _arg_2.campaignCode;
            if (isSeasonalQuest(_arg_2))
            {
                _local_5 = (getSeasonalCampaignCodePrefix() + "_campaign_icon");
            };
            _local_4.assetUri = (("${image.library.questing.url}" + _local_5) + ".png");
        }

        public function setupAchievementCategoryImage(_arg_1:IWindowContainer, _arg_2:AchievementCategory, _arg_3:Boolean):void
        {
            var _local_4:IStaticBitmapWrapperWindow = (_arg_1.findChildByName("category_pic_bitmap") as IStaticBitmapWrapperWindow);
            _local_4.assetUri = (("${image.library.questing.url}" + ((_arg_3) ? ("ach_category_" + _arg_2.code) : ("achicon_" + _arg_2.code))) + ".png");
        }

        public function isQuestWithPrompts(_arg_1:QuestMessageData):Boolean
        {
            return (_SafeStr_602.indexOf(_arg_1.localizationCode) > -1);
        }

        public function refreshReward(_arg_1:Boolean, _arg_2:IWindowContainer, _arg_3:int, _arg_4:int):void
        {
            _arg_1 = (((_arg_3 < 0) || (_arg_4 < 1)) ? false : _arg_1);
            var _local_5:IWindow = _arg_2.findChildByName("reward_caption_txt");
            var _local_6:IWindow = _arg_2.findChildByName("reward_amount_txt");
            var _local_7:IWindow = _arg_2.findChildByName("currency_icon");
            _local_6.visible = _arg_1;
            _local_5.visible = _arg_1;
            _local_7.visible = _arg_1;
            if (!_arg_1)
            {
                return;
            };
            _local_6.caption = ("" + _arg_4);
            moveChildrenToRow(_arg_2, ["reward_caption_txt", "reward_amount_txt", "currency_icon"], _local_5.x, 3);
            this.setupRewardImage(_arg_2, _arg_3);
        }

        public function update(_arg_1:uint):void
        {
            _questController.update(_arg_1);
            _achievementController.update(_arg_1);
        }

        public function getTwinkleAnimation(_arg_1:IWindowContainer):Animation
        {
            var _local_3:int;
            if (_SafeStr_601 == null)
            {
                _SafeStr_601 = new TwinkleImages(this);
            };
            var _local_4:int = 800;
            var _local_2:Animation = new Animation(IBitmapWrapperWindow(_arg_1.findChildByName("twinkle_bitmap")));
            _local_3 = 0;
            while (_local_3 < 15)
            {
                _local_2.addObject(new Twinkle(_SafeStr_601, _local_4));
                _local_4 = (_local_4 + 300);
                _local_3++;
            };
            return (_local_2);
        }

        public function get currentlyInRoom():Boolean
        {
            return (_currentlyInRoom);
        }

        public function set currentlyInRoom(_arg_1:Boolean):void
        {
            _currentlyInRoom = _arg_1;
        }

        public function isSeasonalCalendarEnabled():Boolean
        {
            return (_configuration.getBoolean("seasonalQuestCalendar.enabled"));
        }

        public function isSeasonalQuest(_arg_1:QuestMessageData):Boolean
        {
            var _local_2:String = getSeasonalCampaignCodePrefix();
            return ((!(_local_2 == "")) && (_arg_1.campaignCode.indexOf(_local_2) == 0));
        }

        public function getSeasonalCampaignCodePrefix():String
        {
            return (getProperty("seasonalQuestCalendar.campaignPrefix"));
        }

        public function setIsFirstLoginOfDay(_arg_1:Boolean):void
        {
            this._SafeStr_3123 = _arg_1;
        }

        public function get isFirstLoginOfDay():Boolean
        {
            return (this._SafeStr_3123);
        }

        public function get configuration():ICoreConfiguration
        {
            return (_configuration);
        }

        public function hasLocalizedValue(_arg_1:String):Boolean
        {
            return (!(_localization.getLocalization(_arg_1, "") == ""));
        }

        public function get navigator():IHabboNewNavigator
        {
            return (_navigator);
        }

        public function requestSeasonalQuests():void
        {
            send(new _SafeStr_28());
        }

        public function requestQuests():void
        {
            send(new _SafeStr_35());
        }

        public function activateQuest(_arg_1:int):void
        {
            send(new ActivateQuestMessageComposer(_arg_1));
        }

        public function get linkPattern():String
        {
            return ("questengine/");
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
                case "gotorooms":
                    goToQuestRooms();
                    return;
                case "achievements":
                    if (_local_2.length == 3)
                    {
                        _achievementController.show();
                        _achievementController.selectCategoryInternalLink(_local_2[2]);
                    }
                    else
                    {
                        showAchievements();
                    };
                    return;
                case "calendar":
                    _questController.seasonalCalendarWindow.onToolbarClick();
                    return;
                case "quests":
                    _questController.onToolbarClick();
                    return;
                default:
                    Logger.log(("QuestEngine unknown link-type received: " + _local_2[1]));
                    return;
            };
        }


    }
}
package com.sulake.habbo.catalog.clubcenter
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.catalog.offers.IOfferExtension;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.offers.IOfferCenter;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendKickbackInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEvent;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageParser;
    import flash.utils.getTimer;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
    import com.sulake.habbo.catalog.clubcenter.util.BadgeResolver;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog._SafeStr_41;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetKickbackInfoMessageComposer;
    import com.sulake.habbo.catalog.purse.IPurse;
    import flash.display.Stage;

    public class HabboClubCenter extends Component implements ILinkEventTracker, IOfferExtension 
    {

        private static const USE_FAKE_DATA:Boolean = false;
        private static const DATA_UPDATE_INTERVAL_MSEC:int = 10000;

        private var _communicationManager:IHabboCommunicationManager;
        private var _localizationManager:IHabboLocalizationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _windowManager:IHabboWindowManager;
        private var _catalog:IHabboCatalog;
        private var _toolbar:IHabboToolbar;
        private var _offerCenter:IOfferCenter;
        private var _SafeStr_1439:Boolean = false;
        private var _messageEvents:Vector.<IMessageEvent>;
        private var _SafeStr_570:ClubCenterView;
        private var _SafeStr_1440:ClubSpecialInfoBubbleView;
        private var _SafeStr_690:ScrKickbackData;
        private var _SafeStr_1441:int = -10000;
        private var _SafeStr_1442:Boolean = false;
        private var _SafeStr_1443:String;
        private var _SafeStr_1444:int;
        private var _SafeStr_1445:Vector.<Map>;

        public function HabboClubCenter(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }, true), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderManager = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
            addMessageEvent(new ScrSendKickbackInfoMessageEvent(onKickbackInfoMessageEvent));
            addMessageEvent(new BadgesEvent(onBadges));
            context.addLinkEventTracker(this);
            if (((getBoolean("offers.enabled")) && (getBoolean("offers.habboclub.enabled"))))
            {
                _offerCenter = catalog.getOfferCenter(this);
            };
        }

        override public function dispose():void
        {
            if (((!(_messageEvents == null)) && (!(_communicationManager == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communicationManager.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            if (((!(_sessionDataManager == null)) && (_sessionDataManager.events)))
            {
                _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", onBadgeReady);
            };
            if (_offerCenter != null)
            {
                _offerCenter = null;
            };
            removeView();
            _SafeStr_690 = null;
            _messageEvents = null;
            super.dispose();
        }

        public function get linkPattern():String
        {
            return ("habboUI/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 3)
            {
                return;
            };
            if (_local_2[1] == "open")
            {
                switch (_local_2[2])
                {
                    case "hccenter":
                        showClubCenter();
                        return;
                };
            };
        }

        private function showClubCenter():void
        {
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new ClubCenterView(this, _windowManager, _sessionDataManager.figure);
            };
            if (updateNeeded())
            {
                updateData();
            }
            else
            {
                populate();
            };
            if ((((_offerCenter) && (_SafeStr_570)) && (_SafeStr_1439)))
            {
                _SafeStr_1439 = false;
                indicateVideoAvailable(true);
            };
        }

        public function removeView():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            removeBreakdown();
            _SafeStr_1442 = false;
        }

        public function removeBreakdown():void
        {
            if (_SafeStr_1440)
            {
                _SafeStr_1440.dispose();
                _SafeStr_1440 = null;
            };
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            if (!_communicationManager)
            {
                return;
            };
            _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(_arg_1));
        }

        private function onKickbackInfoMessageEvent(_arg_1:ScrSendKickbackInfoMessageEvent):void
        {
            var _local_2:ScrSendKickbackInfoMessageParser = _arg_1.getParser();
            _SafeStr_690 = _local_2.data;
            _SafeStr_1442 = false;
            _SafeStr_1441 = getTimer();
            populate();
        }

        private function onClubGiftInfo(_arg_1:ClubGiftInfoEvent):void
        {
            _SafeStr_1444 = _arg_1.getParser().giftsAvailable;
            populate();
        }

        private function onBadgeReady(_arg_1:BadgeImageReadyEvent):void
        {
            if (((!(_arg_1.badgeId == _SafeStr_1443)) || (!(_sessionDataManager))))
            {
                return;
            };
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", onBadgeReady);
            populate();
        }

        public function onBadges(_arg_1:IMessageEvent):void
        {
            var _local_3:BadgesParser = (_arg_1 as BadgesEvent).getParser();
            if (_SafeStr_1445 == null)
            {
                _SafeStr_1445 = new Vector.<Map>(_local_3.totalFragments, true);
            };
            var _local_4:Map = new Map();
            _local_4.concatenate(_local_3.currentFragment);
            var _local_2:Map = addMessageFragment(_local_4, _local_3.totalFragments, _local_3.fragmentNo, _SafeStr_1445);
            if (!_local_2)
            {
                return;
            };
            _SafeStr_1445 = null;
            _SafeStr_1443 = BadgeResolver.resolveClubBadgeId(_local_2.getKeys());
        }

        private function updateNeeded():Boolean
        {
            return ((!(_SafeStr_1442)) && ((getTimer() - _SafeStr_1441) > 10000));
        }

        private function updateData():void
        {
            _SafeStr_1442 = true;
            _communicationManager.connection.send(new GetBadgesComposer());
            _communicationManager.connection.send(new _SafeStr_41());
            _communicationManager.connection.send(new ScrGetKickbackInfoMessageComposer());
            return;
            _SafeStr_690 = new ScrKickbackData();
            populate();
        }

        private function populate():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.dataReceived(_SafeStr_690, getPurse(), getGiftsAvailable(), BadgeResolver.resolveBadgeBitmap(_SafeStr_1443, onBadgeReady, _sessionDataManager));
            };
        }

        private function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        private function getPurse():IPurse
        {
            return ((catalog != null) ? catalog.getPurse() : null);
        }

        private function getGiftsAvailable():int
        {
            return (_SafeStr_1444);
        }

        public function get localization():IHabboLocalizationManager
        {
            return ((catalog != null) ? catalog.localization : null);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (_avatarRenderManager);
        }

        public function resolveClubStatus():String
        {
            if (!catalog)
            {
                return ("none");
            };
            var _local_1:IPurse = getPurse();
            if (_local_1.clubDays > 0)
            {
                return ("active");
            };
            if (((_local_1.pastClubDays > 0) || (_local_1.pastVipDays > 0)))
            {
                return ("expired");
            };
            return ("none");
        }

        public function openPurchasePage():void
        {
            if (catalog)
            {
                catalog.openCatalogPage("hc_membership", "NORMAL");
            };
        }

        public function openClubGiftPage():void
        {
            if (catalog)
            {
                catalog.openCatalogPage("club_gifts", "NORMAL");
            };
        }

        public function showPaydayBreakdownView():void
        {
            if (_SafeStr_1440)
            {
                removeBreakdown();
                return;
            };
            _SafeStr_1440 = new ClubSpecialInfoBubbleView(this, _windowManager, _SafeStr_690, _SafeStr_570.getSpecialCalloutAnchor());
        }

        public function openPaydayHelpPage():void
        {
            context.createLinkEvent("habbopages/hcpayday");
        }

        public function openHelpPage():void
        {
            context.createLinkEvent("habbopages/habboclub");
        }

        public function processHotelLink(_arg_1:String):void
        {
            context.createLinkEvent(_arg_1);
        }

        public function isKickbackEnabled():Boolean
        {
            var _local_1:String = getProperty("hccenter.activity.enabled");
            if (((_local_1 == null) || (_local_1 == "")))
            {
                return (true);
            };
            return ((_local_1 == "1") || (_local_1 == "true"));
        }

        public function get stage():Stage
        {
            return (((context) && (context.displayObjectContainer)) ? context.displayObjectContainer.stage : null);
        }

        public function getOffers():void
        {
            _catalog.getHabboClubOffers(3);
        }

        public function get offerCenter():IOfferCenter
        {
            return (_offerCenter);
        }

        public function indicateRewards():void
        {
        }

        public function indicateVideoAvailable(_arg_1:Boolean):void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.setVideoOfferButtonVisibility(_arg_1, ((!(_offerCenter == null)) && (!(_offerCenter.showingVideo))));
            }
            else
            {
                _SafeStr_1439 = _arg_1;
            };
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


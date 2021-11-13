package com.sulake.habbo.tracking
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.room.IRoomEngine;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.system.Capabilities;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageEvent;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import com.sulake.core.runtime.events.ErrorEvent;
    import com.sulake.core.runtime.exceptions.Exception;
    import flash.system.System;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.iid.*;

    public class HabboTracking extends Component implements IHabboTracking, IUpdateReceiver
    {

        private static const ERROR_DATA_FLAG_COUNT:uint = 11;

        private static var _SafeStr_480:HabboTracking;

        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_481:Array;
        private var _SafeStr_238:Boolean = false;
        private var _messageEvents:Vector.<IMessageEvent>;
        private var _SafeStr_484:PerformanceTracker = null;
        private var _SafeStr_486:FramerateTracker = null;
        private var _SafeStr_482:LatencyTracker = null;
        private var _SafeStr_490:LagWarningLogger = null;
        private var _SafeStr_489:ToolbarClickTracker = null;
        private var _roomEngine:IRoomEngine = null;
        private var _SafeStr_485:Boolean = false;
        private var _currentTime:int = -1;
        private var _SafeStr_491:int = 0;
        private var _SafeStr_492:int = 0;
        private var _SafeStr_483:Timer;
        private var _SafeStr_488:int = 0;
        private var _SafeStr_487:int = -1;
        private var onceTrackedEvents:Vector.<String> = new Vector.<String>(0);

        public function HabboTracking(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            var _local_5:uint;
            if (_SafeStr_480 == null)
            {
                _SafeStr_480 = this;
            };
            _SafeStr_481 = new Array(11);
            _local_5 = 0;
            while (_local_5 < 11)
            {
                _SafeStr_481[_local_5] = 0;
                _local_5++;
            };
            super(_arg_1, _arg_2, _arg_3);
            var _local_6:String = "WIN63-202111081545-75921380";
            var _local_4:IContext = _arg_1.root;
            if (_local_4 != null)
            {
                _local_4.events.addEventListener("COMPONENT_EVENT_ERROR", onError);
                ErrorReportStorage.setParameter("start_time", new Date().getTime().toString());
                ErrorReportStorage.setParameter("agent", _local_6);
                ErrorReportStorage.setParameter("system", Capabilities.serverString);
                ErrorReportStorage.setParameter("in_room", "false");
                ErrorReportStorage.setParameter("last_room", "0");
            };
            registerUpdateReceiver(this, 1);
        }

        public static function getInstance():HabboTracking
        {
            return (_SafeStr_480);
        }


        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboConfigurationManager(), function (_arg_1:ICoreConfiguration):void
            {
                if (_arg_1 != null)
                {
                    setErrorContextFlag(1, 0);
                };
            }, false, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }]), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                if (_arg_1 != null)
                {
                    setErrorContextFlag(1, 1);
                };
            }, false), new ComponentDependency(new IIDHabboWindowManager(), null, false, [{
                "type":"HABBO_WINDOW_TRACKING_EVENT_INPUT",
                "callback":onWindowTrackingEvent
            }, {
                "type":"HABBO_WINDOW_TRACKING_EVENT_RENDER",
                "callback":onWindowTrackingEvent
            }, {
                "type":"HABBO_WINDOW_TRACKING_EVENT_SLEEP",
                "callback":onWindowTrackingEvent
            }]), new ComponentDependency(new IIDHabboNavigator(), null, false, [{
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_ME",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH",
                "callback":onNavigatorTrackingEvent
            }, {
                "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED",
                "callback":onRoomSettingsTrackingEvent
            }, {
                "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT",
                "callback":onRoomSettingsTrackingEvent
            }, {
                "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED",
                "callback":onRoomSettingsTrackingEvent
            }, {
                "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS",
                "callback":onRoomSettingsTrackingEvent
            }, {
                "type":"HTIE_ICON_ZOOM",
                "callback":onZoomToggle
            }]), new ComponentDependency(new IIDHabboCatalog(), null, false, [{
                "type":"CATALOG_PAGE_OPENED",
                "callback":onCatalogPageOpened
            }, {
                "type":"HABBO_CATALOG_TRACKING_EVENT_OPEN",
                "callback":onCatalogTrackingEvent
            }, {
                "type":"HABBO_CATALOG_TRACKING_EVENT_CLOSE",
                "callback":onCatalogTrackingEvent
            }, {
                "type":"CATALOG_FURNI_PURCHASE",
                "callback":onCatalogTrackingEvent
            }]), new ComponentDependency(new IIDHabboInventory(), null, false, [{
                "type":"HABBO_INVENTORY_TRACKING_EVENT_CLOSED",
                "callback":onInventoryTrackingEvent
            }, {
                "type":"HABBO_INVENTORY_TRACKING_EVENT_FURNI",
                "callback":onInventoryTrackingEvent
            }, {
                "type":"HABBO_INVENTORY_TRACKING_EVENT_POSTERS",
                "callback":onInventoryTrackingEvent
            }, {
                "type":"HABBO_INVENTORY_TRACKING_EVENT_BADGES",
                "callback":onInventoryTrackingEvent
            }, {
                "type":"HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS",
                "callback":onInventoryTrackingEvent
            }, {
                "type":"HABBO_INVENTORY_TRACKING_EVENT_TRADING",
                "callback":onInventoryTrackingEvent
            }]), new ComponentDependency(new IIDHabboFriendList(), null, false, [{
                "type":"HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED",
                "callback":onFriendlistTrackingEvent
            }, {
                "type":"HABBO_FRIENDLIST_TRACKING_EVENT_FRIENDS",
                "callback":onFriendlistTrackingEvent
            }, {
                "type":"HABBO_FRIENDLIST_TRACKING_EVENT_SEARCH",
                "callback":onFriendlistTrackingEvent
            }, {
                "type":"HABBO_FRIENDLIST_TRACKING_EVENT_REQUEST",
                "callback":onFriendlistTrackingEvent
            }, {
                "type":"HABBO_FRIENDLIST_TRACKING_EVENT_MINIMZED",
                "callback":onFriendlistTrackingEvent
            }]), new ComponentDependency(new IIDHabboHelp(), null, false, [{
                "type":"HABBO_HELP_TRACKING_EVENT_CLOSED",
                "callback":onHelpTrackingEvent
            }, {
                "type":"HABBO_HELP_TRACKING_EVENT_DEFAULT",
                "callback":onHelpTrackingEvent
            }]), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, false, [{
                "type":"RORAE_ROOM_AD_FURNI_CLICK",
                "callback":onRoomAdClick
            }, {
                "type":"REE_INITIALIZED",
                "callback":onRoomAction
            }, {
                "type":"REE_DISPOSED",
                "callback":onRoomAction
            }]), new ComponentDependency(new IIDHabboAdManager(), null, false, [{
                "type":"AE_ROOM_AD_SHOW",
                "callback":onRoomAdLoad
            }]), new ComponentDependency(new IIDHabboToolbar(), null, false, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":onToolbarClick
            }])]));
        }

        override protected function initComponent():void
        {
            _SafeStr_482 = new LatencyTracker(this);
            _SafeStr_484 = new PerformanceTracker(this);
            _SafeStr_486 = new FramerateTracker(this);
            _SafeStr_490 = new LagWarningLogger(this);
            _SafeStr_489 = new ToolbarClickTracker(this);
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new AuthenticationOKMessageEvent(onAuthOK));
            addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            addMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementNotification));
            addMessageEvent(new LatencyPingResponseMessageEvent(onPingResponse));
            var _local_1:IEventDispatcher = Component(context).events;
            _local_1.addEventListener("HABBO_CONNECTION_EVENT_INIT", onConnectionEvent);
            _local_1.addEventListener("HABBO_CONNECTION_EVENT_ESTABLISHED", onConnectionEvent);
            _local_1.addEventListener("HABBO_CONNECTION_EVENT_HANDSHAKING", onConnectionEvent);
            _local_1.addEventListener("HABBO_CONNECTION_EVENT_HANDSHAKED", onConnectionEvent);
            _local_1.addEventListener("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL", onConnectionEvent);
            _local_1.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED", onConnectionEvent);
            _local_1.addEventListener("HHVE_START_LOAD", onHotelViewEvent);
            _local_1.addEventListener("HHVE_ERROR", onHotelViewEvent);
            _local_1.addEventListener("HHVE_LOADED", onHotelViewEvent);
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            _messageEvents.push(_communication.addHabboConnectionMessageEvent(_arg_1));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_480 == this)
            {
                _SafeStr_480 = null;
            };
            removeUpdateReceiver(this);
            if (((!(_messageEvents == null)) && (!(_communication == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communication.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            _SafeStr_484 = null;
            _SafeStr_486 = null;
            _SafeStr_489 = null;
            if (_SafeStr_482 != null)
            {
                _SafeStr_482.dispose();
                _SafeStr_482 = null;
            };
            if (_SafeStr_483)
            {
                _SafeStr_483.stop();
                _SafeStr_483.removeEventListener("timer", onRoomActionTimerEvent);
                _SafeStr_483 = null;
            };
            super.dispose();
        }

        private function setErrorContextFlag(_arg_1:uint, _arg_2:uint):void
        {
            _SafeStr_481[_arg_2] = _arg_1;
        }

        private function onHotelViewEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HHVE_START_LOAD":
                    trackLoginStep("client.init.hotelview.start");
                    return;
                case "HHVE_LOADED":
                    trackLoginStep("client.init.hotelview.ok");
                    return;
                case "HHVE_ERROR":
                    trackLoginStep("client.init.hotelview.fail");
                    return;
            };
        }

        private function onConnectionEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_CONNECTION_EVENT_INIT":
                    trackLoginStep("client.init.socket.init");
                    break;
                case "HABBO_CONNECTION_EVENT_ESTABLISHED":
                    trackLoginStep("client.init.socket.ok", String(_communication.port));
                    break;
                case "HABBO_CONNECTION_EVENT_HANDSHAKING":
                    trackLoginStep("client.init.handshake.start");
                    break;
                case "HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL":
                    trackLoginStep("client.init.handshake.fail");
                    break;
                case "HABBO_CONNECTION_EVENT_HANDSHAKED":
                    setErrorContextFlag(2, 0);
                    trackLoginStep("client.init.handshake.ok");
                    break;
                case "HABBO_CONNECTION_EVENT_AUTHENTICATED":
                    setErrorContextFlag(3, 0);
                    loadConversionTrackingFrame();
                    trackLoginStep("client.init.auth.ok");
            };
            Component(context).events.removeEventListener(_arg_1.type, onConnectionEvent);
        }

        private function onWindowTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_WINDOW_TRACKING_EVENT_SLEEP":
                    setErrorContextFlag(0, 3);
                    return;
                case "HABBO_WINDOW_TRACKING_EVENT_RENDER":
                    setErrorContextFlag(1, 3);
                    return;
                case "HABBO_WINDOW_TRACKING_EVENT_INPUT":
                    setErrorContextFlag(2, 3);
                    return;
            };
        }

        private function onError(_arg_1:ErrorEvent):void
        {
            storeErrorDetails(_arg_1);
            if (_arg_1.critical)
            {
                _SafeStr_238 = true;
            };
            logError(context.root.getLastErrorMessage());
        }

        private function storeErrorDetails(_arg_1:ErrorEvent):void
        {
            var _local_3:String;
            ErrorReportStorage.setParameter("is_fatal", _arg_1.critical.toString());
            ErrorReportStorage.setParameter("crash_time", new Date().getTime().toString());
            var _local_4:String = "";
            for each (var _local_2:uint in _SafeStr_481)
            {
                _local_4 = (_local_4 + _local_2);
            };
            ErrorReportStorage.setParameter("error_ctx", _local_4);
            if (_SafeStr_484 != null)
            {
                ErrorReportStorage.setParameter("flash_version", _SafeStr_484.flashVersion);
                ErrorReportStorage.setParameter("avg_update", String(_SafeStr_484.averageUpdateInterval));
            };
            ErrorReportStorage.setParameter("error_desc", _arg_1.message);
            ErrorReportStorage.setParameter("error_cat", String(_arg_1.category));
            if (_arg_1.error != null)
            {
                _local_3 = Exception.getChainedStackTrace(_arg_1.error);
                if (_local_3 != null)
                {
                    ErrorReportStorage.setParameter("error_data", _local_3);
                };
            };
            _communication.setMessageQueueErrorDebugData();
            ErrorReportStorage.addDebugData("Flash memory usage", (("Memory usage: " + Math.round((System.totalMemory / 0x100000))) + " MB"));
        }

        private function onNavigatorTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED":
                    setErrorContextFlag(0, 4);
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS":
                    setErrorContextFlag(1, 4);
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS":
                    setErrorContextFlag(2, 4);
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_ME":
                    setErrorContextFlag(3, 4);
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL":
                    setErrorContextFlag(4, 4);
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH":
                    setErrorContextFlag(5, 4);
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES":
                    legacyTrackGoogle("navigator", "my_favorites");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS":
                    legacyTrackGoogle("navigator", "my_friends_rooms");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY":
                    legacyTrackGoogle("navigator", "my_history");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS":
                    legacyTrackGoogle("navigator", "my_rooms");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS":
                    legacyTrackGoogle("navigator", "official_rooms");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS":
                    legacyTrackGoogle("navigator", "popular_rooms");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE":
                    legacyTrackGoogle("navigator", "rooms_where_my_friends_are");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE":
                    legacyTrackGoogle("navigator", "highest_score");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH":
                    legacyTrackGoogle("navigator", "tag_search");
                    return;
                case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH":
                    legacyTrackGoogle("navigator", "text_search");
                    return;
            };
        }

        private function onRoomSettingsTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED":
                    setErrorContextFlag(0, 7);
                    return;
                case "HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT":
                    setErrorContextFlag(1, 7);
                    return;
                case "HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED":
                    setErrorContextFlag(2, 7);
                    return;
            };
        }

        private function onInventoryTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_INVENTORY_TRACKING_EVENT_CLOSED":
                    setErrorContextFlag(0, 5);
                    return;
                case "HABBO_INVENTORY_TRACKING_EVENT_FURNI":
                    setErrorContextFlag(1, 5);
                    return;
                case "HABBO_INVENTORY_TRACKING_EVENT_POSTERS":
                    setErrorContextFlag(2, 5);
                    return;
                case "HABBO_INVENTORY_TRACKING_EVENT_BADGES":
                    setErrorContextFlag(3, 5);
                    return;
                case "HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS":
                    setErrorContextFlag(4, 5);
                    return;
                case "HABBO_INVENTORY_TRACKING_EVENT_TRADING":
                    setErrorContextFlag(5, 5);
                    return;
            };
        }

        private function onAchievementNotification(_arg_1:HabboAchievementNotificationMessageEvent):void
        {
            var _local_2:HabboAchievementNotificationMessageParser = _arg_1.getParser();
            legacyTrackGoogle("achievement", "achievement", [_local_2.data.badgeCode]);
        }

        private function onCatalogPageOpened(_arg_1:CatalogPageOpenedEvent):void
        {
            legacyTrackGoogle("catalogue", "page", [_arg_1.pageLocalization]);
        }

        private function onCatalogTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_CATALOG_TRACKING_EVENT_OPEN":
                    setErrorContextFlag(1, 9);
                    return;
                case "HABBO_CATALOG_TRACKING_EVENT_CLOSE":
                    setErrorContextFlag(0, 9);
                    return;
            };
        }

        private function onFriendlistTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED":
                    setErrorContextFlag(0, 6);
                    return;
                case "HABBO_FRIENDLIST_TRACKING_EVENT_FRIENDS":
                    setErrorContextFlag(1, 6);
                    return;
                case "HABBO_FRIENDLIST_TRACKING_EVENT_SEARCH":
                    setErrorContextFlag(2, 6);
                    return;
                case "HABBO_FRIENDLIST_TRACKING_EVENT_REQUEST":
                    setErrorContextFlag(3, 6);
                    return;
                case "HABBO_FRIENDLIST_TRACKING_EVENT_MINIMZED":
                    setErrorContextFlag(4, 6);
                    return;
            };
        }

        private function onHelpTrackingEvent(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "HABBO_HELP_TRACKING_EVENT_CLOSED":
                    setErrorContextFlag(0, 10);
                    return;
                case "HABBO_HELP_TRACKING_EVENT_DEFAULT":
                    setErrorContextFlag(1, 10);
                    return;
            };
        }

        private function onAuthOK(_arg_1:IMessageEvent):void
        {
            legacyTrackGoogle("authentication", "authok");
        }

        private function onPingResponse(_arg_1:LatencyPingResponseMessageEvent):void
        {
            if (_SafeStr_482 != null)
            {
                _SafeStr_482.onPingResponse(_arg_1);
            };
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            if (!_SafeStr_485)
            {
                trackLoginStep("client.init.room.enter");
                _SafeStr_485 = true;
            };
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            ErrorReportStorage.setParameter("last_room", String(_local_2.guestRoomId));
            ErrorReportStorage.setParameter("in_room", "true");
            legacyTrackGoogle("navigator", "private", [_local_2.guestRoomId]);
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
            if (_SafeStr_482 != null)
            {
                _SafeStr_482.init();
            };
        }

        private function onRoomAdLoad(_arg_1:AdEvent):void
        {
            legacyTrackGoogle("room_ad", "show", [getAliasFromAdTechUrl(_arg_1.clickUrl)]);
        }

        private function onRoomAdClick(_arg_1:RoomObjectRoomAdEvent):void
        {
            legacyTrackGoogle("room_ad", "click", [getAliasFromAdTechUrl(_arg_1.clickUrl)]);
        }

        private function getAliasFromAdTechUrl(_arg_1:String):String
        {
            var _local_2:Array = _arg_1.match(/;alias=([^;]+)/);
            if (((!(_local_2 == null)) && (_local_2.length > 1)))
            {
                return (_local_2[1]);
            };
            return ("unknown");
        }

        private function onRoomAction(_arg_1:RoomEngineEvent):void
        {
            if (_arg_1.type == "REE_INITIALIZED")
            {
                if (!_SafeStr_483)
                {
                    _SafeStr_487 = _arg_1.roomId;
                    _SafeStr_483 = new Timer(60000, 1);
                    _SafeStr_483.addEventListener("timer", onRoomActionTimerEvent);
                    _SafeStr_483.start();
                };
            }
            else
            {
                if (_arg_1.type == "REE_DISPOSED")
                {
                    if (_SafeStr_483)
                    {
                        _SafeStr_483.removeEventListener("timer", onRoomActionTimerEvent);
                        _SafeStr_483.stop();
                        _SafeStr_483 = null;
                        _SafeStr_487 = -1;
                    };
                };
            };
        }

        private function onRoomActionTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:int;
            if (((((!(disposed)) && (!(_SafeStr_238))) && (!(_communication == null))) && (_SafeStr_486)))
            {
                _local_2 = null;
                if (_roomEngine != null)
                {
                    _local_3 = _roomEngine.getRoomObjectCount(_roomEngine.activeRoomId, 100);
                    _local_4 = (_roomEngine.getRoomObjectCount(_roomEngine.activeRoomId, 10) + _roomEngine.getRoomObjectCount(_roomEngine.activeRoomId, 20));
                    _local_2 = ((("Avatars: " + _local_3) + ", Objects: ") + _local_4);
                };
                trackEventLog("ClientPerformance", String(_SafeStr_486.frameRate), "fps", _local_2, _SafeStr_487);
                _SafeStr_488++;
            };
        }

        private function onToolbarClick(_arg_1:HabboToolbarEvent):void
        {
            if (_SafeStr_489)
            {
                _SafeStr_489.track(_arg_1.iconName);
            };
        }

        private function onZoomToggle(_arg_1:HabboToolbarEvent):void
        {
            if (_SafeStr_489)
            {
                _SafeStr_489.track(_arg_1.type);
            };
        }

        public function legacyTrackGoogle(_arg_1:String, _arg_2:String, _arg_3:Array=null):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.legacyTrack", _arg_1, _arg_2, ((_arg_3 == null) ? [] : _arg_3));
                }
                else
                {
                    Logger.log("ExternalInterface is not available, tracking is disabled");
                };
            }
            catch(e:Error)
            {
            };
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            Logger.log((((((("trackGoogle(" + _arg_1) + ", ") + _arg_2) + ", ") + _arg_3) + ")"));
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.track", _arg_1, _arg_2, _arg_3);
                }
                else
                {
                    Logger.log("ExternalInterface is not available, tracking is disabled");
                };
            }
            catch(e:Error)
            {
            };
        }

        private function loadConversionTrackingFrame():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.loadConversionTrackingFrame");
                }
                else
                {
                    Logger.log("ExternalInterface is not available!");
                };
            }
            catch(e:Error)
            {
            };
        }

        public function trackLoginStep(_arg_1:String, _arg_2:String=null):void
        {
            Logger.log(("* Track Login Step: " + _arg_1));
            if (!getBoolean("processlog.enabled"))
            {
                return;
            };
            try
            {
                if (ExternalInterface.available)
                {
                    if (_arg_2 != null)
                    {
                        ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1, _arg_2);
                    }
                    else
                    {
                        ExternalInterface.call("FlashExternalInterface.logLoginStep", _arg_1);
                    };
                }
                else
                {
                    Logger.log("ExternalInterface is not available, tracking is disabled");
                };
            }
            catch(e:Error)
            {
            };
        }

        public function trackEventLog(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="", _arg_5:int=0):void
        {
            if ((((!(_communication == null)) && (!(_communication.connection == null))) && (_communication.connection.connected)))
            {
                _communication.connection.send(new EventLogMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            };
        }

        public function trackEventLogOncePerSession(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="", _arg_5:int=0):void
        {
            var _local_7:uint;
            var _local_8:String = ((_arg_1 + _arg_2) + _arg_3);
            var _local_6:Boolean;
            _local_7 = 0;
            while (_local_7 < onceTrackedEvents.length)
            {
                if (onceTrackedEvents[_local_7] == _local_8)
                {
                    _local_6 = true;
                    break;
                };
                _local_7++;
            };
            if (!_local_6)
            {
                trackEventLog(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                onceTrackedEvents.push(_local_8);
            };
        }

        public function trackTalentTrackOpen(_arg_1:String, _arg_2:String):void
        {
            trackEventLog("Talent", _arg_1, "talent.open", _arg_2);
        }

        public function logError(_arg_1:String):void
        {
            Logger.log((("logError(" + _arg_1) + ")"));
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.logError", _arg_1);
                }
                else
                {
                    Logger.log("ExternalInterface is not available, tracking is disabled");
                };
            }
            catch(e:Error)
            {
            };
        }

        public function chatLagDetected(_arg_1:int):void
        {
            _SafeStr_490.chatLagDetected(_arg_1);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:int = getTimer();
            if (((_currentTime > -1) && (_local_2 < _currentTime)))
            {
                _SafeStr_491++;
                ErrorReportStorage.addDebugData("Invalid time counter", ("Invalid times: " + _SafeStr_491));
            };
            if (((_currentTime > -1) && ((_local_2 - _currentTime) > 15000)))
            {
                _SafeStr_492++;
                ErrorReportStorage.addDebugData("Time leap counter", ("Time leaps: " + _SafeStr_492));
            };
            _currentTime = _local_2;
            if (_SafeStr_484 != null)
            {
                _SafeStr_484.update(_arg_1, _currentTime);
            };
            if (_SafeStr_482 != null)
            {
                _SafeStr_482.update(_arg_1, _currentTime);
            };
            if (_SafeStr_486 != null)
            {
                _SafeStr_486.trackUpdate(_arg_1, _currentTime);
            };
            if (_SafeStr_490 != null)
            {
                _SafeStr_490.update(_currentTime);
            };
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function send(_arg_1:IMessageComposer):void
        {
            if ((((!(_communication == null)) && (!(_communication.connection == null))) && (_communication.connection.connected)))
            {
                _communication.connection.send(_arg_1);
            };
        }


    }
}
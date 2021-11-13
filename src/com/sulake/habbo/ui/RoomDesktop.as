package com.sulake.habbo.ui
{
    import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.groups.IHabboGroupsManager;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components.IToolTipWindow;
    import flash.utils.Timer;
    import flash.geom.Rectangle;
    import com.sulake.core.communication.messages.IMessageEvent;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillListUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotForceOpenContextMenuEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.ui.widget.IRoomWidget;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillListUpdateParser;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotForceOpenContextMenuParser;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.habbo.ui.handler.ChatWidgetHandler;
    import com.sulake.habbo.ui.handler.PlayListEditorWidgetHandler;
    import com.sulake.habbo.ui.handler.SpamWallPostItWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureRoomLinkHandler;
    import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
    import com.sulake.habbo.ui.handler.ChatInputWidgetHandler;
    import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
    import com.sulake.habbo.ui.handler.PlaceholderWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureCreditWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureStickieWidgetHandler;
    import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureTrophyWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureEcotronBoxWidgetHandler;
    import com.sulake.habbo.ui.handler.PetPackageFurniWidgetHandler;
    import com.sulake.habbo.ui.handler.DoorbellWidgetHandler;
    import com.sulake.habbo.ui.handler.RoomQueueWidgetHandler;
    import com.sulake.habbo.ui.handler.LoadingBarWidgetHandler;
    import com.sulake.habbo.ui.handler.PollWidgetHandler;
    import com.sulake.habbo.ui.handler.WordQuizWidgetHandler;
    import com.sulake.habbo.ui.handler.FurniChooserWidgetHandler;
    import com.sulake.habbo.ui.handler.UserChooserWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureDimmerWidgetHandler;
    import com.sulake.habbo.ui.handler.FriendRequestWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureClothingChangeWidgetHandler;
    import com.sulake.habbo.ui.handler.ConversionPointWidgetHandler;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.ui.handler.EffectsWidgetHandler;
    import com.sulake.habbo.ui.handler.MannequinWidgetHandler;
    import com.sulake.habbo.ui.handler.ObjectLocationRequestHandler;
    import com.sulake.habbo.ui.handler.CameraWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureBackgroundColorWidgetHandler;
    import com.sulake.habbo.ui.handler.CustomUserNotificationWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureBadgeDisplayWidgetHandler;
    import com.sulake.habbo.ui.handler.FriendFurniConfirmWidgetHandler;
    import com.sulake.habbo.ui.handler.FriendFurniEngravingWidgetHandler;
    import com.sulake.habbo.ui.handler.HighScoreFurniWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureInternalLinkHandler;
    import com.sulake.habbo.ui.handler.FurnitureCustomStackHeightWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureYoutubeDisplayWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureRentableSpaceWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureVimeoDisplayWidgetHandler;
    import com.sulake.habbo.ui.handler.ExternalImageWidgetHandler;
    import com.sulake.habbo.ui.handler.UiHelpBubbleWidgetHandler;
    import com.sulake.habbo.ui.handler.RoomThumbnailCameraWidgetHandler;
    import com.sulake.habbo.ui.handler.CraftingWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import flash.events.Event;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.utils.RoomId;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.core.window.IWindow;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.room.utils.ColorConverter;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.runtime.Component;
    import flash.filters.BlurFilter;
    import flash.display.BitmapData;
    import flash.filters.DisplacementMapFilter;
    import flash.filters.BitmapFilter;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.habbo.ui.handler.*;

    public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer 
    {

        public static const STATE_UNDEFINED:int = -1;
        private static const RESIZE_UPDATE_TIMEOUT_MS:int = 1000;
        private static const SCALE_UPDATE_TIMEOUT_MS:int = 1000;

        private var _events:EventDispatcherWrapper;
        private var _windowManager:IHabboWindowManager = null;
        private var _roomEngine:IRoomEngine = null;
        private var _roomWidgetFactory:IRoomWidgetFactory = null;
        private var _sessionDataManager:ISessionDataManager = null;
        private var _roomSessionManager:IRoomSessionManager = null;
        private var _communicationManager:IHabboCommunicationManager = null;
        private var _avatarRenderManager:IAvatarRenderManager = null;
        private var _friendList:IHabboFriendList = null;
        private var _inventory:IHabboInventory = null;
        private var _toolbar:IHabboToolbar = null;
        private var _navigator:IHabboNavigator = null;
        private var _messenger:IHabboMessenger = null;
        private var _habboGroupsManager:IHabboGroupsManager = null;
        private var _avatarEditor:IHabboAvatarEditor = null;
        private var _catalog:IHabboCatalog = null;
        private var _adManager:IAdManager = null;
        private var _localization:IHabboLocalizationManager = null;
        private var _habboHelp:IHabboHelp = null;
        private var _connection:IConnection = null;
        private var _moderation:IHabboModeration;
        private var _config:ICoreConfiguration;
        private var _soundManager:IHabboSoundManager;
        private var _habboTracking:IHabboTracking;
        private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
        private var _gameManager:IHabboGameManager;
        private var _questEngine:IHabboQuestEngine;
        private var _freeFlowChat:IHabboFreeFlowChat;
        private var _assets:IAssetLibrary = null;
        private var _session:IRoomSession = null;
        private var _SafeStr_4319:Array = [];
        private var _SafeStr_1647:Map;
        private var _SafeStr_4320:Map;
        private var _SafeStr_4321:Map;
        private var _updateListeners:Array;
        private var _layoutManager:DesktopLayoutManager;
        private var _SafeStr_4322:IDisplayObjectWrapper;
        private var _SafeStr_4323:Boolean = true;
        private var _SafeStr_585:Array;
        private var _SafeStr_4324:IToolTipWindow;
        private var _roomColor:uint = 0xFFFFFF;
        private var _SafeStr_4325:Boolean = false;
        private var _zoomChangedMillis:int = 0;
        private var _roomBackgroundColor:uint = 0;
        private var _SafeStr_2821:Timer;
        private var _SafeStr_4326:Rectangle;
        private var _SafeStr_4317:IMessageEvent;
        private var _SafeStr_4318:IMessageEvent;
        private var _SafeStr_884:Point;
        private var _SafeStr_4272:Number = 0;
        private var _SafeStr_4327:Number = 0;
        private var _SafeStr_4328:Boolean;

        public function RoomDesktop(_arg_1:IRoomSession, _arg_2:IAssetLibrary, _arg_3:IConnection)
        {
            _events = new EventDispatcherWrapper();
            _session = _arg_1;
            _assets = _arg_2;
            _connection = _arg_3;
            _SafeStr_4317 = new BotSkillListUpdateEvent(onBotSkillListUpdateEvent);
            _connection.addMessageEvent(_SafeStr_4317);
            _SafeStr_4318 = new BotForceOpenContextMenuEvent(onBotForceOpenContextMenuEvent);
            _connection.addMessageEvent(_SafeStr_4318);
            _SafeStr_1647 = new Map();
            _SafeStr_4320 = new Map();
            _SafeStr_4321 = new Map();
            _layoutManager = new DesktopLayoutManager();
            checkInterrupts();
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (_SafeStr_4322)
            {
                _SafeStr_4322.visible = _arg_1;
            };
        }

        public function get roomSession():IRoomSession
        {
            return (_session);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get events():IEventDispatcher
        {
            return (_events);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get friendList():IHabboFriendList
        {
            return (_friendList);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (_avatarRenderManager);
        }

        public function get inventory():IHabboInventory
        {
            return (((_inventory) && (!(_inventory.disposed))) ? _inventory : null);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get roomWidgetFactory():IRoomWidgetFactory
        {
            return (_roomWidgetFactory);
        }

        public function get navigator():IHabboNavigator
        {
            return (_navigator);
        }

        public function get habboGroupsManager():IHabboGroupsManager
        {
            return (_habboGroupsManager);
        }

        public function get communicationManager():IHabboCommunicationManager
        {
            return (_communicationManager);
        }

        public function get avatarEditor():IHabboAvatarEditor
        {
            return (_avatarEditor);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get habboHelp():IHabboHelp
        {
            return (_habboHelp);
        }

        public function get config():ICoreConfiguration
        {
            return (_config);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (_soundManager);
        }

        public function get messenger():IHabboMessenger
        {
            return (_messenger);
        }

        public function get moderation():IHabboModeration
        {
            return (_moderation);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get habboTracking():IHabboTracking
        {
            return (_habboTracking);
        }

        public function get session():IRoomSession
        {
            return (_session);
        }

        public function get gameManager():IHabboGameManager
        {
            return (_gameManager);
        }

        public function get questEngine():IHabboQuestEngine
        {
            return (_questEngine);
        }

        public function get freeFlowChat():IHabboFreeFlowChat
        {
            return (_freeFlowChat);
        }

        public function get roomBackgroundColor():uint
        {
            return (_roomBackgroundColor);
        }

        public function set catalog(_arg_1:IHabboCatalog):void
        {
            _catalog = _arg_1;
        }

        public function set avatarEditor(_arg_1:IHabboAvatarEditor):void
        {
            _avatarEditor = _arg_1;
        }

        public function set roomWidgetFactory(_arg_1:IRoomWidgetFactory):void
        {
            _roomWidgetFactory = _arg_1;
        }

        public function set sessionDataManager(_arg_1:ISessionDataManager):void
        {
            _sessionDataManager = _arg_1;
        }

        public function set roomSessionManager(_arg_1:IRoomSessionManager):void
        {
            _roomSessionManager = _arg_1;
            checkInterrupts();
        }

        public function set communicationManager(_arg_1:IHabboCommunicationManager):void
        {
            _communicationManager = _arg_1;
        }

        public function get userDefinedRoomEvents():IHabboUserDefinedRoomEvents
        {
            return (_userDefinedRoomEvents);
        }

        public function get connection():IConnection
        {
            return (_connection);
        }

        public function set friendList(_arg_1:IHabboFriendList):void
        {
            _friendList = _arg_1;
            if (_friendList)
            {
                _friendList.events.addEventListener("FRE_ACCEPTED", processEvent);
                _friendList.events.addEventListener("FRE_DECLINED", processEvent);
            };
        }

        public function set avatarRenderManager(_arg_1:IAvatarRenderManager):void
        {
            _avatarRenderManager = _arg_1;
        }

        public function set windowManager(_arg_1:IHabboWindowManager):void
        {
            _windowManager = _arg_1;
        }

        public function set inventory(_arg_1:IHabboInventory):void
        {
            _inventory = _arg_1;
        }

        public function set navigator(_arg_1:IHabboNavigator):void
        {
            _navigator = _arg_1;
        }

        public function set adManager(_arg_1:IAdManager):void
        {
            _adManager = _arg_1;
        }

        public function set localization(_arg_1:IHabboLocalizationManager):void
        {
            _localization = _arg_1;
        }

        public function set habboHelp(_arg_1:IHabboHelp):void
        {
            _habboHelp = _arg_1;
        }

        public function set moderation(_arg_1:IHabboModeration):void
        {
            _moderation = _arg_1;
        }

        public function set config(_arg_1:ICoreConfiguration):void
        {
            _config = _arg_1;
        }

        public function set soundManager(_arg_1:IHabboSoundManager):void
        {
            _soundManager = _arg_1;
        }

        public function set habboTracking(_arg_1:IHabboTracking):void
        {
            _habboTracking = _arg_1;
        }

        public function set userDefinedRoomEvents(_arg_1:IHabboUserDefinedRoomEvents):void
        {
            _userDefinedRoomEvents = _arg_1;
        }

        public function set gameManager(_arg_1:IHabboGameManager):void
        {
            _gameManager = _arg_1;
        }

        public function set questEngine(_arg_1:IHabboQuestEngine):void
        {
            _questEngine = _arg_1;
        }

        public function set freeFlowChat(_arg_1:IHabboFreeFlowChat):void
        {
            _freeFlowChat = _arg_1;
        }

        public function set habboGroupsManager(_arg_1:IHabboGroupsManager):void
        {
            _habboGroupsManager = _arg_1;
        }

        public function set roomEngine(_arg_1:IRoomEngine):void
        {
            _roomEngine = _arg_1;
            if (((!(_roomEngine == null)) && (!(_roomEngine.events == null))))
            {
                _roomEngine.events.addEventListener("RCLE_SUCCESS", onRoomContentLoaded);
                _roomEngine.events.addEventListener("RCLE_FAILURE", onRoomContentLoaded);
                _roomEngine.events.addEventListener("RCLE_CANCEL", onRoomContentLoaded);
            };
        }

        public function set messenger(_arg_1:IHabboMessenger):void
        {
            _messenger = _arg_1;
        }

        public function set toolbar(_arg_1:IHabboToolbar):void
        {
            _toolbar = _arg_1;
            _toolbar.events.addEventListener("HTIE_ICON_ZOOM", onToolbarEvent);
        }

        public function set layout(_arg_1:XML):void
        {
            _layoutManager.setLayout(_arg_1, _windowManager, _config);
        }

        public function dispose():void
        {
            var _local_5:IRoomGeometry;
            var _local_4:int;
            var _local_3:String;
            var _local_1:IRoomWidget;
            if (((!(_roomEngine == null)) && (!(_session == null))))
            {
                _local_5 = _roomEngine.getRoomCanvasGeometry(_session.roomId, getFirstCanvasId());
                if (_local_5 != null)
                {
                    trackZooming(_local_5.isZoomedIn(), false);
                };
            };
            var _local_2:int;
            if (_SafeStr_4319 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_4319.length)
                {
                    _local_4 = _SafeStr_4319[_local_2];
                    _local_3 = getWindowName(_local_4);
                    if (_windowManager)
                    {
                        _windowManager.removeWindow(_local_3);
                    };
                    _local_2++;
                };
            };
            _updateListeners = null;
            if (_SafeStr_1647 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_1647.length)
                {
                    _local_1 = (_SafeStr_1647.getWithIndex(_local_2) as IRoomWidget);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_1647.dispose();
                _SafeStr_1647 = null;
            };
            if (_SafeStr_4320 != null)
            {
                _SafeStr_4320.dispose();
                _SafeStr_4320 = null;
            };
            if (_SafeStr_4321 != null)
            {
                _SafeStr_4321.dispose();
                _SafeStr_4321 = null;
            };
            if (_connection)
            {
                if (_SafeStr_4317 != null)
                {
                    _connection.removeMessageEvent(_SafeStr_4317);
                    _SafeStr_4317.dispose();
                    _SafeStr_4317 = null;
                };
                if (_SafeStr_4318 != null)
                {
                    _connection.removeMessageEvent(_SafeStr_4318);
                    _SafeStr_4318.dispose();
                    _SafeStr_4318 = null;
                };
                _connection = null;
            };
            _assets = null;
            _avatarRenderManager = null;
            _SafeStr_4319 = null;
            _events = null;
            if (((_friendList) && (_friendList.events)))
            {
                _friendList.events.removeEventListener("FRE_ACCEPTED", processEvent);
                _friendList.events.removeEventListener("FRE_DECLINED", processEvent);
            };
            _friendList = null;
            _layoutManager.dispose();
            _layoutManager = null;
            if (((!(_roomEngine == null)) && (!(_roomEngine.events == null))))
            {
                _roomEngine.events.removeEventListener("RCLE_SUCCESS", onRoomContentLoaded);
                _roomEngine.events.removeEventListener("RCLE_FAILURE", onRoomContentLoaded);
                _roomEngine.events.removeEventListener("RCLE_CANCEL", onRoomContentLoaded);
            };
            _roomEngine = null;
            _roomSessionManager = null;
            _roomWidgetFactory = null;
            _session = null;
            _sessionDataManager = null;
            _windowManager = null;
            _inventory = null;
            _localization = null;
            _config = null;
            _soundManager = null;
            _habboGroupsManager = null;
            if (((_toolbar) && (toolbar.events)))
            {
                _toolbar.events.removeEventListener("HTIE_ICON_ZOOM", onToolbarEvent);
                _toolbar = null;
            };
            _navigator = null;
            if (_SafeStr_4324 != null)
            {
                _SafeStr_4324.dispose();
                _SafeStr_4324 = null;
            };
            if (_SafeStr_2821 != null)
            {
                _SafeStr_2821.reset();
                _SafeStr_2821.removeEventListener("timer", onResizeTimerEvent);
                _SafeStr_2821 = null;
            };
            _SafeStr_4326 = null;
        }

        private function onBotSkillListUpdateEvent(_arg_1:BotSkillListUpdateEvent):void
        {
            var _local_2:IUserData;
            var _local_3:BotSkillListUpdateParser = _arg_1.getParser();
            if (_session != null)
            {
                _local_2 = _session.userDataManager.getRentableBotUserData(_local_3.botId);
                _local_2.botSkillData = _arg_1.getParser().skillList.concat();
            };
            events.dispatchEvent(new RoomWidgetRentableBotSkillListUpdateEvent(_local_3.botId, _local_3.skillList));
        }

        private function onBotForceOpenContextMenuEvent(_arg_1:BotForceOpenContextMenuEvent):void
        {
            var _local_2:BotForceOpenContextMenuParser = _arg_1.getParser();
            events.dispatchEvent(new RoomWidgetRentableBotForceOpenContextMenuEvent(_local_2.botId));
        }

        public function init():void
        {
            if (((!(_roomEngine == null)) && (!(_session == null))))
            {
                _SafeStr_585 = [];
                if (_SafeStr_585.length > 0)
                {
                    _SafeStr_4323 = false;
                    processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUE_SHOW_LOADING_BAR"));
                };
            };
        }

        public function requestInterstitial():void
        {
            if (_adManager != null)
            {
                _adManager.showInterstitial();
            };
        }

        private function onRoomContentLoaded(_arg_1:RoomContentLoadedEvent):void
        {
            if (((_SafeStr_585 == null) || (_SafeStr_585.length == 0)))
            {
                return;
            };
            var _local_2:int = _SafeStr_585.indexOf(_arg_1.contentType);
            if (_local_2 != -1)
            {
                _SafeStr_585.splice(_local_2, 1);
            };
            if (_SafeStr_585.length == 0)
            {
                _SafeStr_4323 = true;
                checkInterrupts();
            };
        }

        public function createWidget(_arg_1:String):void
        {
            var _local_8:Boolean;
            var _local_2:IRoomWidgetHandler;
            var _local_6:ChatWidgetHandler;
            var _local_15:PlayListEditorWidgetHandler;
            var _local_3:SpamWallPostItWidgetHandler;
            var _local_5:FurnitureContextMenuWidgetHandler;
            var _local_10:FurnitureRoomLinkHandler;
            var _local_7:RoomToolsWidgetHandler;
            var _local_12:Array;
            var _local_13:Array;
            var _local_16:Array;
            var _local_11:RoomWidgetRoomViewUpdateEvent;
            if (_roomWidgetFactory == null)
            {
                return;
            };
            var _local_4:IRoomWidget = (_SafeStr_1647.getValue(_arg_1) as IRoomWidget);
            if (_local_4 != null)
            {
                return;
            };
            if (((_session.isGameSession) && (!(isGameWidget(_arg_1)))))
            {
                return;
            };
            switch (_arg_1)
            {
                case "RWE_CHAT_WIDGET":
                    _local_6 = new ChatWidgetHandler();
                    _local_6.connection = _connection;
                    _local_2 = _local_6;
                    _local_8 = true;
                    break;
                case "RWE_INFOSTAND":
                    _local_2 = new InfoStandWidgetHandler(_soundManager.musicController);
                    break;
                case "RWE_CHAT_INPUT_WIDGET":
                    _local_8 = true;
                    _local_2 = new ChatInputWidgetHandler();
                    break;
                case "RWE_ME_MENU":
                    _local_2 = new MeMenuWidgetHandler();
                    break;
                case "RWE_FURNI_PLACEHOLDER":
                    _local_2 = new PlaceholderWidgetHandler();
                    break;
                case "RWE_FURNI_CREDIT_WIDGET":
                    _local_2 = new FurnitureCreditWidgetHandler();
                    break;
                case "RWE_FURNI_STICKIE_WIDGET":
                    _local_2 = new FurnitureStickieWidgetHandler();
                    break;
                case "RWE_FURNI_PRESENT_WIDGET":
                    _local_2 = new FurniturePresentWidgetHandler();
                    break;
                case "RWE_FURNI_TROPHY_WIDGET":
                    _local_2 = new FurnitureTrophyWidgetHandler();
                    break;
                case "RWE_FURNI_ECOTRONBOX_WIDGET":
                    _local_2 = new FurnitureEcotronBoxWidgetHandler();
                    break;
                case "RWE_FURNI_PET_PACKAGE_WIDGET":
                    _local_2 = new PetPackageFurniWidgetHandler();
                    break;
                case "RWE_DOORBELL":
                    _local_2 = new DoorbellWidgetHandler();
                    break;
                case "RWE_ROOM_QUEUE":
                    _local_2 = new RoomQueueWidgetHandler();
                    break;
                case "RWE_LOADINGBAR":
                    _local_2 = new LoadingBarWidgetHandler();
                    break;
                case "RWE_ROOM_POLL":
                    _local_2 = new PollWidgetHandler();
                    break;
                case "RWE_WORD_QUIZZ":
                    _local_2 = new WordQuizWidgetHandler();
                    break;
                case "RWE_FURNI_CHOOSER":
                    _local_2 = new FurniChooserWidgetHandler();
                    break;
                case "RWE_USER_CHOOSER":
                    _local_2 = new UserChooserWidgetHandler();
                    break;
                case "RWE_ROOM_DIMMER":
                    _local_2 = new FurnitureDimmerWidgetHandler();
                    break;
                case "RWE_FRIEND_REQUEST":
                    _local_2 = new FriendRequestWidgetHandler();
                    break;
                case "RWE_CLOTHING_CHANGE":
                    _local_2 = new FurnitureClothingChangeWidgetHandler();
                    break;
                case "RWE_CONVERSION_TRACKING":
                    _local_2 = new ConversionPointWidgetHandler();
                    break;
                case "RWE_AVATAR_INFO":
                    _local_2 = new AvatarInfoWidgetHandler();
                    break;
                case "RWE_PLAYLIST_EDITOR_WIDGET":
                    _local_15 = new PlayListEditorWidgetHandler();
                    _local_15.connection = _connection;
                    _local_2 = (_local_15 as IRoomWidgetHandler);
                    break;
                case "RWE_SPAMWALL_POSTIT_WIDGET":
                    _local_3 = new SpamWallPostItWidgetHandler();
                    _local_3.connection = _connection;
                    _local_2 = (_local_3 as IRoomWidgetHandler);
                    break;
                case "RWE_EFFECTS":
                    _local_2 = new EffectsWidgetHandler();
                    break;
                case "RWE_MANNEQUIN":
                    _local_2 = new MannequinWidgetHandler();
                    break;
                case "RWE_FURNITURE_CONTEXT_MENU":
                    _local_5 = new FurnitureContextMenuWidgetHandler();
                    _local_5.connection = _connection;
                    _local_2 = (_local_5 as IRoomWidgetHandler);
                    break;
                case "RWE_LOCATION_WIDGET":
                    _local_2 = new ObjectLocationRequestHandler();
                    break;
                case "RWE_CAMERA":
                    _local_2 = new CameraWidgetHandler(this);
                    break;
                case "RWE_ROOM_BACKGROUND_COLOR":
                    _local_2 = new FurnitureBackgroundColorWidgetHandler();
                    break;
                case "RWE_CUSTOM_USER_NOTIFICATION":
                    _local_2 = new CustomUserNotificationWidgetHandler();
                    break;
                case "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                    _local_2 = new FurnitureBadgeDisplayWidgetHandler();
                    break;
                case "RWE_FRIEND_FURNI_CONFIRM":
                    _local_2 = new FriendFurniConfirmWidgetHandler();
                    FriendFurniConfirmWidgetHandler(_local_2).connection = connection;
                    break;
                case "RWE_FRIEND_FURNI_ENGRAVING":
                    _local_2 = new FriendFurniEngravingWidgetHandler();
                    break;
                case "RWE_HIGH_SCORE_DISPLAY":
                    _local_2 = new HighScoreFurniWidgetHandler();
                    break;
                case "RWE_INTERNAL_LINK":
                    _local_2 = new FurnitureInternalLinkHandler();
                    break;
                case "RWE_ROOM_LINK":
                    _local_10 = new FurnitureRoomLinkHandler();
                    _local_10.communicationManager = _communicationManager;
                    _local_2 = _local_10;
                    break;
                case "RWE_CUSTOM_STACK_HEIGHT":
                    _local_2 = new FurnitureCustomStackHeightWidgetHandler();
                    break;
                case "RWE_YOUTUBE":
                    _local_2 = new FurnitureYoutubeDisplayWidgetHandler();
                    break;
                case "RWE_RENTABLESPACE":
                    _local_2 = new FurnitureRentableSpaceWidgetHandler();
                    break;
                case "RWE_VIMEO":
                    _local_2 = new FurnitureVimeoDisplayWidgetHandler();
                    break;
                case "RWE_ROOM_TOOLS":
                    _local_7 = new RoomToolsWidgetHandler();
                    _local_7.communicationManager = _communicationManager;
                    _local_7.navigator = _navigator;
                    _local_2 = _local_7;
                    break;
                case "RWE_EXTERNAL_IMAGE":
                    _local_2 = new ExternalImageWidgetHandler();
                    break;
                case "RWE_UI_HELP_BUBBLE":
                    _local_2 = new UiHelpBubbleWidgetHandler();
                    break;
                case "RWE_ROOM_THUMBNAIL_CAMERA":
                    _local_2 = new RoomThumbnailCameraWidgetHandler(this);
                    break;
                case "RWE_CRAFTING":
                    _local_2 = new CraftingWidgetHandler(this);
            };
            if (_local_2 != null)
            {
                _local_2.container = this;
                _local_12 = null;
                _local_13 = _local_2.getWidgetMessages();
                if (_local_13 != null)
                {
                    for each (var _local_9:String in _local_13)
                    {
                        _local_12 = _SafeStr_4320.getValue(_local_9);
                        if (_local_12 == null)
                        {
                            _local_12 = [];
                            _SafeStr_4320.add(_local_9, _local_12);
                        };
                        _local_12.push(_local_2);
                    };
                };
                _local_16 = _local_2.getProcessedEvents();
                if (_local_16 != null)
                {
                    _local_16.push("RETWE_OPEN_WIDGET");
                    _local_16.push("RETWE_CLOSE_WIDGET");
                    for each (var _local_14:String in _local_16)
                    {
                        _local_12 = _SafeStr_4321.getValue(_local_14);
                        if (_local_12 == null)
                        {
                            _local_12 = [];
                            _SafeStr_4321.add(_local_14, _local_12);
                        };
                        _local_12.push(_local_2);
                    };
                };
            };
            _local_4 = _roomWidgetFactory.createWidget(_arg_1, _local_2);
            if (_local_4 == null)
            {
                return;
            };
            _local_4.messageListener = this;
            _local_4.registerUpdateEvents(_events);
            if (!_SafeStr_1647.add(_arg_1, _local_4))
            {
                _local_4.dispose();
            }
            else
            {
                _layoutManager.addWidgetWindow(_arg_1, _local_4.mainWindow);
            };
            if (_local_8)
            {
                _arg_1 = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
                _local_11 = new RoomWidgetRoomViewUpdateEvent(_arg_1, _layoutManager.roomViewRect);
                this.events.dispatchEvent(_local_11);
            };
        }

        private function isGameWidget(_arg_1:String):Boolean
        {
            switch (_arg_1)
            {
                case "RWE_CHAT_INPUT_WIDGET":
                case "RWE_CHAT_WIDGET":
                case "RWE_AVATAR_INFO":
                case "RWE_LOCATION_WIDGET":
                    return (true);
                default:
                    return (false);
            };
        }

        public function disposeWidget(_arg_1:String):void
        {
            var _local_2:IRoomWidget;
            if (_SafeStr_1647 != null)
            {
                _local_2 = _SafeStr_1647.remove(_arg_1);
                if (_local_2 != null)
                {
                    if (_layoutManager != null)
                    {
                        _layoutManager.removeWidgetWindow(_arg_1, _local_2.mainWindow);
                    };
                    _local_2.dispose();
                };
            };
        }

        public function getWidget(_arg_1:String):IRoomWidget
        {
            var _local_2:IRoomWidget;
            if (_SafeStr_1647 != null)
            {
                _local_2 = _SafeStr_1647[_arg_1];
            };
            return (_local_2);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_4:RoomWidgetUpdateEvent;
            if (_arg_1 == null)
            {
                return (null);
            };
            if (_arg_1.type == "RWZTM_ZOOM_TOGGLE")
            {
                toggleZoom();
            };
            var _local_3:Array = _SafeStr_4320.getValue(_arg_1.type);
            if (_local_3 != null)
            {
                for each (var _local_2:IRoomWidgetHandler in _local_3)
                {
                    _local_4 = _local_2.processWidgetMessage(_arg_1);
                    if (_local_4 != null)
                    {
                        return (_local_4);
                    };
                };
            };
            return (null);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_3:Boolean;
            var _local_5:RoomEngineToWidgetEvent;
            if (((!(_arg_1)) || (!(_SafeStr_4321))))
            {
                return;
            };
            if (((_SafeStr_4322) && (_arg_1.type == "RDMZEE_ENABLED")))
            {
                checkAndEnableMouseZoomEvent(_SafeStr_4322.getDisplayObject());
            };
            var _local_4:Array = _SafeStr_4321.getValue(_arg_1.type);
            if (_local_4 != null)
            {
                for each (var _local_2:IRoomWidgetHandler in _local_4)
                {
                    _local_3 = true;
                    if (((_arg_1.type == "RETWE_OPEN_WIDGET") || (_arg_1.type == "RETWE_CLOSE_WIDGET")))
                    {
                        _local_5 = (_arg_1 as RoomEngineToWidgetEvent);
                        _local_3 = ((!(_local_5 == null)) && (_local_2.type == _local_5.widget));
                    };
                    if (_arg_1.type == "RWZTM_ZOOM_TOGGLE")
                    {
                        toggleZoom();
                    };
                    if (_local_3)
                    {
                        _local_2.processEvent(_arg_1);
                    };
                };
            };
        }

        private function isFurnitureSelectionDisabled(_arg_1:RoomEngineObjectEvent):Boolean
        {
            var _local_4:IRoomObjectModel;
            var _local_3:Boolean;
            var _local_2:IRoomObject = roomEngine.getRoomObject(_arg_1.roomId, _arg_1.objectId, _arg_1.category);
            if (_local_2 != null)
            {
                _local_4 = _local_2.getModel();
                if (_local_4 != null)
                {
                    if (_local_4.getNumber("furniture_selection_disable") == 1)
                    {
                        _local_3 = true;
                        if (_sessionDataManager.isAnyRoomController)
                        {
                            _local_3 = false;
                        };
                    };
                };
            };
            return (_local_3);
        }

        public function roomObjectEventHandler(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_7:String;
            var _local_10:IUserData;
            var _local_12:IRoomObject;
            var _local_8:int;
            var _local_4:int;
            var _local_2:Boolean;
            var _local_11:int;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_5:int = _arg_1.objectId;
            var _local_6:int = _arg_1.category;
            var _local_3:RoomWidgetRoomObjectUpdateEvent;
            var _local_9:RoomWidgetFurniToWidgetMessage;
            switch (_arg_1.type)
            {
                case "REOE_SELECTED":
                    if (!isFurnitureSelectionDisabled(_arg_1))
                    {
                        _local_3 = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_SELECTED", _local_5, _local_6, _arg_1.roomId);
                    };
                    if (((!(_moderation == null)) && (_local_6 == 100)))
                    {
                        _local_10 = _session.userDataManager.getUserDataByIndex(_local_5);
                        if (((!(_local_10 == null)) && (_local_10.type == 1)))
                        {
                            _moderation.userSelected(_local_10.webID, _local_10.name);
                        };
                    };
                    break;
                case "REOE_ADDED":
                    switch (_local_6)
                    {
                        case 10:
                        case 20:
                            _local_7 = "RWROUE_FURNI_ADDED";
                            break;
                        case 100:
                            _local_7 = "RWROUE_USER_ADDED";
                    };
                    if (_local_7 != null)
                    {
                        _local_3 = new RoomWidgetRoomObjectUpdateEvent(_local_7, _local_5, _local_6, _arg_1.roomId);
                    };
                    break;
                case "REOE_REMOVED":
                    switch (_local_6)
                    {
                        case 10:
                        case 20:
                            _local_7 = "RWROUE_FURNI_REMOVED";
                            break;
                        case 100:
                            _local_7 = "RWROUE_USER_REMOVED";
                    };
                    if (_local_7 != null)
                    {
                        _local_3 = new RoomWidgetRoomObjectUpdateEvent(_local_7, _local_5, _local_6, _arg_1.roomId);
                    };
                    break;
                case "REOE_DESELECTED":
                    _local_3 = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_DESELECTED", _local_5, _local_6, _arg_1.roomId);
                    break;
                case "REOE_MOUSE_ENTER":
                    _local_3 = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OVER", _local_5, _local_6, _arg_1.roomId);
                    break;
                case "REOE_MOUSE_LEAVE":
                    _local_3 = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OUT", _local_5, _local_6, _arg_1.roomId);
                    break;
                case "REOE_REQUEST_MOVE":
                    if (checkFurniManipulationRights(_arg_1.roomId, _arg_1.objectId, _arg_1.category))
                    {
                        _roomEngine.modifyRoomObject(_arg_1.objectId, _arg_1.category, "OBJECT_MOVE");
                    };
                    break;
                case "REOE_REQUEST_ROTATE":
                    if (checkFurniManipulationRights(_arg_1.roomId, _arg_1.objectId, _arg_1.category))
                    {
                        _roomEngine.modifyRoomObject(_arg_1.objectId, _arg_1.category, "OBJECT_ROTATE_POSITIVE");
                    };
                    break;
                case "RETWE_REQUEST_CREDITFURNI":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CREDITFURNI", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_STICKIE":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_STICKIE", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_PRESENT":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PRESENT", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_TROPHY":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TROPHY", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_TEASER":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TEASER", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_ECOTRONBOX":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_ECOTRONBOX", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_DIMMER":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_DIMMER", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_PLACEHOLDER":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLACEHOLDER", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RERAE_FURNI_CLICK":
                case "RERAE_FURNI_DOUBLE_CLICK":
                    handleRoomAdClick(_arg_1);
                    break;
                case "RERAE_TOOLTIP_SHOW":
                case "RERAE_TOOLTIP_HIDE":
                    handleRoomAdTooltip(_arg_1);
                    break;
                case "RETWE_REQUEST_CLOTHING_CHANGE":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_PLAYLIST_EDITOR":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING":
                    _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING", _local_5, _local_6, _arg_1.roomId);
                    processWidgetMessage(_local_9);
                    break;
                case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED":
                    _local_12 = _roomEngine.getRoomObject(_arg_1.roomId, _arg_1.objectId, _arg_1.category);
                    if (_local_12 != null)
                    {
                        _local_8 = _local_12.getModel().getNumber("furniture_owner_id");
                        _local_4 = _sessionDataManager.userId;
                        if (_local_8 == _local_4)
                        {
                            _local_9 = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED", _local_5, _local_6, _arg_1.roomId);
                            processWidgetMessage(_local_9);
                        };
                    };
                    break;
                case "RETWE_OPEN_WIDGET":
                case "RETWE_CLOSE_WIDGET":
                case "RETWE_OPEN_FURNI_CONTEXT_MENU":
                case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
                case "RETWE_REMOVE_DIMMER":
                case "ROSM_JUKEBOX_DISPOSE":
                case "RETWE_REQUEST_MANNEQUIN":
                case "ROSM_USE_PRODUCT_FROM_INVENTORY":
                case "ROSM_USE_PRODUCT_FROM_ROOM":
                case "RETWE_REQUEST_BACKGROUND_COLOR":
                case "RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING":
                case "RETWE_REQUEST_HIGH_SCORE_DISPLAY":
                case "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY":
                case "RETWE_REQUEST_INTERNAL_LINK":
                case "RETWE_REQUEST_ROOM_LINK":
                    processEvent(_arg_1);
            };
            if (_local_3 != null)
            {
                _local_2 = true;
                if ((_local_3 is RoomWidgetRoomObjectUpdateEvent))
                {
                    _local_11 = (_local_3 as RoomWidgetRoomObjectUpdateEvent).roomId;
                    _local_2 = (!(RoomId.isRoomPreviewerId(_local_11)));
                }
                else
                {
                    if ((_local_3 is RoomWidgetRoomEngineUpdateEvent))
                    {
                        _local_11 = (_local_3 as RoomWidgetRoomEngineUpdateEvent).roomId;
                        _local_2 = (!(RoomId.isRoomPreviewerId(_local_11)));
                    };
                };
                if (_local_2)
                {
                    events.dispatchEvent(_local_3);
                };
            };
        }

        private function checkFurniManipulationRights(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return (((_session.roomControllerLevel >= 1) || (_sessionDataManager.isAnyRoomController)) || (isOwnerOfFurniture(_roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3))));
        }

        public function roomEngineEventHandler(_arg_1:RoomEngineEvent):void
        {
            var _local_2:RoomWidgetUpdateEvent;
            switch (_arg_1.type)
            {
                case "REE_NORMAL_MODE":
                    _local_2 = new RoomWidgetRoomEngineUpdateEvent("RWREUE_NORMAL_MODE", _arg_1.roomId);
                    break;
                case "REE_GAME_MODE":
                    _local_2 = new RoomWidgetRoomEngineUpdateEvent("RWREUE_GAME_MODE", _arg_1.roomId);
            };
            if (_local_2 != null)
            {
                events.dispatchEvent(_local_2);
            };
        }

        public function createRoomView(_arg_1:int):void
        {
            var _local_15:Number;
            var _local_5:Number;
            var _local_14:Number;
            var _local_4:Number;
            var _local_13:Number;
            var _local_10:Number;
            var _local_8:Number;
            var _local_11:Number;
            var _local_6:IWindow;
            var _local_3:Rectangle = _layoutManager.roomViewRect;
            var _local_16:int = _local_3.width;
            var _local_22:int = _local_3.height;
            var _local_7:int = ((_session.isGameSession) ? 32 : 64);
            if (_SafeStr_4319.indexOf(_arg_1) >= 0)
            {
                return;
            };
            if ((((_session == null) || (_windowManager == null)) || (_roomEngine == null)))
            {
                return;
            };
            var _local_17:DisplayObject = _roomEngine.createRoomCanvas(_session.roomId, _arg_1, _local_16, _local_22, _local_7);
            if (_local_17 == null)
            {
                return;
            };
            var _local_18:RoomGeometry = (_roomEngine.getRoomCanvasGeometry(_session.roomId, _arg_1) as RoomGeometry);
            if (_local_18 != null)
            {
                _local_15 = _roomEngine.getRoomNumberValue(_session.roomId, "room_min_x");
                _local_5 = _roomEngine.getRoomNumberValue(_session.roomId, "room_max_x");
                _local_14 = _roomEngine.getRoomNumberValue(_session.roomId, "room_min_y");
                _local_4 = _roomEngine.getRoomNumberValue(_session.roomId, "room_max_y");
                _local_13 = ((_local_15 + _local_5) / 2);
                _local_10 = ((_local_14 + _local_4) / 2);
                _local_8 = 20;
                _local_13 = (_local_13 + (_local_8 - 1));
                _local_10 = (_local_10 + (_local_8 - 1));
                _local_11 = (Math.sqrt(((_local_8 * _local_8) + (_local_8 * _local_8))) * Math.tan((0.166666666666667 * 3.14159265358979)));
                _local_18.location = new Vector3d(_local_13, _local_10, _local_11);
            };
            var _local_20:XmlAsset = (_assets.getAssetByName("room_view_container_xml") as XmlAsset);
            if (_local_20 == null)
            {
                return;
            };
            var _local_9:IWindowContainer = (_windowManager.buildFromXML((_local_20.content as XML)) as IWindowContainer);
            if (_local_9 == null)
            {
                return;
            };
            _local_9.width = _local_16;
            _local_9.height = _local_22;
            _SafeStr_4322 = (_local_9.findChildByName("room_canvas_wrapper") as IDisplayObjectWrapper);
            if (_SafeStr_4322 == null)
            {
                return;
            };
            _SafeStr_4322.setDisplayObject(_local_17);
            if (_session.isGameSession)
            {
                _local_17.addEventListener("click", mouseEventHandler);
            };
            checkAndEnableMouseZoomEvent(_local_17);
            _SafeStr_4322.addEventListener("WME_CLICK", canvasMouseHandler);
            _SafeStr_4322.addEventListener("WME_DOUBLE_CLICK", canvasMouseHandler);
            _SafeStr_4322.addEventListener("WME_MOVE", canvasMouseHandler);
            _SafeStr_4322.addEventListener("WME_DOWN", canvasMouseHandler);
            _SafeStr_4322.addEventListener("WME_UP", canvasMouseHandler);
            _SafeStr_4322.addEventListener("WME_UP_OUTSIDE", canvasMouseHandler);
            _SafeStr_4322.addEventListener("WE_RESIZED", onRoomViewResized);
            var _local_19:Sprite = new Sprite();
            _local_19.mouseEnabled = false;
            _local_19.blendMode = "multiply";
            var _local_21:IDisplayObjectWrapper = (_local_9.findChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_local_21 == null)
            {
                return;
            };
            _local_21.setDisplayObject(_local_19);
            _local_21.addEventListener("WE_RESIZED", resizeColorizer);
            var _local_2:Sprite = new Sprite();
            _local_2.mouseEnabled = false;
            var _local_12:IDisplayObjectWrapper = (_local_9.findChildByName("background_wrapper") as IDisplayObjectWrapper);
            if (_local_12 == null)
            {
                return;
            };
            _local_12.setDisplayObject(_local_2);
            _local_12.addEventListener("WE_RESIZED", resizeBackgroundColorizer);
            if (_session.isSpectatorMode)
            {
                _local_6 = getSpectatorModeVisualization();
                if (_local_6 != null)
                {
                    _local_6.width = _local_9.width;
                    _local_6.height = _local_9.height;
                    _local_9.addChild(_local_6);
                };
            };
            _layoutManager.addRoomView(_local_9);
            _SafeStr_4319.push(_arg_1);
        }

        private function checkAndEnableMouseZoomEvent(_arg_1:DisplayObject):void
        {
            _arg_1.removeEventListener("mouseWheel", mouseWheelHandler);
            if (_sessionDataManager.isPerkAllowed("MOUSE_ZOOM"))
            {
                _arg_1.addEventListener("mouseWheel", mouseWheelHandler);
            };
        }

        private function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            var _local_3:Point;
            var _local_2:int;
            var _local_4:int;
            if ((((_arg_1.ctrlKey) && (!(_arg_1.altKey))) && (!(_arg_1.shiftKey))))
            {
                _SafeStr_4327 = (_SafeStr_4327 + ((_arg_1.delta == 0) ? 0 : ((_arg_1.delta < 0) ? -20 : 20)));
                _local_3 = new Point();
                _SafeStr_4322.getGlobalPosition(_local_3);
                _local_2 = (_arg_1.stageX - _local_3.x);
                _local_4 = (_arg_1.stageY - _local_3.y);
                _SafeStr_884 = new Point(_local_2, _local_4);
            };
        }

        private function resizeColorizer(_arg_1:WindowEvent):void
        {
            var _local_2:IDisplayObjectWrapper = (_arg_1.target as IDisplayObjectWrapper);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:Sprite = (_local_2.getDisplayObject() as Sprite);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.graphics.clear();
            _local_3.graphics.beginFill(_roomColor);
            _local_3.graphics.drawRect(0, 0, _local_2.width, _local_2.height);
            _local_3.graphics.endFill();
        }

        private function resizeBackgroundColorizer(_arg_1:WindowEvent):void
        {
            var _local_2:IDisplayObjectWrapper = (_arg_1.target as IDisplayObjectWrapper);
            if (_local_2 == null)
            {
                return;
            };
            fillBackgroundColorizer(_local_2);
        }

        private function fillBackgroundColorizer(_arg_1:IDisplayObjectWrapper):void
        {
            var _local_2:Sprite = (_arg_1.getDisplayObject() as Sprite);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.graphics.clear();
            _local_2.graphics.beginFill(_roomBackgroundColor);
            _local_2.graphics.drawRect(0, 0, _arg_1.width, _arg_1.height);
            _local_2.graphics.endFill();
        }

        public function setRoomViewColor(_arg_1:uint, _arg_2:int):void
        {
            var _local_5:IWindowContainer = (_layoutManager.getRoomView() as IWindowContainer);
            if (_local_5 == null)
            {
                return;
            };
            var _local_6:IDisplayObjectWrapper = (_local_5.getChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_local_6 == null)
            {
                return;
            };
            var _local_4:Sprite = (_local_6.getDisplayObject() as Sprite);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:int = ColorConverter.rgbToHSL(_arg_1);
            _local_3 = ((_local_3 & 0xFFFF00) + _arg_2);
            _arg_1 = ColorConverter.hslToRGB(_local_3);
            _roomColor = _arg_1;
            _local_4.graphics.clear();
            _local_4.graphics.beginFill(_arg_1);
            _local_4.graphics.drawRect(0, 0, _local_6.width, _local_6.height);
            _local_4.graphics.endFill();
        }

        public function setRoomBackgroundColor(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _roomBackgroundColor = ColorConverter.hslToRGB(((((_arg_1 & 0xFF) << 16) + ((_arg_2 & 0xFF) << 8)) + (_arg_3 & 0xFF)));
            var _local_4:IWindowContainer = (_layoutManager.getRoomView() as IWindowContainer);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IDisplayObjectWrapper = (_local_4.getChildByName("background_wrapper") as IDisplayObjectWrapper);
            if (_local_5 == null)
            {
                return;
            };
            if ((((_arg_1 == 0) && (_arg_2 == 0)) && (_arg_3 == 0)))
            {
                _local_5.visible = false;
            }
            else
            {
                _local_5.visible = true;
                fillBackgroundColorizer(_local_5);
            };
        }

        public function getFirstCanvasId():int
        {
            if (_SafeStr_4319 != null)
            {
                if (_SafeStr_4319.length > 0)
                {
                    return (_SafeStr_4319[0]);
                };
            };
            return (0);
        }

        public function getRoomViewRect():Rectangle
        {
            if (!_layoutManager)
            {
                return (null);
            };
            return (_layoutManager.roomViewRect);
        }

        public function addListenerToStage(_arg_1:String, _arg_2:Function):void
        {
            if ((((!(_SafeStr_4322)) || (!(_SafeStr_4322.getDisplayObject()))) || (!(_SafeStr_4322.getDisplayObject().stage))))
            {
                return;
            };
            _SafeStr_4322.getDisplayObject().stage.addEventListener(_arg_1, _arg_2, false, 0, true);
        }

        public function removeListenerFromStage(_arg_1:String, _arg_2:Function):void
        {
            if ((((!(_SafeStr_4322)) || (!(_SafeStr_4322.getDisplayObject()))) || (!(_SafeStr_4322.getDisplayObject().stage))))
            {
                return;
            };
            _SafeStr_4322.getDisplayObject().stage.removeEventListener(_arg_1, _arg_2);
        }

        public function canvasMouseHandler(_arg_1:WindowEvent):void
        {
            var _local_5:Point;
            var _local_3:int;
            var _local_7:int;
            var _local_6:Point;
            if (((_roomEngine == null) || (_session == null)))
            {
                return;
            };
            var _local_4:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_8:String = "";
            switch (_local_4.type)
            {
                case "WME_CLICK":
                    _local_8 = "click";
                    break;
                case "WME_DOUBLE_CLICK":
                    _local_8 = "doubleClick";
                    break;
                case "WME_DOWN":
                    _local_8 = "mouseDown";
                    break;
                case "WME_UP":
                case "WME_UP_OUTSIDE":
                    _local_8 = "mouseUp";
                    break;
                case "WME_MOVE":
                    _local_8 = "mouseMove";
                    break;
                default:
                    return;
            };
            var _local_2:IDisplayObjectWrapper = (_local_4.target as IDisplayObjectWrapper);
            if (_local_2 == _local_4.target)
            {
                _local_5 = new Point();
                _local_2.getGlobalPosition(_local_5);
                _local_3 = (_local_4.stageX - _local_5.x);
                _local_7 = (_local_4.stageY - _local_5.y);
                _roomEngine.setActiveRoom(_session.roomId);
                _roomEngine.handleRoomCanvasMouseEvent(_SafeStr_4319[0], _local_3, _local_7, _local_8, _local_4.altKey, _local_4.ctrlKey, _local_4.shiftKey, _local_4.buttonDown);
            };
            if (((_local_8 == "mouseMove") && (!(_SafeStr_4324 == null))))
            {
                _local_6 = new Point(_local_4.stageX, _local_4.stageY);
                _local_6.offset((-(_SafeStr_4324.width) / 2), 15);
                _SafeStr_4324.setGlobalPosition(_local_6);
            };
        }

        private function mouseEventHandler(_arg_1:MouseEvent):void
        {
            var _local_3:Point = new Point();
            _SafeStr_4322.getGlobalPosition(_local_3);
            var _local_2:int = (_arg_1.stageX - _local_3.x);
            var _local_4:int = (_arg_1.stageY - _local_3.y);
            _roomEngine.setActiveRoom(_session.roomId);
            _arg_1.stopImmediatePropagation();
            _roomEngine.handleRoomCanvasMouseEvent(_SafeStr_4319[0], _local_2, _local_4, _arg_1.type, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
        }

        private function onRoomViewResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window;
            _SafeStr_4326 = _local_2.rectangle;
            _roomEngine.modifyRoomCanvas(_session.roomId, _SafeStr_4319[0], _local_2.width, _local_2.height);
            if (_SafeStr_2821 == null)
            {
                _SafeStr_2821 = new Timer(1000, 1);
                _SafeStr_2821.addEventListener("timer", onResizeTimerEvent);
            }
            else
            {
                _SafeStr_2821.reset();
            };
            _SafeStr_2821.start();
        }

        private function onResizeTimerEvent(_arg_1:TimerEvent):void
        {
            var _local_2:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
            events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent(_local_2, _SafeStr_4326));
        }

        private function trackZooming(_arg_1:Boolean, _arg_2:Boolean):void
        {
            var _local_3:int;
            var _local_4:int;
            if (_SafeStr_4325)
            {
                _local_3 = getTimer();
                _local_4 = int(Math.round(((_local_3 - _zoomChangedMillis) / 1000)));
                if (_habboTracking != null)
                {
                    if (_arg_1)
                    {
                        if (_arg_2)
                        {
                            _habboTracking.trackGoogle("zoomEvent", "out");
                        };
                        _habboTracking.trackGoogle("zoomEnded", "in", _local_4);
                    }
                    else
                    {
                        if (_arg_2)
                        {
                            _habboTracking.trackGoogle("zoomEvent", "in");
                        };
                        _habboTracking.trackGoogle("zoomEnded", "out", _local_4);
                    };
                };
                _zoomChangedMillis = _local_3;
            };
        }

        private function onToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == "HTIE_ICON_ZOOM")
            {
                toggleZoom();
            };
        }

        private function toggleZoom():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:IRoomGeometry;
            if (_session != null)
            {
                if ((_roomEngine as Component).getBoolean("zoom.enabled"))
                {
                    _local_1 = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
                    _local_2 = ((_local_1 == 1) ? 0.5 : 1);
                    _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId, getFirstCanvasId(), _local_2);
                }
                else
                {
                    _local_3 = _roomEngine.getRoomCanvasGeometry(_session.roomId, getFirstCanvasId());
                    if (_local_3 != null)
                    {
                        trackZooming(_local_3.isZoomedIn(), true);
                        _local_3.performZoom();
                    };
                };
            };
        }

        public function update():void
        {
            var _local_6:Number;
            var _local_4:int;
            var _local_2:IRoomWidgetHandler;
            var _local_1:Number;
            var _local_7:Number;
            var _local_5:Number;
            if (_updateListeners == null)
            {
                return;
            };
            var _local_3:int = _updateListeners.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = (_updateListeners[_local_4] as IRoomWidgetHandler);
                if (_local_2 != null)
                {
                    _local_2.update();
                };
                _local_4++;
            };
            if (Math.abs(_SafeStr_4327) > 0.01)
            {
                _local_6 = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
                _local_1 = hibit(_local_6);
                _local_7 = (((_local_1 > 1) ? (_local_1 << 1) : 1) / 10);
                _local_5 = ((_SafeStr_4327 > 0) ? (_local_6 - _local_7) : (_local_6 + _local_7));
                _local_5 = Math.max(0.5, _local_5);
                _SafeStr_4328 = true;
                _SafeStr_4327 = (_SafeStr_4327 * 0.05);
                _roomEngine.setRoomCanvasScale(_session.roomId, getFirstCanvasId(), _local_5, _SafeStr_884, null, false, true);
            }
            else
            {
                if (_SafeStr_4328)
                {
                    _SafeStr_4328 = false;
                    _local_6 = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
                    if (_local_6 < 0.75)
                    {
                        _roomEngine.setRoomCanvasScale(_session.roomId, getFirstCanvasId(), 0.5, _SafeStr_884, null, false, true);
                    }
                    else
                    {
                        _roomEngine.setRoomCanvasScale(_session.roomId, getFirstCanvasId(), Math.round(_local_6), _SafeStr_884, null, false, true);
                    };
                };
            };
        }

        private function hibit(_arg_1:int):int
        {
            _arg_1 = (_arg_1 | (_arg_1 >> 1));
            _arg_1 = (_arg_1 | (_arg_1 >> 2));
            _arg_1 = (_arg_1 | (_arg_1 >> 4));
            _arg_1 = (_arg_1 | (_arg_1 >> 8));
            _arg_1 = (_arg_1 | (_arg_1 >> 16));
            return (_arg_1 - (_arg_1 >> 1));
        }

        private function getWindowName(_arg_1:int):String
        {
            return ("Room_Engine_Window_" + _arg_1);
        }

        private function createFilter(_arg_1:int, _arg_2:int):Array
        {
            var _local_3:BlurFilter = new BlurFilter(2, 2);
            return ([]);
        }

        private function getBitmapFilter(_arg_1:int, _arg_2:int):BitmapFilter
        {
            var _local_9:BitmapData = new BitmapData(_arg_1, _arg_2);
            _local_9.perlinNoise(_arg_1, _arg_2, 5, (Math.random() * 0x77359400), true, false);
            var _local_6:Point = new Point(0, 0);
            var _local_7:uint = 1;
            var _local_12:uint = _local_7;
            var _local_11:uint = _local_7;
            var _local_3:Number = (_arg_1 / 20);
            var _local_5:Number = (-(_arg_1) / 25);
            var _local_4:String = "color";
            var _local_8:uint;
            var _local_10:Number = 0;
            return (new DisplacementMapFilter(_local_9, _local_6, _local_12, _local_11, _local_3, _local_5, _local_4, _local_8, _local_10));
        }

        private function checkInterrupts():Boolean
        {
            if ((((!(_roomSessionManager == null)) && (!(_session == null))) && (_SafeStr_4323)))
            {
                _roomSessionManager.startSession(_session);
                processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUW_HIDE_LOADING_BAR"));
                return (true);
            };
            return (false);
        }

        private function handleRoomAdClick(_arg_1:RoomEngineObjectEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_4:IRoomObject = _roomEngine.getRoomObject(_arg_1.roomId, _arg_1.objectId, _arg_1.category);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:IRoomObjectModel = (_local_4.getModel() as IRoomObjectModel);
            var _local_2:String = _local_3.getString("furniture_ad_url");
            if (((_local_2 == null) || (!(_local_2.indexOf("http") == 0))))
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RERAE_FURNI_CLICK":
                    if (((_session.roomControllerLevel >= 1) || (_sessionDataManager.isAnyRoomController)))
                    {
                        return;
                    };
                    HabboWebTools.openWebPage(_local_2);
                    return;
                case "RERAE_FURNI_DOUBLE_CLICK":
                    if ((((!(_session.roomControllerLevel)) >= 1) && (!(_sessionDataManager.isAnyRoomController))))
                    {
                        return;
                    };
                    HabboWebTools.openWebPage(_local_2);
                    return;
            };
        }

        private function handleRoomAdTooltip(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_3:IRoomObject;
            var _local_4:String;
            var _local_5:IRoomObjectModel;
            var _local_2:String;
            if (_arg_1 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RERAE_TOOLTIP_SHOW":
                    if (_SafeStr_4324 != null)
                    {
                        return;
                    };
                    _local_3 = _roomEngine.getRoomObject(_arg_1.roomId, _arg_1.objectId, _arg_1.category);
                    if (_local_3 == null)
                    {
                        return;
                    };
                    _local_4 = _localization.getLocalization((_local_3.getType() + ".tooltip"), "${ads.roomad.tooltip}");
                    if (_local_4 == null)
                    {
                        _local_5 = (_local_3.getModel() as IRoomObjectModel);
                        _local_2 = _local_5.getString("furniture_ad_url");
                        if (((!(_local_2 == null)) && (_local_2.indexOf("http") == 0)))
                        {
                            _local_4 = _local_2;
                        };
                    };
                    if (_local_4 == null)
                    {
                        return;
                    };
                    _SafeStr_4324 = (_windowManager.createWindow("room_ad_tooltip", _local_4, 8, 0, 32) as IToolTipWindow);
                    _SafeStr_4324.setParamFlag(1, false);
                    _SafeStr_4324.visible = true;
                    _SafeStr_4324.center();
                    return;
                case "RERAE_TOOLTIP_HIDE":
                    if (_SafeStr_4324 == null)
                    {
                        return;
                    };
                    _SafeStr_4324.dispose();
                    _SafeStr_4324 = null;
                    return;
            };
        }

        private function getSpectatorModeVisualization():IWindow
        {
            var _local_2:XmlAsset = (_assets.getAssetByName("spectator_mode_xml") as XmlAsset);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_1:IWindowContainer = (_windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            if (_local_1 == null)
            {
                return (null);
            };
            setBitmap(_local_1.findChildByName("top_left"), "spec_top_left_png");
            setBitmap(_local_1.findChildByName("top_middle"), "spec_top_middle_png");
            setBitmap(_local_1.findChildByName("top_right"), "spec_top_right_png");
            setBitmap(_local_1.findChildByName("middle_left"), "spec_middle_left_png");
            setBitmap(_local_1.findChildByName("middle_right"), "spec_middle_right_png");
            setBitmap(_local_1.findChildByName("bottom_left"), "spec_bottom_left_png");
            setBitmap(_local_1.findChildByName("bottom_middle"), "spec_bottom_middle_png");
            setBitmap(_local_1.findChildByName("bottom_right"), "spec_bottom_right_png");
            return (_local_1);
        }

        private function setBitmap(_arg_1:IWindow, _arg_2:String):void
        {
            var _local_4:IBitmapWrapperWindow = (_arg_1 as IBitmapWrapperWindow);
            if (((_local_4 == null) || (_assets == null)))
            {
                return;
            };
            var _local_5:BitmapDataAsset = (_assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_5 == null)
            {
                return;
            };
            var _local_3:BitmapData = (_local_5.content as BitmapData);
            if (_local_3 == null)
            {
                return;
            };
            _local_4.bitmap = _local_3.clone();
        }

        public function initializeWidget(_arg_1:String, _arg_2:int=0):void
        {
            var _local_3:IRoomWidget = _SafeStr_1647[_arg_1];
            if (_local_3 == null)
            {
                Logger.log(("Tried to initialize an unknown widget " + _arg_1));
                return;
            };
            _local_3.initialize(_arg_2);
        }

        public function getWidgetState(_arg_1:String):int
        {
            var _local_2:IRoomWidget = _SafeStr_1647[_arg_1];
            if (_local_2 == null)
            {
                Logger.log(("Requested the state of an unknown widget " + _arg_1));
                return (-1);
            };
            return (_local_2.state);
        }

        public function addUpdateListener(_arg_1:IRoomWidgetHandler):void
        {
            if (_updateListeners == null)
            {
                _updateListeners = [];
            };
            if (_updateListeners.indexOf(_arg_1) == -1)
            {
                _updateListeners.push(_arg_1);
            };
        }

        public function removeUpdateListener(_arg_1:IRoomWidgetHandler):void
        {
            if (_updateListeners == null)
            {
                return;
            };
            var _local_2:int = _updateListeners.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                _updateListeners.splice(_local_2, 1);
            };
        }

        public function isOwnerOfFurniture(_arg_1:IRoomObject):Boolean
        {
            var _local_4:int = sessionDataManager.userId;
            var _local_3:IRoomObjectModel = _arg_1.getModel();
            if (_local_3 == null)
            {
                return (false);
            };
            var _local_2:Number = _local_3.getNumber("furniture_owner_id");
            return (_local_2 == _local_4);
        }

        public function getFurnitureOwnerId(_arg_1:IRoomObject):int
        {
            var _local_2:Number;
            var _local_3:IRoomObjectModel = _arg_1.getModel();
            if (_local_3 != null)
            {
                _local_2 = _local_3.getNumber("furniture_owner_id");
                if (!isNaN(_local_2))
                {
                    return (_local_2);
                };
            };
            return (-1);
        }

        public function isOwnerOfPet(_arg_1:IUserData):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_2:int = sessionDataManager.userId;
            return (_local_2 == _arg_1.ownerId);
        }

        public function showGamePlayerName(_arg_1:int, _arg_2:String, _arg_3:uint, _arg_4:int):void
        {
            var _local_5:AvatarInfoWidget = (_SafeStr_1647["RWE_AVATAR_INFO"] as AvatarInfoWidget);
            if (!_local_5)
            {
                return;
            };
            _local_5.showGamePlayerName(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function get layoutManager():DesktopLayoutManager
        {
            return (_layoutManager);
        }

        public function mouseEventPositionHasInputEventWindow(_arg_1:MouseEvent, _arg_2:int):Boolean
        {
            var _local_3:Array = new Array(0);
            var _local_4:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _windowManager.getDesktop(_arg_2).groupParameterFilteredChildrenUnderPoint(_local_4, _local_3, 1);
            return (_local_3.length > 1);
        }


    }
}


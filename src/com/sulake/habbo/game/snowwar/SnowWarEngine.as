package com.sulake.habbo.game.snowwar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.game.HabboGameManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.groups.IHabboGroupsManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.ui.IRoomUI;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
    import com.sulake.habbo.game.snowwar.ui.GameArenaView;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.game.snowwar.ui.GameLoadingViewController;
    import com.sulake.habbo.game.snowwar.ui.GameEndingViewController;
    import com.sulake.habbo.game.snowwar.ui.GamesMainViewController;
    import com.sulake.habbo.game.snowwar.leaderboard.LeaderboardViewController;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboRoomUI;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboGroupsManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2LoadStageReadyMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2StartSnowWarMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2CheckGameDirectoryStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2QuickJoinGameMessageComposer;
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2SetUserMoveTargetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2ThrowSnowballAtHumanMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2ThrowSnowballAtPositionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2MakeSnowballMessageComposer;
    import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
    import com.sulake.habbo.game.snowwar.events.NewMoveTargetEvent;
    import com.sulake.habbo.game.snowwar.utils.Location3D;
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2RequestFullStatusUpdateMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.game.snowwar.ui.GameLobbyWindowCtrl;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2PlayAgainMessageComposer;
    import com.sulake.habbo.game.events.GameChatEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.*;
    import com.sulake.habbo.communication.messages.outgoing.game.directory.*;
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.*;
    import com.sulake.habbo.communication.messages.outgoing.game.arena.*;

    public class SnowWarEngine extends Component implements IUpdateReceiver 
    {

        private static const GHOST_CHECKSUM_TURNS_TO_CHECK:int = 3;
        public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
        public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
        public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
        public static const STATE_INACTIVE:int = 0;
        public static const STATE_GAME_STARTING:int = 1;
        public static const STATE_STAGE_LOADING:int = 2;
        public static const STATE_STAGE_STARTING:int = 3;
        public static const STATE_STAGE_RUNNING:int = 4;
        public static const STATE_STAGE_ENDING:int = 5;
        public static const STATE_GAME_OVER:int = 6;
        public static const STATE_REJOIN_GAME:int = 7;

        private static var _soundManager:IHabboSoundManager;

        private var _gameManager:HabboGameManager;
        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _config:ICoreConfiguration;
        private var _localization:IHabboLocalizationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _avatarManager:IAvatarRenderManager;
        private var _groupsManager:IHabboGroupsManager;
        private var _roomEngine:IRoomEngine;
        private var _roomUI:IRoomUI;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_457:IncomingMessages;
        private var _habboHelp:IHabboHelp;
        private var _friendList:IHabboFriendList;
        private var _gameArena:SynchronizedGameArena;
        private var _SafeStr_2590:GameArenaView;
        private var _timeSinceLastUpdate:int;
        private var _SafeStr_2591:int = 0;
        private var _SafeStr_2592:IAlertDialog;
        private var _ownId:int;
        private var _players:Map;
        private var _currentSubTurn:int = 0;
        private var _SafeStr_2593:int = 0;
        private var _SafeStr_2594:int = 0;
        private var _serverChecksums:Map;
        private var _SafeStr_2595:Boolean = false;
        private var _SafeStr_2596:GameLoadingViewController;
        private var _SafeStr_2597:GameEndingViewController;
        private var _mainView:GamesMainViewController;
        private var _SafeStr_2598:LeaderboardViewController;
        private var _isGhostEnabled:Boolean = false;
        private var _isGhostVisualizationEnabled:Boolean = false;
        private var _SafeStr_2599:Boolean = false;
        private var _SafeStr_2600:Boolean = false;
        private var _stageLength:int;
        private var _SafeStr_2601:Boolean = false;
        private var _hasUnlimitedGames:Boolean = false;
        private var _freeGamesLeft:int = 0;
        private var _roomBeforeGame:int = -1;
        private var _SafeStr_2602:int = -1;
        private var _SafeStr_2603:Boolean = false;

        public function SnowWarEngine(_arg_1:HabboGameManager, _arg_2:IContext, _arg_3:uint=0, _arg_4:IAssetLibrary=null)
        {
            super(_arg_2, _arg_3, _arg_4);
            _gameManager = _arg_1;
            queueInterface(new IIDHabboWindowManager(), onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), onHabboCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), onLocalizationReady);
            queueInterface(new IIDHabboRoomSessionManager(), onRoomSessionManagerReady);
            queueInterface(new IIDSessionDataManager(), onSessionDataManagerReady);
            queueInterface(new IIDAvatarRenderManager(), onAvatarRenderedReady);
            queueInterface(new IIDRoomEngine(), onRoomEngineReady);
            queueInterface(new IIDHabboSoundManager(), onSoundManagerReady);
            queueInterface(new IIDHabboRoomUI(), onRoomUIReady);
            queueInterface(new IIDHabboCatalog(), onCatalogReady);
            queueInterface(new IIDHabboHelp(), onHabboHelpReady);
            queueInterface(new IIDHabboFriendList(), onFriendListReady);
            queueInterface(new IIDHabboGroupsManager(), onGroupsManagerReady);
            HabboGamesCom.log(("SnowWarEngine initialized: " + _arg_4));
            _mainView = new GamesMainViewController(this);
        }

        public static function playSound(_arg_1:String, _arg_2:int=0):void
        {
            if (_soundManager != null)
            {
                _soundManager.playSound(_arg_1, _arg_2);
            };
        }

        public static function stopSound(_arg_1:String):void
        {
            if (_soundManager != null)
            {
                _soundManager.stopSound(_arg_1);
            };
        }


        public function get gameCenterEnabled():Boolean
        {
            return (_gameManager.gameCenterEnabled);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get config():ICoreConfiguration
        {
            return (_config);
        }

        public function get avatarManager():IAvatarRenderManager
        {
            return (_avatarManager);
        }

        public function get groupsManager():IHabboGroupsManager
        {
            return (_groupsManager);
        }

        public function get roomUI():IRoomUI
        {
            return (_roomUI);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get friendList():IHabboFriendList
        {
            return (_friendList);
        }

        public function get gameArena():SynchronizedGameArena
        {
            return (_gameArena);
        }

        public function get currentSubTurn():int
        {
            return (_currentSubTurn);
        }

        public function get stageLength():int
        {
            return (_stageLength);
        }

        public function get roomBeforeGame():int
        {
            return (_roomBeforeGame);
        }

        public function get isGhostEnabled():Boolean
        {
            return (_isGhostEnabled);
        }

        public function get isGhostVisualizationEnabled():Boolean
        {
            return (_isGhostVisualizationEnabled);
        }

        public function getArenaName(_arg_1:GameLobbyData):String
        {
            var _local_2:String = ("snowwar.field.name." + _arg_1.fieldType);
            return (localization.getLocalization(_local_2, _local_2));
        }

        override public function dispose():void
        {
            if (_communication)
            {
                _communication.release(new IIDHabboCommunicationManager());
                _communication = null;
            };
            if (_windowManager)
            {
                _windowManager.release(new IIDHabboWindowManager());
                _windowManager = null;
            };
            if (_config)
            {
                _config.release(new IIDHabboConfigurationManager());
                _config = null;
            };
            if (_localization)
            {
                _localization.release(new IIDHabboLocalizationManager());
                _localization = null;
            };
            if (_roomSessionManager)
            {
                _roomSessionManager.release(new IIDHabboRoomSessionManager());
                _roomSessionManager = null;
            };
            if (_sessionDataManager != null)
            {
                _sessionDataManager.release(new IIDSessionDataManager());
                _sessionDataManager = null;
            };
            if (_roomEngine != null)
            {
                _roomEngine.events.removeEventListener("REE_OBJECTS_INITIALIZED", onRoomObjectsInitialized);
                _roomEngine.release(new IIDRoomEngine());
                _roomEngine = null;
            };
            if (_soundManager != null)
            {
                _soundManager.release(new IIDHabboSoundManager());
                _soundManager = null;
            };
            if (_habboHelp != null)
            {
                _habboHelp.release(new IIDHabboHelp());
                _habboHelp = null;
            };
            if (_avatarManager != null)
            {
                _avatarManager.release(new IIDAvatarRenderManager());
                _avatarManager = null;
            };
            if (_groupsManager != null)
            {
                _groupsManager.release(new IIDHabboGroupsManager());
                _groupsManager = null;
            };
            if (_roomUI != null)
            {
                _roomUI.release(new IIDHabboRoomUI());
                _roomUI = null;
            };
            if (_catalog != null)
            {
                _catalog.release(new IIDHabboCatalog());
                _catalog = null;
            };
            if (_friendList != null)
            {
                _friendList.release(new IIDHabboFriendList());
                _friendList = null;
            };
            if (_SafeStr_2592 != null)
            {
                _SafeStr_2592.dispose();
                _SafeStr_2592 = null;
            };
            if (_SafeStr_2597)
            {
                _SafeStr_2597.dispose();
                _SafeStr_2597 = null;
            };
            disposeLoadingView();
            if (_gameArena != null)
            {
                _gameArena.dispose();
                _gameArena = null;
            };
            if (_SafeStr_2590 != null)
            {
                _SafeStr_2590.dispose();
                _SafeStr_2590 = null;
            };
            if (_mainView)
            {
                _mainView.dispose();
                _mainView = null;
            };
            if (_SafeStr_457)
            {
                _SafeStr_457.dispose();
                _SafeStr_457 = null;
            };
            if (_SafeStr_2598)
            {
                _SafeStr_2598.dispose();
                _SafeStr_2598 = null;
            };
            super.dispose();
        }

        private function onWindowManagerReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _windowManager = (_arg_2 as IHabboWindowManager);
            WindowUtils.init(assets, _windowManager);
        }

        private function onHabboCommunicationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _communication = (_arg_2 as IHabboCommunicationManager);
            _SafeStr_457 = new IncomingMessages(this);
        }

        private function onConfigurationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _config = (_arg_2 as ICoreConfiguration);
            _isGhostEnabled = _config.getBoolean("snowwar.ghost.enabled");
            if (_isGhostEnabled)
            {
                _isGhostVisualizationEnabled = _config.getBoolean("snowwar.ghost.visualization.enabled");
                _SafeStr_2599 = _config.getBoolean("snowwar.ghost.immediate.enabled");
            };
            HabboGamesCom.logEnabled = _config.getBoolean("snowwar.log.enabled");
        }

        private function onLocalizationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            _localization = (_arg_2 as IHabboLocalizationManager);
        }

        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _sessionDataManager = (_arg_2 as ISessionDataManager);
        }

        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _roomSessionManager = (_arg_2 as IRoomSessionManager);
        }

        private function onAvatarRenderedReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _avatarManager = (_arg_2 as IAvatarRenderManager);
            _avatarManager.events.addEventListener("AVATAR_RENDER_READY", onAvatarReady);
        }

        private function onGroupsManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _groupsManager = (_arg_2 as IHabboGroupsManager);
        }

        private function onAvatarReady(_arg_1:Event):void
        {
            var _local_3:XmlAsset;
            var _local_2:Boolean = (context.assets as AssetLibraryCollection).hasAssetLibrary(assets.name);
            if (!_local_2)
            {
                HabboGamesCom.log(assets.manifest);
                (context.assets as AssetLibraryCollection).addAssetLibrary(assets);
                _local_3 = (assets.getAssetByName("figure") as XmlAsset);
                _avatarManager.injectFigureData((_local_3.content as XML));
                _avatarManager.resetAssetManager();
            };
        }

        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _roomEngine = (_arg_2 as IRoomEngine);
            _roomEngine.events.addEventListener("REE_OBJECTS_INITIALIZED", onRoomObjectsInitialized);
        }

        private function onRoomObjectsInitialized(_arg_1:RoomEngineEvent):void
        {
            if (_gameArena)
            {
                send(new Game2LoadStageReadyMessageComposer(100));
            };
        }

        public function send(_arg_1:IMessageComposer):void
        {
            if (_communication)
            {
                _communication.connection.send(_arg_1);
            };
        }

        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _soundManager = IHabboSoundManager(_arg_2);
        }

        private function onRoomUIReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _roomUI = (_arg_2 as IRoomUI);
        }

        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            _catalog = (_arg_2 as IHabboCatalog);
        }

        public function showGamesMainView():void
        {
            _mainView.toggleVisibility();
        }

        private function onHabboHelpReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _habboHelp = (_arg_2 as IHabboHelp);
        }

        private function onFriendListReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            _friendList = (_arg_2 as IHabboFriendList);
        }

        public function onGameDirectoryAvailable(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                showGamesMainView();
            };
        }

        public function initArena(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Array):void
        {
            if (!_gameArena)
            {
                _gameArena = new SynchronizedGameArena();
                _gameArena.setExtension(new SnowWarGameArena());
                _gameArena.initialize(this, _arg_3);
                _SafeStr_2590 = new GameArenaView(this);
                _roomSessionManager.disposeSession(-1, false);
                _roomSessionManager.startGameSession();
                registerUpdateReceiver(this, 1);
                _timeSinceLastUpdate = 0;
                _currentSubTurn = 0;
                _SafeStr_2593 = 0;
            };
        }

        public function startServerGame(_arg_1:String):void
        {
            initGameDirectoryConnection();
            send(new Game2StartSnowWarMessageComposer(_arg_1));
        }

        public function initGameDirectoryConnection():void
        {
            send(new Game2CheckGameDirectoryStatusMessageComposer());
        }

        public function startQuickServerGame():void
        {
            send(new Game2QuickJoinGameMessageComposer());
        }

        private function getCurrentStage():SnowWarGameStage
        {
            if (!_gameArena)
            {
                return (null);
            };
            return (_gameArena.getCurrentStage() as SnowWarGameStage);
        }

        public function getCurrentPlayer():HumanGameObject
        {
            return (getPlayer(_ownId));
        }

        public function getPlayer(_arg_1:int):HumanGameObject
        {
            var _local_2:SynchronizedGameStage = getCurrentStage();
            if (!_local_2)
            {
                return (null);
            };
            return (_local_2.getGameObject(_arg_1) as HumanGameObject);
        }

        public function handleClickOnTile(_arg_1:RoomObjectTileMouseEvent):void
        {
            if (_SafeStr_2591 != 4)
            {
                return;
            };
            var _local_2:int = _SafeStr_175.getClickTypeOnTile(_arg_1.altKey, _arg_1.shiftKey);
            if (_local_2 == 0)
            {
                moveOwnAvatarTo(_arg_1.tileXAsInt, _arg_1.tileYAsInt);
            }
            else
            {
                throwSnowballAt(_arg_1.tileXAsInt, _arg_1.tileYAsInt, getTrajectoryFromClickType(_local_2));
            };
        }

        public function handleClickOnHuman(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_7:HumanGameObject;
            var _local_4:HumanGameObject;
            var _local_6:int;
            if (_SafeStr_2591 != 4)
            {
                return;
            };
            var _local_5:HumanGameObject = getGhostPlayer();
            if (((_arg_1 == _ownId) || (((_isGhostEnabled) && (_local_5)) && (_arg_1 == _local_5.gameObjectId))))
            {
                if (((makeSnowball()) && (_SafeStr_2590)))
                {
                    _SafeStr_2590.startWaitingForSnowball();
                };
            }
            else
            {
                _local_7 = getCurrentPlayer();
                _local_4 = getPlayer(_arg_1);
                if ((((_local_7) && (_local_4)) && (!(_local_7.team == _local_4.team))))
                {
                    _local_6 = _SafeStr_175.getClickTypeOnOpponent(_arg_2, _arg_3);
                    throwSnowballAtHuman(_arg_1, getTrajectoryFromClickType(_local_6));
                };
            };
        }

        public function handleMouseOverOnHuman(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:HumanGameObject = getPlayer(_arg_1);
            if (!_local_6)
            {
                return;
            };
            if (_config.getBoolean("snowstorm.settings.show_user_names"))
            {
                _local_4 = ((_local_6.team == 1) ? 4281310921 : 4290988872);
                _local_5 = 500;
                _roomUI.showGamePlayerName(_local_6.gameObjectId, _local_6.name, _local_4, _local_5);
            };
            if (_SafeStr_2591 == 4)
            {
                _SafeStr_2590.updateTileCursor(_local_6.team);
            };
        }

        public function moveOwnAvatarTo(_arg_1:int, _arg_2:int):void
        {
            var _local_6:int;
            var _local_5:int;
            var _local_3:SnowWarGameStage;
            if (_SafeStr_2591 != 4)
            {
                return;
            };
            var _local_4:HumanGameObject = getCurrentPlayer();
            if (_local_4)
            {
                _local_6 = (_arg_1 * 3200);
                _local_5 = (_arg_2 * 3200);
                _local_3 = getCurrentStage();
                if (_local_3)
                {
                    send(new Game2SetUserMoveTargetMessageComposer(_local_6, _local_5, _gameArena.getTurnNumber(), _gameArena.subturn));
                    walkGhost(_local_4, _local_6, _local_5);
                };
            };
        }

        public function getGhostPlayer():HumanGameObject
        {
            var _local_1:HumanGameObject = getCurrentPlayer();
            if (_local_1)
            {
                return (getPlayer(_local_1.ghostObjectId));
            };
            return (null);
        }

        private function throwSnowballAtHuman(_arg_1:int, _arg_2:int):void
        {
            var _local_3:HumanGameObject = getCurrentPlayer();
            if (((_local_3) && (_local_3.canThrowSnowballs())))
            {
                send(new Game2ThrowSnowballAtHumanMessageComposer(_arg_1, _arg_2, _gameArena.getTurnNumber(), _gameArena.subturn));
                stopGhost();
            };
        }

        private function throwSnowballAt(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_6:int;
            var _local_5:int;
            var _local_4:HumanGameObject = getCurrentPlayer();
            if (((_local_4) && (_local_4.canThrowSnowballs())))
            {
                _local_6 = (_arg_1 * 3200);
                _local_5 = (_arg_2 * 3200);
                send(new Game2ThrowSnowballAtPositionMessageComposer(_local_6, _local_5, _arg_3, _gameArena.getTurnNumber(), _gameArena.subturn));
                stopGhost();
            };
        }

        private function getTrajectoryFromClickType(_arg_1:int):int
        {
            var _local_2:int;
            switch (_arg_1)
            {
                case 2:
                    _local_2 = 2;
                    break;
                case 3:
                    _local_2 = 1;
                    break;
                case 1:
                    _local_2 = 0;
                    break;
                default:
                    _local_2 = 3;
            };
            return (_local_2);
        }

        public function makeSnowball():Boolean
        {
            if (_SafeStr_2591 != 4)
            {
                return (false);
            };
            var _local_1:HumanGameObject = getCurrentPlayer();
            if (((_local_1) && (_local_1.canMakeSnowballs())))
            {
                send(new Game2MakeSnowballMessageComposer(_gameArena.getTurnNumber(), _gameArena.subturn));
                stopGhost();
                return (true);
            };
            return (false);
        }

        private function walkGhost(_arg_1:HumanGameObject, _arg_2:int, _arg_3:int):void
        {
            var _local_6:Boolean;
            var _local_4:HumanGameObject;
            var _local_5:ISynchronizedGameEvent;
            if (_isGhostEnabled)
            {
                _local_6 = (((_arg_1) && (!(_arg_1.posture == "swdieback"))) && (!(_arg_1.posture == "swdiefront")));
                _local_4 = getGhostPlayer();
                if (((_local_4) && (_local_6)))
                {
                    _local_5 = new NewMoveTargetEvent(_local_4, _arg_2, _arg_3);
                    if (_SafeStr_2599)
                    {
                        _local_5.apply(gameArena.getCurrentStage());
                    }
                    else
                    {
                        gameArena.addGameEvent(gameArena.getTurnNumber(), gameArena.subturn, _local_5);
                    };
                };
            };
        }

        private function stopGhost():void
        {
            var _local_1:HumanGameObject;
            if (_isGhostEnabled)
            {
                _local_1 = getGhostPlayer();
                if (_local_1)
                {
                    _local_1.stopMovement();
                };
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_9:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_3:Boolean;
            var _local_10:Boolean;
            var _local_2:int;
            var _local_4:uint;
            if ((((!(_gameArena)) || ((!(_SafeStr_2591)) == 4)) || ((!(_SafeStr_2591)) == 3)))
            {
                return;
            };
            if (((_SafeStr_2590) && (_SafeStr_2591 == 3)))
            {
                _SafeStr_2590.update(_arg_1, (_gameArena.subturn == 0));
            };
            _timeSinceLastUpdate = (_timeSinceLastUpdate + _arg_1);
            var _local_8:int = (_gameArena.getExtension() as SnowWarGameArena).getPulseInterval();
            if ((((!(_SafeStr_2595)) && (_timeSinceLastUpdate > _local_8)) && (_currentSubTurn < _SafeStr_2593)))
            {
                _gameArena.pulse();
                _timeSinceLastUpdate = (_timeSinceLastUpdate - _local_8);
                _currentSubTurn++;
                if (_timeSinceLastUpdate > _local_8)
                {
                    _timeSinceLastUpdate = 0;
                };
                _local_9 = (_SafeStr_2593 - currentSubTurn);
                while (_local_9-- > 3)
                {
                    _gameArena.pulse();
                    _currentSubTurn++;
                };
                if (((_SafeStr_2590) && (_SafeStr_2591 == 4)))
                {
                    _SafeStr_2590.update(_arg_1, (_gameArena.subturn == 0));
                };
                if ((_currentSubTurn % _gameArena.getNumberOfSubTurns()) == 0)
                {
                    _local_5 = (gameArena.getTurnNumber() - 1);
                    _local_6 = gameArena.getCheckSum(_local_5);
                    _local_7 = _serverChecksums[_local_5];
                    checkGhostLocation(_local_5);
                    _local_3 = (_local_5 < (_SafeStr_2594 - 3));
                    _local_10 = (!(_local_7 == _local_6));
                    if ((((_local_3) || (_local_10)) || (_SafeStr_2600)))
                    {
                        HabboGamesCom.log(((((((((("Turn: " + [_local_5, _SafeStr_2594]) + " currentSubTurn:") + _currentSubTurn) + " maxSubTurn:") + _SafeStr_2593) + " serverChecksum:") + _local_7) + " clientChecksum:") + _local_6));
                        if (_local_3)
                        {
                            _local_2 = 0;
                            _local_4 = 0xFF00FF;
                            HabboGamesCom.log("CLIENT TOO MUCH BEHIND, requesting full status!");
                        }
                        else
                        {
                            if (_local_10)
                            {
                                _local_2 = 1;
                                _local_4 = 0xFF0000;
                                HabboGamesCom.log("CHECKSUM MISMATCH, requesting full status!");
                            }
                            else
                            {
                                _local_2 = -1;
                                _local_4 = 0xFF;
                                HabboGamesCom.log("ERROR WAS GENERATED! Requesting full status!");
                            };
                        };
                        _SafeStr_2590.showChecksumError(_local_4);
                        requestFullStatus(_local_2);
                        _SafeStr_2600 = false;
                        _SafeStr_2595 = true;
                    };
                };
            };
        }

        private function checkGhostLocation(_arg_1:int):void
        {
            var _local_3:HumanGameObject;
            var _local_6:Location3D;
            var _local_2:HumanGameObject;
            var _local_5:Boolean;
            var _local_4:int;
            if (_isGhostEnabled)
            {
                _local_3 = getCurrentPlayer();
                _local_6 = _local_3.currentLocation;
                _local_2 = getGhostPlayer();
                _local_5 = false;
                _local_4 = -3;
                while (_local_4 < 3)
                {
                    _local_5 = _local_2.isInGhostDistance((_arg_1 + _local_4), _local_6);
                    if (_local_5) break;
                    _local_4++;
                };
                _local_2.removeGhostLocation((_arg_1 - 3));
                if (((!(_local_5)) && (_arg_1 > 3)))
                {
                    HabboGamesCom.log(((("GHOST CHECKSUM MISMATCH, checksumTurn:" + _arg_1) + " currentLocation:") + _local_6));
                    _local_2.reinitGhost(_local_3);
                    _local_2.addGhostLocation(_arg_1);
                    _SafeStr_2590.showChecksumError(0xFF00);
                };
            };
        }

        public function nextTurn(_arg_1:int, _arg_2:int, _arg_3:Boolean=false):void
        {
            _SafeStr_2594 = _arg_1;
            _serverChecksums[_SafeStr_2594] = _arg_2;
            _SafeStr_2593 = ((_arg_1 + 1) * gameArena.getNumberOfSubTurns());
            if (_arg_3)
            {
                _currentSubTurn = (_SafeStr_2593 - gameArena.getNumberOfSubTurns());
                _timeSinceLastUpdate = (gameArena.getExtension() as SnowWarGameArena).getPulseInterval();
                _SafeStr_2595 = false;
                if (_isGhostEnabled)
                {
                    getGhostPlayer().addGhostLocation(_SafeStr_2594);
                };
            };
        }

        public function requestFullStatus(_arg_1:int):void
        {
            send(new Game2RequestFullStatusUpdateMessageComposer(_arg_1));
        }

        public function alert(_arg_1:String):void
        {
            removeOldAlert();
            if (!_SafeStr_2592)
            {
                _SafeStr_2592 = _windowManager.alert("SnowWar Alert", _arg_1, 0, onAlertClose);
            }
            else
            {
                _SafeStr_2592.summary = _arg_1;
            };
            HabboGamesCom.log(("[HabboGameManager.alert] " + _arg_1));
        }

        public function disposeLoadingView():void
        {
            if (_SafeStr_2596)
            {
                _SafeStr_2596.dispose();
                _SafeStr_2596 = null;
            };
        }

        public function removeOldAlert():void
        {
            if (_SafeStr_2592)
            {
                _SafeStr_2592.dispose();
                _SafeStr_2592 = null;
            };
        }

        public function generateChecksumMismatch():void
        {
            if (_SafeStr_2591 != 4)
            {
                return;
            };
            _SafeStr_2600 = true;
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            removeOldAlert();
        }

        public function set ownId(_arg_1:int):void
        {
            _ownId = _arg_1;
        }

        public function get ownId():int
        {
            return (_ownId);
        }

        public function initView():void
        {
            if (_SafeStr_2590)
            {
                _SafeStr_2590.init();
            };
        }

        public function get mainView():GamesMainViewController
        {
            return (_mainView);
        }

        public function get lobbyView():GameLobbyWindowCtrl
        {
            if (_mainView)
            {
                return (_mainView.lobbyView);
            };
            return (null);
        }

        public function stageLoading(_arg_1:int, _arg_2:Array):void
        {
            if (_SafeStr_2596 != null)
            {
                _SafeStr_2591 = 2;
                _SafeStr_2596.showReadyPlayers(_arg_2);
            };
        }

        public function startStage(_arg_1:int):void
        {
            if (_SafeStr_2590)
            {
                _roomUI.visible = true;
                disposeLoadingView();
                playSound("HBSTG_ig_countdown");
                _SafeStr_2590.initGameUI(_arg_1);
                _SafeStr_2591 = 3;
            };
        }

        public function stageRunning(_arg_1:int):void
        {
            if (_arg_1 > 0)
            {
                _stageLength = _arg_1;
                _SafeStr_2591 = 4;
            }
            else
            {
                _SafeStr_2591 = 5;
            };
            _currentSubTurn = 0;
            _SafeStr_2593 = 0;
        }

        public function resetGameSession():void
        {
            _roomEngine.isGameMode = false;
            _SafeStr_2591 = 5;
            removeUpdateReceiver(this);
            if (_gameArena)
            {
                _gameArena.dispose();
                _gameArena = null;
            };
            stopSound("HBSTG_snowwar_walk");
            send(new Game2GetAccountGameStatusMessageComposer(0));
        }

        public function resetRoomSession():void
        {
            _roomSessionManager.disposeGameSession();
            if (_SafeStr_2590)
            {
                _SafeStr_2590.dispose();
                _SafeStr_2590 = null;
            };
        }

        public function gameOver(_arg_1:int, _arg_2:Array, _arg_3:Game2SnowWarGameStats, _arg_4:Game2GameResult):void
        {
            _SafeStr_2591 = 6;
            _mainView.close(false);
            if (_SafeStr_2597)
            {
                _SafeStr_2597.dispose();
                _SafeStr_2597 = null;
            };
            if (_SafeStr_2590)
            {
                _SafeStr_2590.removeGameUI();
            };
            _SafeStr_2597 = new GameEndingViewController(this, _arg_2, _arg_3, _arg_4, _arg_1);
        }

        public function gameStarted(_arg_1:GameLobbyData):void
        {
            _SafeStr_2591 = 1;
            _SafeStr_2601 = false;
            _players = new Map();
            _serverChecksums = new Map();
            for each (var _local_2:GameLobbyPlayerData in _arg_1.players)
            {
                _players.add(_local_2.userId, _local_2);
            };
            if (_SafeStr_2597)
            {
                _SafeStr_2597.dispose();
                _SafeStr_2597 = null;
            };
            if (!_SafeStr_2596)
            {
                _SafeStr_2596 = new GameLoadingViewController(this);
            };
            _SafeStr_2596.show(_arg_1);
        }

        public function rejoinGame(_arg_1:int):void
        {
            _SafeStr_2591 = ((_SafeStr_2601) ? 7 : 6);
            _roomBeforeGame = _arg_1;
            if (_SafeStr_2597)
            {
                _SafeStr_2597.changeToWaitState(_SafeStr_2601);
                _SafeStr_2601 = false;
            };
        }

        public function playerRematches(_arg_1:int):void
        {
            if (_SafeStr_2597)
            {
                _SafeStr_2597.playerRematches(_arg_1);
            };
        }

        public function startLobbyCounter(_arg_1:int):void
        {
            if (((_SafeStr_2591 == 7) && (!(_SafeStr_2597 == null))))
            {
                _SafeStr_2597.startLobbyCountDown(_arg_1);
            }
            else
            {
                if (lobbyView)
                {
                    lobbyView.startCountdown(_arg_1);
                };
            };
        }

        public function sendRejoinGame():void
        {
            _SafeStr_2601 = true;
            send(new Game2PlayAgainMessageComposer());
        }

        public function addChatMessage(_arg_1:int, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_6:GameLobbyPlayerData = _players.getValue(_arg_1);
            var _local_5:int = ((_local_6.teamId == 1) ? -300 : 300);
            var _local_4:uint = ((_local_6.teamId == 1) ? 0xFF : 0xFF0000);
            _gameManager.events.dispatchEvent(new GameChatEvent("gce_game_chat", _arg_1, _arg_2, _local_5, _local_4, _local_6.figure, _local_6.gender, _local_6.name, _local_6.teamId, _arg_3));
        }

        public function stopLobbyCounter():void
        {
            if (((_SafeStr_2591 == 7) && (!(_SafeStr_2597 == null))))
            {
                _SafeStr_2601 = true;
                _SafeStr_2597.changeToWaitState(_SafeStr_2601);
            }
            else
            {
                if (lobbyView)
                {
                    lobbyView.stopCountdown();
                };
            };
        }

        public function createLobby(_arg_1:GameLobbyData):void
        {
            var _local_2:GameLobbyPlayerData;
            if (_SafeStr_2591 == 6)
            {
                _SafeStr_2601 = true;
            };
            if (((!(_SafeStr_2597 == null)) && (!(_SafeStr_2591 == 7))))
            {
                _SafeStr_2597.changeToWaitState(_SafeStr_2601);
                _SafeStr_2591 = 7;
                _SafeStr_2601 = false;
            };
            if (((_SafeStr_2591 == 7) && (!(_SafeStr_2597 == null))))
            {
                _SafeStr_2597.changeToLobbyState(_arg_1);
                for each (_local_2 in _arg_1.players)
                {
                    _SafeStr_2597.playerJoined(_local_2);
                };
            }
            else
            {
                _SafeStr_2591 = 0;
                mainView.openGameLobbyWindow(getArenaName(_arg_1), _arg_1.numberOfTeams, _arg_1.maximumPlayers);
                for each (_local_2 in _arg_1.players)
                {
                    lobbyView.playerJoined(_local_2);
                };
            };
        }

        public function userJoined(_arg_1:GameLobbyPlayerData):void
        {
            if (((_SafeStr_2591 == 7) && (!(_SafeStr_2597 == null))))
            {
                _SafeStr_2597.playerJoined(_arg_1);
            }
            else
            {
                _SafeStr_2591 = 0;
                if (lobbyView)
                {
                    lobbyView.playerJoined(_arg_1);
                };
            };
        }

        public function userLeft(_arg_1:int):void
        {
            if (((_SafeStr_2591 == 7) && (!(_SafeStr_2597 == null))))
            {
                _SafeStr_2597.playerLeft(_arg_1);
            }
            else
            {
                _SafeStr_2591 = 0;
                if (lobbyView)
                {
                    lobbyView.playerLeft(_arg_1);
                };
            };
        }

        public function gamesLeft(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
        {
            if (_arg_1 == 0)
            {
                _hasUnlimitedGames = _arg_2;
                _freeGamesLeft = _arg_3;
                if (_SafeStr_2597)
                {
                    _SafeStr_2597.updateGamesLeft();
                };
                if (_mainView)
                {
                    _mainView.updateGameStartingStatus();
                };
            };
        }

        public function get isGameStarting():Boolean
        {
            return ((_SafeStr_2591 == 1) || (_SafeStr_2591 == 7));
        }

        public function resetSession():void
        {
            resetGameSession();
            resetRoomSession();
            if (_SafeStr_2597)
            {
                _SafeStr_2597.dispose();
                _SafeStr_2597 = null;
            };
            if (_mainView)
            {
                _mainView.openMainWindow(false);
            };
        }

        public function gameCancelled(_arg_1:Boolean):void
        {
            resetSession();
            if (_arg_1)
            {
                _gameManager.onSnowWarArenaSessionEnded();
            };
        }

        public function get hasUnlimitedGames():Boolean
        {
            return (_hasUnlimitedGames);
        }

        public function get freeGamesLeft():int
        {
            return (_freeGamesLeft);
        }

        public function stopWaitingForSnowball(_arg_1:int):void
        {
            if (((!(_SafeStr_2590 == null)) && (_arg_1 == _ownId)))
            {
                _SafeStr_2590.stopWaitingForSnowball();
            };
        }

        public function openGetMoreGames(_arg_1:String):void
        {
            _catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
            logGameEvent(_arg_1);
        }

        public function openClubCenter(_arg_1:String):void
        {
            _catalog.openClubCenter();
            logGameEvent(_arg_1);
        }

        public function logGameEvent(_arg_1:String):void
        {
            send(new EventLogMessageComposer("GameFramework", "SnowStorm", _arg_1, "", freeGamesLeft));
        }

        public function registerHit(_arg_1:HumanGameObject, _arg_2:HumanGameObject):void
        {
            if (_ownId == _arg_1.gameObjectId)
            {
                _SafeStr_2590.flashOwnScore(false);
            }
            else
            {
                if (_ownId == _arg_2.gameObjectId)
                {
                    _SafeStr_2590.flashOwnScore(true);
                };
            };
        }

        public function set gamesPlayed(_arg_1:int):void
        {
            _SafeStr_2602 = _arg_1;
        }

        public function promoteGame():void
        {
            if (((_SafeStr_2603) || (!(_SafeStr_2602 == 0))))
            {
                return;
            };
            _SafeStr_2603 = true;
            var _local_2:Boolean = (_config.getInteger("new.identity", 0) > 0);
            var _local_1:String = _config.getProperty("new.user.wing");
            if (((_local_2) && (!(_local_1 == "game"))))
            {
                return;
            };
            _habboHelp.showWelcomeScreen("HTIE_ICON_GAMES", "snowwar.promotion", 0, "GAMES");
        }

        public function showLeaderboard():void
        {
            leaderboard.selectedGame = 0;
            leaderboard.showFriendsAllTime();
        }

        public function get leaderboard():LeaderboardViewController
        {
            if (((!(_SafeStr_2598)) && (!(gameCenterEnabled))))
            {
                _SafeStr_2598 = new LeaderboardViewController(this);
            };
            return (_SafeStr_2598);
        }


    }
}


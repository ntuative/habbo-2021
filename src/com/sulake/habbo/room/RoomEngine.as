package com.sulake.habbo.room
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.IRoomManagerListener;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.room.renderer.IRoomRendererFactory;
    import com.sulake.room.IRoomManager;
    import com.sulake.room.IRoomObjectFactory;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.room.utils.NumberBank;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDRoomObjectFactory;
    import com.sulake.iid.IIDRoomObjectVisualizationFactory;
    import com.sulake.iid.IIDRoomManager;
    import com.sulake.iid.IIDRoomRendererFactory;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboGameManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import __AS3__.vec.Vector;
    import flash.display.DisplayObjectContainer;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import com.sulake.habbo.room.utils.RoomInstanceData;
    import com.sulake.habbo.room.utils.FurniStackingHeightMap;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.room.utils.TileObjectMap;
    import com.sulake.habbo.room.utils.RoomCamera;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.room.IRoomInstance;
    import com.sulake.room.utils.RoomEnterEffect;
    import flash.ui.Mouse;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
    import com.sulake.habbo.room.utils.FurnitureData;
    import com.sulake.room.RoomInstance;
    import flash.utils.getTimer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.IRoomRenderingCanvas;
    import flash.geom.Rectangle;
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.room.utils.RoomData;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
    import flash.display.Sprite;
    import com.sulake.room.renderer.IRoomRenderer;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.events.RoomEngineDragWithMouseEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import flash.display.Bitmap;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.habbo.room.object.RoomObjectUserTypes;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage;
    import com.sulake.habbo.room.object.data._SafeStr_80;
    import com.sulake.habbo.room.messages.RoomObjectModelDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectHeightUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.utils.FurniId;
    import com.sulake.habbo.room.object.data.LegacyStuffData;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.events.RoomToObjectOwnAvatarMoveEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarOwnMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarMutedUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarExpressionUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayingGameMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarGuideStatusUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
    import flash.utils.ByteArray;
    import flash.net.FileReference;
    import com.sulake.core.utils.PlayerVersionCheck;
    import com.sulake.core.utils.images.PNGEncoder;
    import com.sulake.habbo.avatar.pets.PetCustomPart;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.utils.RoomObjectBadgeImageAssetListener;
    import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
    import com.sulake.habbo.room.utils.SpriteDataCollector;
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.iid.*;
    import com.sulake.room.object.*;

        public class RoomEngine extends Component implements IRoomEngine, IRoomManagerListener, IRoomCreator, IRoomEngineServices, IUpdateReceiver, IRoomContentListener
    {

        public static const SETUP_WITHOUT_TOOLBAR:uint = 1;
        public static const _SafeStr_1415:uint = 2;
        public static const SETUP_WITHOUT_GAME_MANAGER:uint = 4;
        public static const _SafeStr_1416:uint = 5;
        private static const ROOM_TEMP_ID:String = "temporary_room";
        public static const OBJECT_ID_ROOM:int = -1;
        private static const OBJECT_TYPE_ROOM:String = "room";
        private static const OBJECT_ID_ROOM_HIGHLIGHTER:int = -2;
        private static const OBJECT_TYPE_ROOM_HIGHLIGHTER:String = "tile_cursor";
        private static const _SafeStr_3641:int = -3;
        private static const _SafeStr_3642:String = "selection_arrow";
        private static const _SafeStr_3643:String = "overlay";
        private static const _SafeStr_3644:String = "object_icon_sprite";
        private static const ROOM_DRAG_THRESHOLD:int = 15;
        private static const _SafeStr_3645:int = 40;

        private var _communication:IHabboCommunicationManager = null;
        private var _roomRendererFactory:IRoomRendererFactory = null;
        private var _roomManager:IRoomManager = null;
        private var _roomObjectFactory:IRoomObjectFactory = null;
        private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
        private var _adManager:IAdManager = null;
        private var _sessionDataManager:ISessionDataManager = null;
        private var _roomSessionManager:IRoomSessionManager = null;
        private var _toolbar:IHabboToolbar = null;
        private var _catalog:IHabboCatalog = null;
        private var _windowManager:IHabboWindowManager;
        private var _eventHandler:RoomObjectEventHandler = null;
        private var _SafeStr_419:RoomMessageHandler = null;
        private var _roomContentLoader:RoomContentLoader = null;
        private var _SafeStr_3646:Boolean = false;
        private var _SafeStr_420:NumberBank;
        private var _SafeStr_422:Map;
        private var _SafeStr_421:NumberBank;
        private var _SafeStr_423:Map;
        private var _isInitialized:Boolean = false;
        protected var _SafeStr_418:int = 0;
        private var _SafeStr_430:int = -1;
        private var _SafeStr_431:int = 0;
        private var _SafeStr_432:int = 0;
        private var _SafeStr_427:Boolean = false;
        private var _SafeStr_433:Boolean = false;
        private var _SafeStr_435:int = 0;
        private var _SafeStr_436:int = 0;
        private var _SafeStr_428:int = 0;
        private var _SafeStr_429:int = 0;
        private var _roomDraggingAlwaysCenters:Boolean = false;
        private var _SafeStr_424:Map = null;
        private var _SafeStr_425:Map = null;
        private var _skipFurnitureCreationForNextFrame:Boolean = false;
        private var _mouseCursorUpdate:Boolean;
        private var _SafeStr_426:Map = null;
        private var _gameEngine:IHabboGameManager;
        private var _isGameMode:Boolean;
        private var _playerUnderCursor:int = -1;
        private var _mouseEventsDisabledAboveY:int = 0;
        private var _mouseEventsDisabledLeftToX:int = 0;
        private var _SafeStr_3647:int = 0;
        private var _SafeStr_434:int = 0;

        public function RoomEngine(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
        }

        public function get mouseEventsDisabledAboveY():int
        {
            return (_mouseEventsDisabledAboveY);
        }

        public function set mouseEventsDisabledAboveY(_arg_1:int):void
        {
            _mouseEventsDisabledAboveY = _arg_1;
        }

        public function get mouseEventsDisabledLeftToX():int
        {
            return (_mouseEventsDisabledLeftToX);
        }

        public function set mouseEventsDisabledLeftToX(_arg_1:int):void
        {
            _mouseEventsDisabledLeftToX = _arg_1;
        }

        public function get isInitialized():Boolean
        {
            return (_isInitialized);
        }

        public function get connection():IConnection
        {
            return (_communication.connection);
        }

        public function get activeRoomId():int
        {
            return (_SafeStr_418);
        }

        public function get roomManager():IRoomManager
        {
            return (_roomManager);
        }

        public function get configuration():ICoreConfiguration
        {
            return (this);
        }

        protected function get eventHandler():RoomObjectEventHandler
        {
            return (_eventHandler);
        }

        private function get useOffsetScrolling():Boolean
        {
            return (true);
        }

        public function get gameEngine():IHabboGameManager
        {
            return (_gameEngine);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDRoomObjectFactory(), function (_arg_1:IRoomObjectFactory):void
            {
                _roomObjectFactory = _arg_1;
            }), new ComponentDependency(new IIDRoomObjectVisualizationFactory(), function (_arg_1:IRoomObjectVisualizationFactory):void
            {
                _visualizationFactory = _arg_1;
            }), new ComponentDependency(new IIDRoomManager(), function (_arg_1:IRoomManager):void
            {
                _roomManager = _arg_1;
            }), new ComponentDependency(new IIDRoomRendererFactory(), function (_arg_1:IRoomRendererFactory):void
            {
                _roomRendererFactory = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }, ((flags & 0x05) == 0)), new ComponentDependency(new IIDHabboConfigurationManager(), null, true, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }]), new ComponentDependency(new IIDHabboAdManager(), function (_arg_1:IAdManager):void
            {
                _adManager = _arg_1;
            }, false, [{
                "type":"AE_ROOM_AD_SHOW",
                "callback":showRoomAd
            }, {
                "type":"AE_ROOM_AD_IMAGE_LOADED",
                "callback":onRoomAdImageLoaded
            }, {
                "type":"AE_ROOM_AD_IMAGE_LOADING_FAILED",
                "callback":onRoomAdImageLoaded
            }]), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, false, [{
                "type":"RSE_STARTED",
                "callback":onRoomSessionEvent
            }, {
                "type":"RSE_ENDED",
                "callback":onRoomSessionEvent
            }]), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }, false, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":onToolbarClicked
            }]), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }, false), new ComponentDependency(new IIDHabboGameManager(), function (_arg_1:IHabboGameManager):void
            {
                _gameEngine = _arg_1;
            }, ((flags & 0x04) == 0)), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _SafeStr_425 = new Map();
            _SafeStr_420 = new NumberBank(1000);
            _SafeStr_421 = new NumberBank(1000);
            _SafeStr_422 = new Map();
            _SafeStr_423 = new Map();
            _SafeStr_424 = new Map();
            _eventHandler = createRoomObjectEventHandlerInstance();
            _SafeStr_419 = new RoomMessageHandler(this);
            registerUpdateReceiver(this, 1);
            _roomObjectFactory.addObjectEventListener(roomObjectEventHandler);
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
            if (_roomContentLoader)
            {
                _roomContentLoader.dispose();
                events.removeEventListener("RCL_LOADER_READY", onContentLoaderReady);
            };
            var _local_2:DisplayObjectContainer = context.displayObjectContainer;
            var _local_3:LoaderInfo = _local_2.loaderInfo;
            _roomContentLoader = new RoomContentLoader(_local_3.loaderURL);
            _roomContentLoader.initialize(events, this);
            _roomContentLoader.iconAssets = assets;
            _roomContentLoader.iconListener = this;
            _roomContentLoader.visualizationFactory = _visualizationFactory;
            _roomManager.addObjectUpdateCategory(10);
            _roomManager.addObjectUpdateCategory(20);
            _roomManager.addObjectUpdateCategory(100);
            _roomManager.addObjectUpdateCategory(200);
            _roomManager.addObjectUpdateCategory(0);
            _roomManager.setContentLoader(_roomContentLoader);
            if (((_SafeStr_419) && (_communication)))
            {
                _SafeStr_419.connection = _communication.connection;
            };
            _roomDraggingAlwaysCenters = getBoolean("room.dragging.always_center");
            _roomContentLoader.sessionDataManager = _sessionDataManager;
            events.addEventListener("RCL_LOADER_READY", onContentLoaderReady);
        }

        protected function createRoomObjectEventHandlerInstance():RoomObjectEventHandler
        {
            return (new RoomObjectEventHandler(this));
        }

        override public function dispose():void
        {
            var _local_2:int;
            var _local_1:RoomInstanceData;
            if (disposed)
            {
                return;
            };
            removeUpdateReceiver(this);
            if (_SafeStr_420 != null)
            {
                _SafeStr_420.dispose();
                _SafeStr_420 = null;
            };
            if (_SafeStr_421 != null)
            {
                _SafeStr_421.dispose();
                _SafeStr_421 = null;
            };
            if (_SafeStr_422 != null)
            {
                _SafeStr_422.dispose();
            };
            if (_SafeStr_423 != null)
            {
                _SafeStr_423.dispose();
            };
            if (_eventHandler != null)
            {
                _eventHandler.dispose();
                _eventHandler = null;
            };
            if (_SafeStr_419 != null)
            {
                _SafeStr_419.dispose();
                _SafeStr_419 = null;
            };
            if (_roomContentLoader != null)
            {
                _roomContentLoader.dispose();
                _roomContentLoader = null;
            };
            if (_SafeStr_424 != null)
            {
                _SafeStr_424.dispose();
                _SafeStr_424 = null;
            };
            if (_SafeStr_425 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_425.length)
                {
                    _local_1 = (_SafeStr_425.getWithIndex(_local_2) as RoomInstanceData);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_425.dispose();
                _SafeStr_425 = null;
            };
            if (_SafeStr_426 != null)
            {
                _SafeStr_426.dispose();
                _SafeStr_426 = null;
            };
            super.dispose();
        }

        public function set disableUpdate(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                removeUpdateReceiver(this);
            }
            else
            {
                removeUpdateReceiver(this);
                registerUpdateReceiver(this, 1);
            };
        }

        public function runUpdate():void
        {
            update(1);
        }

        private function getRoomInstanceData(_arg_1:int):RoomInstanceData
        {
            var _local_2:String = getRoomIdentifier(_arg_1);
            var _local_3:RoomInstanceData;
            if (_SafeStr_425 != null)
            {
                _local_3 = (_SafeStr_425.getValue(_local_2) as RoomInstanceData);
                if (_local_3 == null)
                {
                    _local_3 = new RoomInstanceData(_arg_1);
                    _SafeStr_425.add(_local_2, _local_3);
                };
            };
            return (_local_3);
        }

        public function setFurniStackingHeightMap(_arg_1:int, _arg_2:FurniStackingHeightMap):void
        {
            var _local_3:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_3 != null)
            {
                _local_3.furniStackingHeightMap = _arg_2;
            };
        }

        public function getFurniStackingHeightMap(_arg_1:int):FurniStackingHeightMap
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.furniStackingHeightMap);
            };
            return (null);
        }

        public function setWorldType(_arg_1:int, _arg_2:String):void
        {
            var _local_3:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_3 != null)
            {
                _local_3.worldType = _arg_2;
            };
        }

        public function getWorldType(_arg_1:int):String
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.worldType);
            };
            return (null);
        }

        public function getLegacyGeometry(_arg_1:int):LegacyWallGeometry
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.legacyGeometry);
            };
            return (null);
        }

        public function getTileObjectMap(_arg_1:int):TileObjectMap
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.tileObjectMap);
            };
            return (null);
        }

        private function getActiveRoomCamera():RoomCamera
        {
            return (getRoomCamera(_SafeStr_418));
        }

        private function getRoomCamera(_arg_1:int):RoomCamera
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.roomCamera);
            };
            return (null);
        }

        public function setSelectedObjectData(_arg_1:int, _arg_2:SelectedRoomObjectData):void
        {
            var _local_3:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_3 != null)
            {
                _local_3.selectedObject = _arg_2;
                if (_arg_2 != null)
                {
                    _local_3.placedObject = null;
                };
            };
        }

        public function getSelectedObjectData(_arg_1:int):ISelectedRoomObjectData
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.selectedObject);
            };
            return (null);
        }

        public function setPlacedObjectData(_arg_1:int, _arg_2:SelectedRoomObjectData):void
        {
            var _local_3:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_3 != null)
            {
                _local_3.placedObject = _arg_2;
            };
        }

        public function getPlacedObjectData(_arg_1:int):ISelectedRoomObjectData
        {
            var _local_2:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.placedObject);
            };
            return (null);
        }

        public function addObjectUpdateCategory(_arg_1:int):void
        {
            _roomManager.addObjectUpdateCategory(_arg_1);
        }

        public function removeObjectUpdateCategory(_arg_1:int):void
        {
            _roomManager.removeObjectUpdateCategory(_arg_1);
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            var _local_3:IRoomInstance;
            RoomEnterEffect.turnVisualizationOn();
            if (_roomManager != null)
            {
                createRoomFurniture();
                _roomManager.update(_arg_1);
                _local_2 = 0;
                while (_local_2 < _roomManager.getRoomCount())
                {
                    _local_3 = _roomManager.getRoomWithIndex(_local_2);
                    if (((!(_local_3 == null)) && (!(_local_3.getRenderer() == null))))
                    {
                        _local_3.getRenderer().update(_arg_1);
                    };
                    _local_2++;
                };
                updateRoomCameras(_arg_1);
                if (_mouseCursorUpdate)
                {
                    updateMouseCursor();
                };
            };
            RoomEnterEffect.turnVisualizationOff();
        }

        private function updateMouseCursor():void
        {
            _mouseCursorUpdate = false;
            var _local_1:RoomInstanceData = getRoomInstanceData(_SafeStr_418);
            if (((_local_1) && (_local_1.hasButtonMouseCursorOwners())))
            {
                Mouse.cursor = "button";
            }
            else
            {
                Mouse.cursor = "auto";
            };
        }

        public function requestMouseCursor(_arg_1:String, _arg_2:int, _arg_3:String):void
        {
            var _local_4:int = getRoomObjectCategory(_arg_3);
            switch (_arg_1)
            {
                case "ROFCAE_MOUSE_BUTTON":
                    if (((isGameMode) && (_local_4 == 100)))
                    {
                        _playerUnderCursor = _arg_2;
                    };
                    addButtonMouseCursorOwner(_SafeStr_418, _local_4, _arg_2);
                    return;
                default:
                    if (((isGameMode) && (_local_4 == 100)))
                    {
                        _playerUnderCursor = -1;
                    };
                    removeButtonMouseCursorOwner(_SafeStr_418, _local_4, _arg_2);
                    return;
            };
        }

        private function addButtonMouseCursorOwner(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:String;
            var _local_4:RoomInstanceData;
            var _local_6:IRoomSession = _roomSessionManager.getSession(_arg_1);
            if ((((!(_arg_2 == 10)) && (!(_arg_2 == 20))) || ((!(_local_6 == null)) && (_local_6.roomControllerLevel >= 1))))
            {
                _local_5 = ((_arg_2 + "_") + _arg_3);
                _local_4 = getRoomInstanceData(_arg_1);
                if (_local_4 != null)
                {
                    if (_local_4.addButtonMouseCursorOwner(_local_5))
                    {
                        _mouseCursorUpdate = true;
                    };
                };
            };
        }

        private function removeButtonMouseCursorOwner(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:String;
            var _local_4:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_4 != null)
            {
                _local_5 = ((_arg_2 + "_") + _arg_3);
                if (_local_4.removeButtonMouseCursorOwner(_local_5))
                {
                    _mouseCursorUpdate = true;
                };
            };
        }

        public function addFloorHole(_arg_1:int, _arg_2:int):void
        {
            var _local_8:IRoomObjectController;
            var _local_9:IRoomObjectController;
            var _local_5:String;
            var _local_3:int;
            var _local_4:int;
            var _local_7:int;
            var _local_6:int;
            if (_arg_2 >= 0)
            {
                _local_8 = getObjectRoom(_arg_1);
                _local_9 = getObjectFurniture(_arg_1, _arg_2);
                if (((((!(_local_9 == null)) && (!(_local_9.getModel() == null))) && (!(_local_8 == null))) && (!(_local_8.getEventHandler() == null))))
                {
                    _local_5 = "RORPFHUM_ADD";
                    _local_3 = _local_9.getLocation().x;
                    _local_4 = _local_9.getLocation().y;
                    _local_7 = _local_9.getModel().getNumber("furniture_size_x");
                    _local_6 = _local_9.getModel().getNumber("furniture_size_y");
                    _local_8.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_local_5, _arg_2, _local_3, _local_4, _local_7, _local_6));
                };
            };
        }

        public function removeFloorHole(_arg_1:int, _arg_2:int):void
        {
            var _local_4:IRoomObjectController;
            var _local_3:String;
            if (_arg_2 >= 0)
            {
                _local_4 = getObjectRoom(_arg_1);
                if (((!(_local_4 == null)) && (!(_local_4.getEventHandler() == null))))
                {
                    _local_3 = "RORPFHUM_REMOVE";
                    _local_4.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_local_3, _arg_2));
                };
            };
        }

        private function createRoomFurniture():void
        {
            var _local_6:int;
            _local_6 = 5;
            var _local_1:int;
            var _local_4:int;
            var _local_3:FurnitureData;
            var _local_9:Boolean;
            var _local_7:String;
            var _local_8:RoomInstance;
            if (_skipFurnitureCreationForNextFrame)
            {
                _skipFurnitureCreationForNextFrame = false;
                return;
            };
            var _local_5:int = getTimer();
            for each (var _local_2:RoomInstanceData in _SafeStr_425)
            {
                _local_4 = 0;
                _local_3 = null;
                _local_9 = false;
                while ((_local_3 = _local_2.getFurnitureData()) != null)
                {
                    _local_9 = addObjectFurnitureFromData(_local_2.roomId, _local_3.id, _local_3);
                    if ((++_local_4 % 5) == 0)
                    {
                        _local_1 = getTimer();
                        if ((((_local_1 - _local_5) >= 40) && (!(_isGameMode))))
                        {
                            _skipFurnitureCreationForNextFrame = true;
                            break;
                        };
                    };
                };
                while (((!(_skipFurnitureCreationForNextFrame)) && (!((_local_3 = _local_2.getWallItemData()) == null))))
                {
                    _local_9 = addObjectWallItemFromData(_local_2.roomId, _local_3.id, _local_3);
                    if ((++_local_4 % 5) == 0)
                    {
                        _local_1 = getTimer();
                        if ((((_local_1 - _local_5) >= 40) && (!(_isGameMode))))
                        {
                            _skipFurnitureCreationForNextFrame = true;
                            break;
                        };
                    };
                };
                if (((_local_9) && (_isGameMode)))
                {
                    _local_7 = getRoomIdentifier(_local_2.roomId);
                    _local_8 = (_roomManager.getRoom(_local_7) as RoomInstance);
                    if (!_local_8.hasUninitializedObjects())
                    {
                        objectsInitialized(_local_7);
                    };
                };
                if (_skipFurnitureCreationForNextFrame)
                {
                    return;
                };
            };
        }

        private function updateRoomCameras(_arg_1:uint):void
        {
            var _local_8:int;
            var _local_3:RoomInstanceData;
            var _local_7:RoomCamera;
            var _local_9:int;
            var _local_6:int;
            var _local_4:int;
            var _local_10:IRoomObject;
            var _local_2:int = 1;
            _local_8 = 0;
            while (_local_8 < _SafeStr_425.length)
            {
                _local_3 = (_SafeStr_425.getWithIndex(_local_8) as RoomInstanceData);
                _local_7 = null;
                _local_9 = 0;
                if (_local_3 != null)
                {
                    _local_7 = _local_3.roomCamera;
                    _local_9 = _local_3.roomId;
                };
                if (_local_7 != null)
                {
                    _local_6 = _local_7.targetId;
                    _local_4 = _local_7.targetCategory;
                    _local_10 = getRoomObject(_local_9, _local_6, _local_4);
                    if (_local_10 != null)
                    {
                        if (((!(_local_9 == _SafeStr_418)) || (!(_SafeStr_427))))
                        {
                            updateRoomCamera(_local_9, _local_2, _local_10.getLocation(), _arg_1);
                        };
                    };
                };
                _local_8++;
            };
            var _local_5:IRoomRenderingCanvas = getRoomCanvas(_SafeStr_418, _local_2);
            if (_local_5 != null)
            {
                if (_SafeStr_427)
                {
                    _local_5.screenOffsetX = (_local_5.screenOffsetX + _SafeStr_428);
                    _local_5.screenOffsetY = (_local_5.screenOffsetY + _SafeStr_429);
                    _SafeStr_428 = 0;
                    _SafeStr_429 = 0;
                };
            };
        }

        private function updateRoomCamera(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:uint):void
        {
            var _local_46:Number;
            var _local_18:Rectangle;
            var _local_26:int;
            var _local_25:int;
            var _local_41:Rectangle;
            var _local_6:Vector3d;
            var _local_31:Number;
            var _local_32:Number;
            var _local_9:Number;
            var _local_27:Number;
            var _local_22:Number;
            var _local_21:Number;
            var _local_19:Number;
            var _local_34:Point;
            var _local_17:Number;
            var _local_20:Number;
            var _local_12:Matrix;
            var _local_36:Number;
            var _local_38:Number;
            var _local_42:Number;
            var _local_40:Number;
            var _local_10:Number;
            var _local_8:Number;
            var _local_5:Point;
            var _local_44:Boolean;
            var _local_43:Boolean;
            var _local_24:Boolean;
            var _local_23:Boolean;
            var _local_14:Number;
            var _local_13:Number;
            var _local_33:Number;
            var _local_37:Number;
            var _local_28:Number;
            var _local_15:int;
            var _local_16:int;
            var _local_39:Point;
            var _local_29:Vector3d;
            var _local_30:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            var _local_7:RoomInstanceData = getRoomInstanceData(_arg_1);
            if ((((_local_30 == null) || (_local_7 == null)) || (!(_local_30.scale == 1))))
            {
                return;
            };
            var _local_45:RoomGeometry = (_local_30.geometry as RoomGeometry);
            var _local_11:RoomCamera = _local_7.roomCamera;
            var _local_35:IRoomInstance = getRoom(_arg_1);
            if ((((!(_local_45 == null)) && (!(_local_11 == null))) && (!(_local_35 == null))))
            {
                _local_46 = (Math.floor(_arg_3.z) + 1);
                _local_18 = getRoomCanvasRectangle(_arg_1, _arg_2);
                if (_local_18 != null)
                {
                    _local_26 = Math.round(_local_18.width);
                    _local_25 = Math.round(_local_18.height);
                    _local_41 = getActiveRoomBoundingRectangle(_arg_2);
                    if (((!(_local_41 == null)) && ((((_local_41.right < 0) || (_local_41.bottom < 0)) || (_local_41.left >= _local_26)) || (_local_41.top >= _local_25))))
                    {
                        _local_11.reset();
                    };
                    if (((((((!(_local_11.screenWd == _local_26)) || (!(_local_11.screenHt == _local_25))) || (!(_local_11.scale == _local_45.scale))) || (!(_local_11.geometryUpdateId == _local_45.updateId))) || (!(Vector3d.isEqual(_arg_3, _local_11.targetObjectLoc)))) || (_local_11.isMoving)))
                    {
                        _local_11.targetObjectLoc = _arg_3;
                        _local_6 = new Vector3d();
                        _local_6.assign(_arg_3);
                        _local_6.x = Math.round(_local_6.x);
                        _local_6.y = Math.round(_local_6.y);
                        _local_31 = (_local_35.getNumber("room_min_x") - 0.5);
                        _local_32 = (_local_35.getNumber("room_min_y") - 0.5);
                        _local_9 = (_local_35.getNumber("room_max_x") + 0.5);
                        _local_27 = (_local_35.getNumber("room_max_y") + 0.5);
                        _local_22 = Math.round(((_local_31 + _local_9) / 2));
                        _local_21 = Math.round(((_local_32 + _local_27) / 2));
                        _local_19 = 2;
                        _local_34 = new Point((_local_6.x - _local_22), (_local_6.y - _local_21));
                        _local_17 = (_local_45.scale / Math.sqrt(2));
                        _local_20 = (_local_17 / 2);
                        _local_12 = new Matrix();
                        _local_12.rotate(((-(_local_45.direction.x + 90) / 180) * 3.14159265358979));
                        _local_34 = _local_12.transformPoint(_local_34);
                        _local_34.y = (_local_34.y * (_local_20 / _local_17));
                        _local_36 = (((_local_18.width / 2) / _local_17) - 1);
                        _local_38 = (((_local_18.height / 2) / _local_20) - 1);
                        _local_42 = 0;
                        _local_40 = 0;
                        _local_10 = 0;
                        _local_8 = 0;
                        _local_5 = _local_45.getScreenPoint(new Vector3d(_local_22, _local_21, _local_19));
                        if (!_local_5)
                        {
                            return;
                        };
                        _local_5.x = (_local_5.x + Math.round((_local_18.width / 2)));
                        _local_5.y = (_local_5.y + Math.round((_local_18.height / 2)));
                        if (_local_41 != null)
                        {
                            _local_41.offset(-(_local_30.screenOffsetX), -(_local_30.screenOffsetY));
                            if (((_local_41.width > 1) && (_local_41.height > 1)))
                            {
                                _local_42 = (((_local_41.left - _local_5.x) - (_local_45.scale * 0.25)) / _local_17);
                                _local_10 = (((_local_41.right - _local_5.x) + (_local_45.scale * 0.25)) / _local_17);
                                _local_40 = (((_local_41.top - _local_5.y) - (_local_45.scale * 0.5)) / _local_20);
                                _local_8 = (((_local_41.bottom - _local_5.y) + (_local_45.scale * 0.5)) / _local_20);
                            }
                            else
                            {
                                _local_45.adjustLocation(new Vector3d(-30, -30), 25);
                                return;
                            };
                        }
                        else
                        {
                            _local_45.adjustLocation(new Vector3d(0, 0), 25);
                            return;
                        };
                        _local_44 = false;
                        _local_43 = false;
                        _local_24 = false;
                        _local_23 = false;
                        _local_14 = Math.round(((_local_10 - _local_42) * _local_17));
                        if (_local_14 < _local_18.width)
                        {
                            _local_46 = 2;
                            _local_34.x = ((_local_10 + _local_42) / 2);
                            _local_24 = true;
                        }
                        else
                        {
                            if (_local_34.x > (_local_10 - _local_36))
                            {
                                _local_34.x = (_local_10 - _local_36);
                                _local_44 = true;
                            };
                            if (_local_34.x < (_local_42 + _local_36))
                            {
                                _local_34.x = (_local_42 + _local_36);
                                _local_44 = true;
                            };
                        };
                        _local_13 = Math.round(((_local_8 - _local_40) * _local_20));
                        if (_local_13 < _local_18.height)
                        {
                            _local_46 = 2;
                            _local_34.y = ((_local_8 + _local_40) / 2);
                            _local_23 = true;
                        }
                        else
                        {
                            if (_local_34.y > (_local_8 - _local_38))
                            {
                                _local_34.y = (_local_8 - _local_38);
                                _local_43 = true;
                            };
                            if (_local_34.y < (_local_40 + _local_38))
                            {
                                _local_34.y = (_local_40 + _local_38);
                                _local_43 = true;
                            };
                            if (_local_43)
                            {
                                _local_34.y = (_local_34.y / (_local_20 / _local_17));
                            };
                        };
                        _local_12.invert();
                        _local_34 = _local_12.transformPoint(_local_34);
                        _local_34.x = (_local_34.x + _local_22);
                        _local_34.y = (_local_34.y + _local_21);
                        _local_33 = 0.35;
                        _local_37 = 0.2;
                        _local_28 = 0.2;
                        _local_15 = 10;
                        _local_16 = 10;
                        if ((_local_28 * _local_26) > 100)
                        {
                            _local_28 = (100 / _local_26);
                        };
                        if ((_local_33 * _local_25) > 150)
                        {
                            _local_33 = (150 / _local_25);
                        };
                        if ((_local_37 * _local_25) > 150)
                        {
                            _local_37 = (150 / _local_25);
                        };
                        if ((((_local_11.limitedLocationX) && (_local_11.screenWd == _local_26)) && (_local_11.screenHt == _local_25)))
                        {
                            _local_28 = 0;
                        };
                        if ((((_local_11.limitedLocationY) && (_local_11.screenWd == _local_26)) && (_local_11.screenHt == _local_25)))
                        {
                            _local_33 = 0;
                            _local_37 = 0;
                        };
                        _local_18.right = (_local_18.right * (1 - (_local_28 * 2)));
                        _local_18.bottom = (_local_18.bottom * (1 - (_local_33 + _local_37)));
                        if (_local_18.right < _local_15)
                        {
                            _local_18.right = _local_15;
                        };
                        if (_local_18.bottom < _local_16)
                        {
                            _local_18.bottom = _local_16;
                        };
                        if ((_local_33 + _local_37) > 0)
                        {
                            _local_18.offset((-(_local_18.width) / 2), (-(_local_18.height) * (_local_37 / (_local_33 + _local_37))));
                        }
                        else
                        {
                            _local_18.offset((-(_local_18.width) / 2), (-(_local_18.height) / 2));
                        };
                        _local_5 = _local_45.getScreenPoint(_local_6);
                        if (!_local_5)
                        {
                            return;
                        };
                        if (_local_5 != null)
                        {
                            _local_5.x = (_local_5.x + _local_30.screenOffsetX);
                            _local_5.y = (_local_5.y + _local_30.screenOffsetY);
                            _local_6.z = _local_46;
                            _local_6.x = (Math.round((_local_34.x * 2)) / 2);
                            _local_6.y = (Math.round((_local_34.y * 2)) / 2);
                            if (_local_11.location == null)
                            {
                                _local_45.location = _local_6;
                                if (useOffsetScrolling)
                                {
                                    _local_11.initializeLocation(new Vector3d(0, 0, 0));
                                }
                                else
                                {
                                    _local_11.initializeLocation(_local_6);
                                };
                            };
                            _local_39 = _local_45.getScreenPoint(_local_6);
                            _local_29 = new Vector3d(0, 0, 0);
                            if (_local_39 != null)
                            {
                                _local_29.x = _local_39.x;
                                _local_29.y = _local_39.y;
                            };
                            if (((((((((_local_5.x < _local_18.left) || (_local_5.x > _local_18.right)) && (!(_local_11.centeredLocX))) || (((_local_5.y < _local_18.top) || (_local_5.y > _local_18.bottom)) && (!(_local_11.centeredLocY)))) || (((_local_24) && (!(_local_11.centeredLocX))) && (!(_local_11.screenWd == _local_26)))) || (((_local_23) && (!(_local_11.centeredLocY))) && (!(_local_11.screenHt == _local_25)))) || ((!(_local_11.roomWd == _local_41.width)) || (!(_local_11.roomHt == _local_41.height)))) || ((!(_local_11.screenWd == _local_26)) || (!(_local_11.screenHt == _local_25)))))
                            {
                                _local_11.limitedLocationX = _local_44;
                                _local_11.limitedLocationY = _local_43;
                                if (useOffsetScrolling)
                                {
                                    _local_11.target = _local_29;
                                }
                                else
                                {
                                    _local_11.target = _local_6;
                                };
                            }
                            else
                            {
                                if (!_local_44)
                                {
                                    _local_11.limitedLocationX = false;
                                };
                                if (!_local_43)
                                {
                                    _local_11.limitedLocationY = false;
                                };
                            };
                        };
                        _local_11.centeredLocX = _local_24;
                        _local_11.centeredLocY = _local_23;
                        _local_11.screenWd = _local_26;
                        _local_11.screenHt = _local_25;
                        _local_11.scale = _local_45.scale;
                        _local_11.geometryUpdateId = _local_45.updateId;
                        _local_11.roomWd = _local_41.width;
                        _local_11.roomHt = _local_41.height;
                        if (!_sessionDataManager.isRoomCameraFollowDisabled)
                        {
                            if (useOffsetScrolling)
                            {
                                _local_11.update(_arg_4, 8);
                            }
                            else
                            {
                                _local_11.update(_arg_4, 0.5);
                            };
                        };
                        if (useOffsetScrolling)
                        {
                            _local_30.screenOffsetX = -(_local_11.location.x);
                            _local_30.screenOffsetY = -(_local_11.location.y);
                        }
                        else
                        {
                            _local_45.adjustLocation(_local_11.location, 25);
                        };
                    }
                    else
                    {
                        _local_11.limitedLocationX = false;
                        _local_11.limitedLocationY = false;
                        _local_11.centeredLocX = false;
                        _local_11.centeredLocY = false;
                    };
                };
            };
        }

        private function onContentLoaderReady(_arg_1:Event):void
        {
            _SafeStr_3646 = true;
            _roomManager.initialize(<nothing/>
            , this);
        }

        private function onRoomSessionEvent(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type)
            {
                case "RSE_STARTED":
                    if (_SafeStr_419)
                    {
                        _SafeStr_419.setCurrentRoom(_arg_1.session.roomId);
                    };
                    return;
                case "RSE_ENDED":
                    if (_SafeStr_419)
                    {
                        _SafeStr_419.resetCurrentRoom();
                        disposeRoom(_arg_1.session.roomId);
                    };
                    return;
            };
        }

        private function onToolbarClicked(_arg_1:HabboToolbarEvent):void
        {
            var _local_2:RoomCamera;
            if (_arg_1.iconId == "HTIE_ICON_MEMENU")
            {
                _local_2 = getActiveRoomCamera();
                if (_local_2)
                {
                    _local_2.activateFollowing(cameraFollowDuration);
                    _local_2.reset();
                };
            };
        }

        public function roomManagerInitialized(_arg_1:Boolean):void
        {
            var _local_3:int;
            var _local_2:RoomData;
            if (_arg_1)
            {
                _isInitialized = true;
                events.dispatchEvent(new RoomEngineEvent("REE_ENGINE_INITIALIZED", 0));
                _local_3 = 0;
                while (_local_3 < _SafeStr_424.length)
                {
                    _local_2 = (_SafeStr_424.getWithIndex(_local_3) as RoomData);
                    if (_local_2 != null)
                    {
                        initializeRoom(_local_2.roomId, _local_2.data);
                    };
                    _local_3++;
                };
            }
            else
            {
                Logger.log("[RoomEngine] Failed to initialize manager");
            };
        }

        public function setActiveRoom(_arg_1:int):void
        {
            _SafeStr_418 = _arg_1;
        }

        public function getRoomIdentifier(_arg_1:int):String
        {
            return (String(_arg_1));
        }

        private function getRoomId(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split("_");
                if (_local_2.length > 0)
                {
                    return (_local_2[0]);
                };
            };
            return (-1);
        }

        public function getRoomNumberValue(_arg_1:int, _arg_2:String):Number
        {
            var _local_3:IRoomInstance = getRoom(_arg_1);
            if (_local_3 != null)
            {
                return (_local_3.getNumber(_arg_2));
            };
            return (NaN);
        }

        public function getRoomStringValue(_arg_1:int, _arg_2:String):String
        {
            var _local_3:IRoomInstance = getRoom(_arg_1);
            if (_local_3 != null)
            {
                return (_local_3.getString(_arg_2));
            };
            return (null);
        }

        public function setIsPlayingGame(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:int;
            var _local_4:IRoomInstance = getRoom(_arg_1);
            if (_local_4 != null)
            {
                _local_3 = ((_arg_2) ? 1 : 0);
                _local_4.setNumber("is_playing_game", _local_3);
                if (_local_3 == 0)
                {
                    events.dispatchEvent(new RoomEngineEvent("REE_NORMAL_MODE", _arg_1));
                }
                else
                {
                    events.dispatchEvent(new RoomEngineEvent("REE_GAME_MODE", _arg_1));
                };
            };
        }

        public function getIsPlayingGame(_arg_1:int):Boolean
        {
            var _local_2:Number;
            var _local_3:IRoomInstance = getRoom(_arg_1);
            if (_local_3 != null)
            {
                _local_2 = _local_3.getNumber("is_playing_game");
                if (_local_2 > 0)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getActiveRoomIsPlayingGame():Boolean
        {
            return (getIsPlayingGame(_SafeStr_418));
        }

        public function getRoom(_arg_1:int):IRoomInstance
        {
            if (!_isInitialized)
            {
                return (null);
            };
            var _local_2:String = getRoomIdentifier(_arg_1);
            return (_roomManager.getRoom(_local_2));
        }

        public function initializeRoom(_arg_1:int, _arg_2:XML):void
        {
            var _local_3:String = getRoomIdentifier(_arg_1);
            var _local_5:RoomData;
            var _local_6:String = "111";
            var _local_7:String = "201";
            var _local_4:String = "1";
            if (!_isInitialized)
            {
                _local_5 = _SafeStr_424.remove(_local_3);
                if (_local_5 != null)
                {
                    _local_6 = _local_5.floorType;
                    _local_7 = _local_5.wallType;
                    _local_4 = _local_5.landscapeType;
                };
                _local_5 = new RoomData(_arg_1, _arg_2);
                _local_5.floorType = _local_6;
                _local_5.wallType = _local_7;
                _local_5.landscapeType = _local_4;
                _SafeStr_424.add(_local_3, _local_5);
                Logger.log("Room Engine not initilized yet, can not create room. Room data stored for later initialization.");
                return;
            };
            if (_arg_2 == null)
            {
                Logger.log("Room property messages received before floor height map, will initialize when floor height map received.");
                return;
            };
            _local_5 = _SafeStr_424.remove(_local_3);
            if (_local_5 != null)
            {
                if (((!(_local_5.floorType == null)) && (_local_5.floorType.length > 0)))
                {
                    _local_6 = _local_5.floorType;
                };
                if (((!(_local_5.wallType == null)) && (_local_5.wallType.length > 0)))
                {
                    _local_7 = _local_5.wallType;
                };
                if (((!(_local_5.landscapeType == null)) && (_local_5.landscapeType.length > 0)))
                {
                    _local_4 = _local_5.landscapeType;
                };
            };
            var _local_8:IRoomInstance = createRoom(_local_3, _arg_2, _local_6, _local_7, _local_4, getWorldType(_arg_1));
            if (_local_8 == null)
            {
                return;
            };
            events.dispatchEvent(new RoomEngineEvent("REE_INITIALIZED", _arg_1));
        }

        private function createRoom(_arg_1:String, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String):IRoomInstance
        {
            var _local_24:int;
            var _local_11:XML;
            var _local_26:Number;
            var _local_9:Number;
            var _local_25:Number;
            var _local_8:Number;
            var _local_22:RoomObjectRoomUpdateMessage;
            var _local_17:XMLList;
            var _local_27:Array;
            var _local_10:RoomObjectRoomMaskUpdateMessage;
            var _local_20:int;
            var _local_7:XML;
            var _local_16:Number;
            var _local_14:Number;
            var _local_13:Number;
            var _local_12:Number;
            var _local_18:String;
            var _local_21:String;
            var _local_19:Vector3d;
            if (!_isInitialized)
            {
                return (null);
            };
            var _local_23:IRoomInstance = _roomManager.createRoom(_arg_1, _arg_2);
            if (_local_23 == null)
            {
                return (null);
            };
            var _local_28:int;
            var _local_29:IRoomObjectController;
            var _local_15:Number = 1;
            _local_29 = (_local_23.createRoomObject(-1, "room", _local_28) as IRoomObjectController);
            _local_23.setNumber("room_is_public", 0, true);
            _local_23.setNumber("room_z_scale", _local_15, true);
            if (_arg_2 != null)
            {
                _local_24 = 0;
                if (_arg_2.dimensions.length() == 1)
                {
                    _local_11 = _arg_2.dimensions[0];
                    _local_26 = Number(_local_11.@minX);
                    _local_9 = Number(_local_11.@maxX);
                    _local_25 = Number(_local_11.@minY);
                    _local_8 = Number(_local_11.@maxY);
                    _local_23.setNumber("room_min_x", _local_26);
                    _local_23.setNumber("room_max_x", _local_9);
                    _local_23.setNumber("room_min_y", _local_25);
                    _local_23.setNumber("room_max_y", _local_8);
                    _local_24 = (_local_24 + ((((_local_26 * 423) + (_local_9 * 671)) + (_local_25 * 913)) + (_local_8 * 7509)));
                    if (((!(_local_29 == null)) && (!(_local_29.getModelController() == null))))
                    {
                        _local_29.getModelController().setNumber("room_random_seed", _local_24, true);
                    };
                };
            };
            if (((!(_local_29 == null)) && (!(_local_29.getEventHandler() == null))))
            {
                _local_29.getEventHandler().initialize(_arg_2);
                _local_22 = null;
                if (_arg_3 != null)
                {
                    _local_22 = new RoomObjectRoomUpdateMessage("RORUM_ROOM_FLOOR_UPDATE", _arg_3);
                    _local_29.getEventHandler().processUpdateMessage(_local_22);
                    _local_23.setString("room_floor_type", _arg_3);
                };
                if (_arg_4 != null)
                {
                    _local_22 = new RoomObjectRoomUpdateMessage("RORUM_ROOM_WALL_UPDATE", _arg_4);
                    _local_29.getEventHandler().processUpdateMessage(_local_22);
                    _local_23.setString("room_wall_type", _arg_4);
                };
                if (_arg_5 != null)
                {
                    _local_22 = new RoomObjectRoomUpdateMessage("RORUM_ROOM_LANDSCAPE_UPDATE", _arg_5);
                    _local_29.getEventHandler().processUpdateMessage(_local_22);
                    _local_23.setString("room_landscape_type", _arg_5);
                };
                if (_arg_2 != null)
                {
                    if (_arg_2.doors.door.length() > 0)
                    {
                        _local_17 = _arg_2.doors.door;
                        _local_27 = ["x", "y", "z", "dir"];
                        _local_10 = null;
                        _local_20 = 0;
                        while (_local_20 < _local_17.length())
                        {
                            _local_7 = _local_17[_local_20];
                            if (_SafeStr_93.checkRequiredAttributes(_local_7, _local_27))
                            {
                                _local_16 = Number(_local_7.@x);
                                _local_14 = Number(_local_7.@y);
                                _local_13 = Number(_local_7.@z);
                                _local_12 = Number(_local_7.@dir);
                                _local_18 = "door";
                                _local_21 = ("door_" + _local_20);
                                _local_19 = new Vector3d(_local_16, _local_14, _local_13);
                                _local_10 = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _local_21, _local_18, _local_19, "hole");
                                _local_29.getEventHandler().processUpdateMessage(_local_10);
                                if (((_local_12 == 90) || (_local_12 == 180)))
                                {
                                    if (_local_12 == 90)
                                    {
                                        _local_23.setNumber("room_door_x", (_local_16 - 0.5), true);
                                        _local_23.setNumber("room_door_y", _local_14, true);
                                    };
                                    if (_local_12 == 180)
                                    {
                                        _local_23.setNumber("room_door_x", _local_16, true);
                                        _local_23.setNumber("room_door_y", (_local_14 - 0.5), true);
                                    };
                                    _local_23.setNumber("room_door_z", _local_13, true);
                                    _local_23.setNumber("room_door_dir", _local_12, true);
                                };
                            };
                            _local_20++;
                        };
                    };
                };
            };
            _local_23.createRoomObject(-2, "tile_cursor", 200);
            if (!getBoolean("avatar.widget.enabled"))
            {
                _local_23.createRoomObject(-3, "selection_arrow", 200);
            };
            return (_local_23);
        }

        public function getObjectRoom(_arg_1:int):IRoomObjectController
        {
            return (getObject(getRoomIdentifier(_arg_1), -1, 0));
        }

        public function updateObjectRoom(_arg_1:int, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:Boolean=false):Boolean
        {
            var _local_6:String;
            var _local_8:RoomData;
            var _local_10:IRoomObjectController = getObjectRoom(_arg_1);
            var _local_7:IRoomInstance = getRoom(_arg_1);
            if (_local_10 == null)
            {
                _local_6 = getRoomIdentifier(_arg_1);
                _local_8 = _SafeStr_424.getValue(_local_6);
                if (_local_8 == null)
                {
                    _local_8 = new RoomData(_arg_1, null);
                    _SafeStr_424.add(_local_6, _local_8);
                };
                if (_arg_2 != null)
                {
                    _local_8.floorType = _arg_2;
                };
                if (_arg_3 != null)
                {
                    _local_8.wallType = _arg_3;
                };
                if (_arg_4 != null)
                {
                    _local_8.landscapeType = _arg_4;
                };
                return (true);
            };
            if (_local_10.getEventHandler() == null)
            {
                return (false);
            };
            var _local_9:RoomObjectRoomUpdateMessage;
            if (_arg_2 != null)
            {
                if (((!(_local_7 == null)) && (!(_arg_5))))
                {
                    _local_7.setString("room_floor_type", _arg_2);
                };
                _local_9 = new RoomObjectRoomUpdateMessage("RORUM_ROOM_FLOOR_UPDATE", _arg_2);
                _local_10.getEventHandler().processUpdateMessage(_local_9);
            };
            if (_arg_3 != null)
            {
                if (((!(_local_7 == null)) && (!(_arg_5))))
                {
                    _local_7.setString("room_wall_type", _arg_3);
                };
                _local_9 = new RoomObjectRoomUpdateMessage("RORUM_ROOM_WALL_UPDATE", _arg_3);
                _local_10.getEventHandler().processUpdateMessage(_local_9);
            };
            if (_arg_4 != null)
            {
                if (((!(_local_7 == null)) && (!(_arg_5))))
                {
                    _local_7.setString("room_landscape_type", _arg_4);
                };
                _local_9 = new RoomObjectRoomUpdateMessage("RORUM_ROOM_LANDSCAPE_UPDATE", _arg_4);
                _local_10.getEventHandler().processUpdateMessage(_local_9);
            };
            return (true);
        }

        public function updateObjectRoomColor(_arg_1:int, _arg_2:uint, _arg_3:int, _arg_4:Boolean):Boolean
        {
            var _local_6:IRoomObjectController = getObjectRoom(_arg_1);
            if (((_local_6 == null) || (_local_6.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_5:RoomObjectRoomColorUpdateMessage;
            _local_5 = new RoomObjectRoomColorUpdateMessage("RORCUM_BACKGROUND_COLOR", _arg_2, _arg_3, _arg_4);
            _local_6.getEventHandler().processUpdateMessage(_local_5);
            events.dispatchEvent(new RoomEngineRoomColorEvent(_arg_1, _arg_2, _arg_3, _arg_4));
            return (true);
        }

        public function updateObjectRoomBackgroundColor(_arg_1:int, _arg_2:Boolean, _arg_3:int, _arg_4:int, _arg_5:int):Boolean
        {
            var _local_6:IRoomObjectController = getObjectRoom(_arg_1);
            if (((_local_6 == null) || (_local_6.getEventHandler() == null)))
            {
                return (false);
            };
            events.dispatchEvent(new RoomEngineHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR", _arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            return (true);
        }

        public function updateObjectRoomVisibilities(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean=true):Boolean
        {
            var _local_4:IRoomObjectController = getObjectRoom(_arg_1);
            if (((_local_4 == null) || (_local_4.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_5:RoomObjectRoomPlaneVisibilityUpdateMessage;
            _local_5 = new RoomObjectRoomPlaneVisibilityUpdateMessage("RORPVUM_WALL_VISIBILITY", _arg_2);
            _local_4.getEventHandler().processUpdateMessage(_local_5);
            _local_5 = new RoomObjectRoomPlaneVisibilityUpdateMessage("RORPVUM_FLOOR_VISIBILITY", _arg_3);
            _local_4.getEventHandler().processUpdateMessage(_local_5);
            return (true);
        }

        public function updateObjectRoomPlaneThicknesses(_arg_1:int, _arg_2:Number, _arg_3:Number):Boolean
        {
            var _local_4:IRoomObjectController = getObjectRoom(_arg_1);
            if (((_local_4 == null) || (_local_4.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_5:RoomObjectRoomPlanePropertyUpdateMessage;
            _local_5 = new RoomObjectRoomPlanePropertyUpdateMessage("RORPPUM_WALL_THICKNESS", _arg_2);
            _local_4.getEventHandler().processUpdateMessage(_local_5);
            _local_5 = new RoomObjectRoomPlanePropertyUpdateMessage("RORPVUM_FLOOR_THICKNESS", _arg_3);
            _local_4.getEventHandler().processUpdateMessage(_local_5);
            return (true);
        }

        public function disposeRoom(_arg_1:int):void
        {
            var _local_2:String = getRoomIdentifier(_arg_1);
            _roomManager.disposeRoom(_local_2);
            var _local_3:RoomInstanceData = _SafeStr_425.remove(_local_2);
            if (_local_3 != null)
            {
                _local_3.dispose();
            };
            events.dispatchEvent(new RoomEngineEvent("REE_DISPOSED", _arg_1));
        }

        public function setOwnUserId(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IRoomSession = _roomSessionManager.getSession(_arg_1);
            if (_local_3)
            {
                _local_3.ownUserRoomId = _arg_2;
            };
            var _local_4:RoomCamera = getRoomCamera(_arg_1);
            if (_local_4 != null)
            {
                _local_4.targetId = _arg_2;
                _local_4.targetCategory = 100;
                _local_4.activateFollowing(cameraFollowDuration);
            };
        }

        public function createRoomCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):DisplayObject
        {
            var _local_17:Number;
            var _local_16:Number;
            var _local_14:Number;
            var _local_12:Number;
            var _local_13:Vector3d;
            var _local_15:Vector3d;
            var _local_8:Sprite;
            var _local_11:String = getRoomIdentifier(_arg_1);
            var _local_9:IRoomInstance = _roomManager.getRoom(_local_11);
            if (_local_9 == null)
            {
                return (null);
            };
            var _local_6:IRoomRenderer = (_local_9.getRenderer() as IRoomRenderer);
            if (_local_6 == null)
            {
                _local_6 = _roomRendererFactory.createRenderer();
            };
            if (_local_6 == null)
            {
                return (null);
            };
            _local_6.roomObjectVariableAccurateZ = "object_accurate_z_value";
            _local_9.setRenderer(_local_6);
            var _local_7:IRoomRenderingCanvas = _local_6.createCanvas(_arg_2, _arg_3, _arg_4, _arg_5);
            if (_local_7 == null)
            {
                return (null);
            };
            _local_7.mouseListener = _eventHandler;
            if (_local_7.geometry != null)
            {
                _local_7.geometry.z_scale = _local_9.getNumber("room_z_scale");
            };
            if (_local_7.geometry != null)
            {
                _local_17 = _local_9.getNumber("room_door_x");
                _local_16 = _local_9.getNumber("room_door_y");
                _local_14 = _local_9.getNumber("room_door_z");
                _local_12 = _local_9.getNumber("room_door_dir");
                _local_13 = new Vector3d(_local_17, _local_16, _local_14);
                _local_15 = null;
                if (_local_12 == 90)
                {
                    _local_15 = new Vector3d(-2000, 0, 0);
                };
                if (_local_12 == 180)
                {
                    _local_15 = new Vector3d(0, -2000, 0);
                };
                _local_7.geometry.setDisplacement(_local_13, _local_15);
            };
            var _local_10:Sprite = (_local_7.displayObject as Sprite);
            if (_local_10 != null)
            {
                _local_8 = new Sprite();
                _local_8.name = "overlay";
                _local_8.mouseEnabled = false;
                _local_10.addChild(_local_8);
            };
            return (_local_10);
        }

        public function setRoomCanvasScale(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Point=null, _arg_5:Point=null, _arg_6:Boolean=false, _arg_7:Boolean=false, _arg_8:Boolean=false):void
        {
            var _local_10:RoomInstanceData;
            var _local_11:RoomCamera;
            if (!getBoolean("zoom.enabled"))
            {
                return;
            };
            if (!_arg_7)
            {
                _arg_3 = ((_arg_6) ? -1 : ((_arg_3 < 1) ? 0.5 : Math.floor(_arg_3)));
            };
            var _local_9:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_9 != null)
            {
                _local_9.setScale(_arg_3, _arg_4, _arg_5, _arg_8);
                _local_10 = getRoomInstanceData(_SafeStr_418);
                if (_local_10 != null)
                {
                    _local_11 = _local_10.roomCamera;
                };
                events.dispatchEvent(new RoomEngineEvent("REE_ROOM_ZOOMED", _arg_1));
            };
        }

        public function getRoomCanvasScale(_arg_1:int=-1000, _arg_2:int=-1):Number
        {
            if (_arg_1 == -1000)
            {
                _arg_1 = _SafeStr_418;
            };
            if (_arg_2 == -1)
            {
                _arg_2 = _SafeStr_430;
            };
            var _local_3:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_3 == null)
            {
                return (1);
            };
            return (_local_3.scale);
        }

        public function getRoomCanvas(_arg_1:int, _arg_2:int):IRoomRenderingCanvas
        {
            var _local_3:String = getRoomIdentifier(_arg_1);
            var _local_6:IRoomInstance = _roomManager.getRoom(_local_3);
            if (_local_6 == null)
            {
                return (null);
            };
            var _local_4:IRoomRenderer = (_local_6.getRenderer() as IRoomRenderer);
            if (_local_4 == null)
            {
                return (null);
            };
            var _local_5:IRoomRenderingCanvas = _local_4.getCanvas(_arg_2);
            return (_local_5);
        }

        public function modifyRoomCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_5 == null)
            {
                return (false);
            };
            _local_5.initialize(_arg_3, _arg_4);
            return (true);
        }

        public function setRoomCanvasMask(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_4 == null)
            {
                return;
            };
            _local_4.useMask = _arg_3;
        }

        private function getRoomCanvasRectangle(_arg_1:int, _arg_2:int):Rectangle
        {
            var _local_3:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_3 == null)
            {
                return (null);
            };
            return (new Rectangle(0, 0, _local_3.width, _local_3.height));
        }

        public function getRoomCanvasGeometry(_arg_1:int, _arg_2:int=-1):IRoomGeometry
        {
            if (_arg_2 == -1)
            {
                _arg_2 = _SafeStr_430;
            };
            var _local_3:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_3 == null)
            {
                return (null);
            };
            return (_local_3.geometry);
        }

        public function getRoomCanvasScreenOffset(_arg_1:int, _arg_2:int=-1):Point
        {
            if (_arg_2 == -1)
            {
                _arg_2 = _SafeStr_430;
            };
            var _local_3:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (_local_3 == null)
            {
                return (null);
            };
            return (new Point(_local_3.screenOffsetX, _local_3.screenOffsetY));
        }

        public function setRoomCanvasScreenOffset(_arg_1:int, _arg_2:int, _arg_3:Point):Boolean
        {
            var _local_4:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (((_local_4 == null) || (_arg_3 == null)))
            {
                return (false);
            };
            _local_4.screenOffsetX = _arg_3.x;
            _local_4.screenOffsetY = _arg_3.y;
            return (true);
        }

        public function snapshotRoomCanvasToBitmap(_arg_1:int, _arg_2:int, _arg_3:BitmapData, _arg_4:Matrix, _arg_5:Boolean):Boolean
        {
            var _local_7:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (!_local_7)
            {
                return (false);
            };
            var _local_6:DisplayObject = _local_7.displayObject;
            if (!_local_6)
            {
                return (false);
            };
            _arg_3.draw(_local_6, _arg_4, null, null, null, _arg_5);
            return (true);
        }

        private function handleRoomDragging(_arg_1:IRoomRenderingCanvas, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):Boolean
        {
            var _local_10:RoomInstanceData;
            var _local_11:RoomCamera;
            if (_isGameMode)
            {
                return (false);
            };
            var _local_9:int = (_arg_2 - _SafeStr_431);
            var _local_8:int = (_arg_3 - _SafeStr_432);
            if (_arg_4 == "mouseDown")
            {
                if (((((!(_arg_5)) && (!(_arg_6))) && (!(_arg_7))) && (!(isDecorateMode))))
                {
                    _SafeStr_427 = true;
                    _SafeStr_433 = false;
                    _SafeStr_435 = _SafeStr_431;
                    _SafeStr_436 = _SafeStr_432;
                    _SafeStr_434 = _mouseEventsDisabledLeftToX;
                    _mouseEventsDisabledLeftToX = 0;
                };
            }
            else
            {
                if (_arg_4 == "mouseUp")
                {
                    if (_SafeStr_427)
                    {
                        _SafeStr_427 = false;
                        if (_SafeStr_433)
                        {
                            _local_10 = getRoomInstanceData(_SafeStr_418);
                            if (_local_10 != null)
                            {
                                _local_11 = _local_10.roomCamera;
                                if (_local_11 != null)
                                {
                                    if (useOffsetScrolling)
                                    {
                                        if (!_local_11.isMoving)
                                        {
                                            _local_11.centeredLocX = false;
                                            _local_11.centeredLocY = false;
                                        };
                                        _local_11.resetLocation(new Vector3d(-(_arg_1.screenOffsetX), -(_arg_1.screenOffsetY)));
                                    };
                                    if (_roomDraggingAlwaysCenters)
                                    {
                                        _local_11.reset();
                                    };
                                };
                            };
                            events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_END", _SafeStr_418));
                        };
                    };
                    if (_SafeStr_434 != 0)
                    {
                        _mouseEventsDisabledLeftToX = _SafeStr_434;
                        _SafeStr_434 = 0;
                    };
                }
                else
                {
                    if (_arg_4 == "mouseMove")
                    {
                        if (_SafeStr_427)
                        {
                            if (!_SafeStr_433)
                            {
                                _local_9 = (_arg_2 - _SafeStr_435);
                                _local_8 = (_arg_3 - _SafeStr_436);
                                if (((((_local_9 <= -(15)) || (_local_9 >= 15)) || (_local_8 <= -(15))) || (_local_8 >= 15)))
                                {
                                    _SafeStr_433 = true;
                                    events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_START", _SafeStr_418));
                                };
                                _local_9 = 0;
                                _local_8 = 0;
                            };
                            if (((!(_local_9 == 0)) || (!(_local_8 == 0))))
                            {
                                _SafeStr_428 = (_SafeStr_428 + _local_9);
                                _SafeStr_429 = (_SafeStr_429 + _local_8);
                                if (!_SafeStr_433)
                                {
                                    events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_START", _SafeStr_418));
                                };
                                _SafeStr_433 = true;
                            };
                        };
                    }
                    else
                    {
                        if (((_arg_4 == "click") || (_arg_4 == "doubleClick")))
                        {
                            _SafeStr_427 = false;
                            if (_SafeStr_433)
                            {
                                _SafeStr_433 = false;
                                return (true);
                            };
                        };
                    };
                };
            };
            return (false);
        }

        public function handleRoomCanvasMouseEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean):void
        {
            var _local_12:Number;
            var _local_10:Sprite;
            var _local_11:Sprite;
            var _local_15:Rectangle;
            var _local_14:String;
            var _local_13:RoomObjectEvent;
            if (((_mouseEventsDisabledAboveY > 0) && (_arg_3 < _mouseEventsDisabledAboveY)))
            {
                return;
            };
            if (((_mouseEventsDisabledLeftToX > 0) && (_arg_2 < _mouseEventsDisabledLeftToX)))
            {
                return;
            };
            var _local_9:IRoomRenderingCanvas = getRoomCanvas(_SafeStr_418, _arg_1);
            if (_local_9 != null)
            {
                if (((((_sessionDataManager.isPerkAllowed("MOUSE_ZOOM")) && (_arg_4 == "click")) && (_arg_6)) && (_arg_5)))
                {
                    _local_12 = ((_arg_7) ? (_local_9.scale >> 1) : ((_local_9.scale < 1) ? 1 : (_local_9.scale << 1)));
                    setRoomCanvasScale(activeRoomId, _SafeStr_430, _local_12, new Point(_arg_2, _arg_3));
                    return;
                };
                _local_10 = getOverlaySprite(_local_9);
                _local_11 = getOverlayIconSprite(_local_10, "object_icon_sprite");
                if (_local_11 != null)
                {
                    _local_15 = _local_11.getRect(_local_11);
                    _local_11.x = (_arg_2 - (_local_15.width / 2));
                    _local_11.y = (_arg_3 - (_local_15.height / 2));
                };
                if (!handleRoomDragging(_local_9, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7))
                {
                    if (!_local_9.handleMouseEvent(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8))
                    {
                        _local_14 = "";
                        if (_arg_4 == "click")
                        {
                            if (events != null)
                            {
                                events.dispatchEvent(new RoomEngineObjectEvent("REOE_DESELECTED", _SafeStr_418, -1, -2));
                            };
                            _local_14 = "ROE_MOUSE_CLICK";
                        }
                        else
                        {
                            if (_arg_4 == "mouseMove")
                            {
                                _local_14 = "ROE_MOUSE_MOVE";
                            }
                            else
                            {
                                if (_arg_4 == "mouseDown")
                                {
                                    _local_14 = "ROE_MOUSE_DOWN";
                                };
                            };
                        };
                        if (_eventHandler != null)
                        {
                            _local_13 = new RoomObjectMouseEvent(_local_14, getRoomObject(_SafeStr_418, -1, 0), null, _arg_5);
                            _eventHandler.handleRoomObjectEvent(_local_13, _SafeStr_418);
                        };
                    };
                };
                _SafeStr_430 = _arg_1;
                _SafeStr_431 = _arg_2;
                _SafeStr_432 = _arg_3;
            };
        }

        private function getOverlaySprite(_arg_1:IRoomRenderingCanvas):Sprite
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_3:Sprite = (_arg_1.displayObject as Sprite);
            if (_local_3 == null)
            {
                return (null);
            };
            return (_local_3.getChildByName("overlay") as Sprite);
        }

        private function addOverlayIconSprite(_arg_1:Sprite, _arg_2:String, _arg_3:BitmapData):Sprite
        {
            if (((_arg_1 == null) || (_arg_3 == null)))
            {
                return (null);
            };
            var _local_5:Sprite = getOverlayIconSprite(_arg_1, _arg_2);
            if (_local_5 != null)
            {
                return (null);
            };
            _local_5 = new Sprite();
            _local_5.name = _arg_2;
            _local_5.mouseEnabled = false;
            var _local_4:Bitmap = new Bitmap(_arg_3);
            _local_5.addChild(_local_4);
            _arg_1.addChild(_local_5);
            return (_local_5);
        }

        private function removeOverlayIconSprite(_arg_1:Sprite, _arg_2:String):Boolean
        {
            var _local_5:int;
            var _local_4:Sprite;
            var _local_3:Bitmap;
            if (_arg_1 == null)
            {
                return (false);
            };
            _local_5 = (_arg_1.numChildren - 1);
            while (_local_5 >= 0)
            {
                _local_4 = (_arg_1.getChildAt(_local_5) as Sprite);
                if (_local_4 != null)
                {
                    if (_local_4.name == _arg_2)
                    {
                        _arg_1.removeChildAt(_local_5);
                        _local_3 = (_local_4.getChildAt(0) as Bitmap);
                        if (((!(_local_3 == null)) && (!(_local_3.bitmapData == null))))
                        {
                            _local_3.bitmapData.dispose();
                            _local_3.bitmapData = null;
                        };
                        return (true);
                    };
                };
                _local_5--;
            };
            return (false);
        }

        private function getOverlayIconSprite(_arg_1:Sprite, _arg_2:String):Sprite
        {
            var _local_4:int;
            var _local_3:Sprite;
            if (_arg_1 == null)
            {
                return (null);
            };
            _local_4 = (_arg_1.numChildren - 1);
            while (_local_4 >= 0)
            {
                _local_3 = (_arg_1.getChildAt(_local_4) as Sprite);
                if (_local_3 != null)
                {
                    if (_local_3.name == _arg_2)
                    {
                        return (_local_3);
                    };
                };
                _local_4--;
            };
            return (null);
        }

        public function setObjectMoverIconSprite(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:String=null, _arg_5:IStuffData=null, _arg_6:int=-1, _arg_7:int=-1, _arg_8:String=null):void
        {
            var _local_13:String;
            var _local_12:int;
            var _local_14:PetFigureData;
            var _local_10:Sprite;
            var _local_11:Sprite;
            var _local_15:_SafeStr_147;
            if (_arg_3)
            {
                _local_15 = getRoomObjectImage(_SafeStr_418, _arg_1, _arg_2, new Vector3d(), 1, null);
            }
            else
            {
                if (_roomContentLoader != null)
                {
                    _local_13 = null;
                    _local_12 = 0;
                    if (_arg_2 == 10)
                    {
                        _local_13 = _roomContentLoader.getActiveObjectType(_arg_1);
                        _local_12 = _roomContentLoader.getActiveObjectColorIndex(_arg_1);
                    }
                    else
                    {
                        if (_arg_2 == 20)
                        {
                            _local_13 = _roomContentLoader.getWallItemType(_arg_1, _arg_4);
                            _local_12 = _roomContentLoader.getWallItemColorIndex(_arg_1);
                        };
                    };
                    if (_arg_2 == 100)
                    {
                        _local_13 = RoomObjectUserTypes.getName(_arg_1);
                        if (_local_13 == "pet")
                        {
                            _local_13 = getPetType(_arg_4);
                            _local_14 = new PetFigureData(_arg_4);
                            _local_15 = getPetImage(_local_14.typeId, _local_14.paletteId, _local_14.color, new Vector3d(180), 64, null, true, 0, _local_14.customParts, _arg_8);
                        }
                        else
                        {
                            _local_15 = getGenericRoomObjectImage(_local_13, _arg_4, new Vector3d(180), 1, null, 0, null, _arg_5, _arg_6, _arg_7, _arg_8);
                        };
                    }
                    else
                    {
                        _local_15 = getGenericRoomObjectImage(_local_13, String(_local_12), new Vector3d(), 1, null, 0, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
                    };
                };
            };
            if (((_local_15 == null) || (_local_15.data == null)))
            {
                return;
            };
            var _local_9:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
            if (_local_9 != null)
            {
                _local_10 = getOverlaySprite(_local_9);
                removeOverlayIconSprite(_local_10, "object_icon_sprite");
                _local_11 = addOverlayIconSprite(_local_10, "object_icon_sprite", _local_15.data);
                if (_local_11 != null)
                {
                    _local_11.x = (_SafeStr_431 - (_local_15.data.width / 2));
                    _local_11.y = (_SafeStr_432 - (_local_15.data.height / 2));
                };
            };
        }

        public function setObjectMoverIconSpriteVisible(_arg_1:Boolean):void
        {
            var _local_3:Sprite;
            var _local_4:Sprite;
            var _local_2:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
            if (_local_2 != null)
            {
                _local_3 = getOverlaySprite(_local_2);
                _local_4 = getOverlayIconSprite(_local_3, "object_icon_sprite");
                if (_local_4 != null)
                {
                    _local_4.visible = _arg_1;
                };
            };
        }

        public function removeObjectMoverIconSprite():void
        {
            var _local_2:Sprite;
            var _local_1:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
            if (_local_1 != null)
            {
                _local_2 = getOverlaySprite(_local_1);
                removeOverlayIconSprite(_local_2, "object_icon_sprite");
            };
        }

        public function getRoomObjectCount(_arg_1:int, _arg_2:int):int
        {
            if (!_isInitialized)
            {
                return (0);
            };
            var _local_3:String = getRoomIdentifier(_arg_1);
            var _local_4:IRoomInstance = _roomManager.getRoom(_local_3);
            if (_local_4 == null)
            {
                return (0);
            };
            return (_local_4.getObjectCount(_arg_2));
        }

        public function getRoomObject(_arg_1:int, _arg_2:int, _arg_3:int):IRoomObject
        {
            if (!_isInitialized)
            {
                return (null);
            };
            var _local_4:String = getRoomIdentifier(_arg_1);
            if (_arg_1 == 0)
            {
                _local_4 = "temporary_room";
            };
            return (getObject(_local_4, _arg_2, _arg_3));
        }

        public function getObjectsByCategory(_arg_1:int):Array
        {
            var _local_2:IRoomInstance;
            if (_roomManager != null)
            {
                _local_2 = _roomManager.getRoom(getRoomIdentifier(_SafeStr_418));
            };
            if (_local_2 == null)
            {
                return ([]);
            };
            return (_local_2.getObjects(_arg_1));
        }

        public function getRoomObjectWithIndex(_arg_1:int, _arg_2:int, _arg_3:int):IRoomObject
        {
            if (!_isInitialized)
            {
                return (null);
            };
            var _local_4:String = getRoomIdentifier(_arg_1);
            var _local_5:IRoomInstance = _roomManager.getRoom(_local_4);
            if (_local_5 == null)
            {
                return (null);
            };
            var _local_6:IRoomObject = _local_5.getObjectWithIndex(_arg_2, _arg_3);
            return (_local_6);
        }

        public function getRoomObjects(_arg_1:int, _arg_2:int):Array
        {
            var _local_3:String;
            var _local_4:IRoomInstance;
            if (_isInitialized)
            {
                _local_3 = getRoomIdentifier(_arg_1);
                _local_4 = _roomManager.getRoom(_local_3);
                if (_local_4 != null)
                {
                    return (_local_4.getObjects(_arg_2));
                };
            };
            return ([]);
        }

        public function modifyRoomObject(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            if (_eventHandler != null)
            {
                return (_eventHandler.modifyRoomObject(_SafeStr_418, _arg_1, _arg_2, _arg_3));
            };
            return (false);
        }

        public function modifyRoomObjectDataWithMap(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Map):Boolean
        {
            if (_eventHandler != null)
            {
                if (_arg_2 == 10)
                {
                    return (_eventHandler.modifyRoomObjectData(_SafeStr_418, _arg_1, _arg_2, _arg_3, _arg_4));
                };
            };
            return (false);
        }

        public function modifyRoomObjectData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String):Boolean
        {
            if (_eventHandler != null)
            {
                if (_arg_2 == 20)
                {
                    return (_eventHandler.modifyWallItemData(_SafeStr_418, _arg_1, _arg_3, _arg_4));
                };
            };
            return (false);
        }

        public function deleteRoomObject(_arg_1:int, _arg_2:int):Boolean
        {
            if (_eventHandler != null)
            {
                if (_arg_2 == 20)
                {
                    return (_eventHandler.deleteWallItem(_SafeStr_418, _arg_1));
                };
            };
            return (false);
        }

        public function initializeRoomObjectInsert(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String=null, _arg_6:IStuffData=null, _arg_7:int=-1, _arg_8:int=-1, _arg_9:String=null):Boolean
        {
            var _local_10:IRoomInstance = getRoom(_SafeStr_418);
            if (((_local_10 == null) || (!(_local_10.getNumber("room_is_public") == 0))))
            {
                return (false);
            };
            if (_eventHandler != null)
            {
                return (_eventHandler.initializeRoomObjectInsert(_arg_1, _SafeStr_418, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9));
            };
            return (false);
        }

        public function cancelRoomObjectInsert():void
        {
            if (_eventHandler != null)
            {
                _eventHandler.cancelRoomObjectInsert(_SafeStr_418);
            };
        }

        public function useRoomObjectInActiveRoom(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:IRoomObjectEventHandler;
            var _local_4:IRoomObject = getRoomObject(_SafeStr_418, _arg_1, _arg_2);
            if (_local_4 != null)
            {
                _local_3 = (_local_4.getMouseHandler() as IRoomObjectEventHandler);
                if (_local_3 != null)
                {
                    _local_3.useObject();
                    return (true);
                };
            };
            return (false);
        }

        private function getRoomObjectAdURL(_arg_1:String):String
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getRoomObjectAdURL(_arg_1));
            };
            return ("");
        }

        public function setRoomObjectAlias(_arg_1:String, _arg_2:String):void
        {
            if (_roomContentLoader != null)
            {
                _roomContentLoader.setRoomObjectAlias(_arg_1, _arg_2);
            };
        }

        public function getRoomObjectCategory(_arg_1:String):int
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getObjectCategory(_arg_1));
            };
            return (-2);
        }

        public function getFurnitureType(_arg_1:int):String
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getActiveObjectType(_arg_1));
            };
            return ("");
        }

        public function getFurnitureTypeId(_arg_1:String):int
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getActiveObjectTypeId(_arg_1));
            };
            return (0);
        }

        public function getWallItemType(_arg_1:int, _arg_2:String=null):String
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getWallItemType(_arg_1, _arg_2));
            };
            return ("");
        }

        public function getPetTypeId(_arg_1:String):int
        {
            var _local_2:Array;
            var _local_3:int = -1;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split(" ");
                if (_local_2.length > 1)
                {
                    _local_3 = parseInt(_local_2[0]);
                };
            };
            return (_local_3);
        }

        private function getPetType(_arg_1:String):String
        {
            var _local_2:Array;
            var _local_3:int;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split(" ");
                if (_local_2.length > 1)
                {
                    _local_3 = parseInt(_local_2[0]);
                    if (_roomContentLoader != null)
                    {
                        return (_roomContentLoader.getPetType(_local_3));
                    };
                    return ("pet");
                };
            };
            return (null);
        }

        public function getPetColor(_arg_1:int, _arg_2:int):PetColorResult
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getPetColor(_arg_1, _arg_2));
            };
            return (null);
        }

        public function getPetColorsByTag(_arg_1:int, _arg_2:String):Array
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getPetColorsByTag(_arg_1, _arg_2));
            };
            return (null);
        }

        public function getPetLayerIdForTag(_arg_1:int, _arg_2:String):int
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getPetLayerIdForTag(_arg_1, _arg_2));
            };
            return (-1);
        }

        public function getPetDefaultPalette(_arg_1:int, _arg_2:String):PetColorResult
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getPetDefaultPalette(_arg_1, _arg_2));
            };
            return (null);
        }

        private function getFurnitureColorIndex(_arg_1:int):int
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getActiveObjectColorIndex(_arg_1));
            };
            return (0);
        }

        private function getWallItemColorIndex(_arg_1:int):int
        {
            if (_roomContentLoader != null)
            {
                return (_roomContentLoader.getWallItemColorIndex(_arg_1));
            };
            return (0);
        }

        public function getSelectionArrow(_arg_1:int):IRoomObjectController
        {
            return (getObject(getRoomIdentifier(_arg_1), -3, 200));
        }

        public function getTileCursor(_arg_1:int):IRoomObjectController
        {
            return (getObject(getRoomIdentifier(_arg_1), -2, 200));
        }

        public function setTileCursorState(_arg_1:int, _arg_2:int):void
        {
            var _local_4:RoomObjectDataUpdateMessage;
            var _local_3:IRoomObjectController = getTileCursor(_arg_1);
            if (((!(_local_3 == null)) && (!(_local_3.getEventHandler() == null))))
            {
                _local_4 = new RoomObjectDataUpdateMessage(_arg_2, null);
                _local_3.getEventHandler().processUpdateMessage(_local_4);
            };
        }

        public function toggleTileCursorVisibility(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_4:RoomObjectTileCursorUpdateMessage;
            var _local_3:IRoomObjectController = getTileCursor(_arg_1);
            if (((!(_local_3 == null)) && (!(_local_3.getEventHandler() == null))))
            {
                _local_4 = new RoomObjectTileCursorUpdateMessage(null, 0, _arg_2, "", true);
                _local_3.getEventHandler().processUpdateMessage(_local_4);
            };
        }

        public function addObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:IStuffData, _arg_8:Number=NaN, _arg_9:int=-1, _arg_10:int=0, _arg_11:int=0, _arg_12:String="", _arg_13:Boolean=true, _arg_14:Boolean=true, _arg_15:Number=-1):Boolean
        {
            var _local_17:FurnitureData;
            var _local_16:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_16 != null)
            {
                _local_17 = new FurnitureData(_arg_2, _arg_3, null, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12, _arg_13, _arg_14, _arg_15);
                _local_16.addFurnitureData(_local_17);
            };
            return (true);
        }

        public function addObjectFurnitureByName(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:IStuffData, _arg_8:Number=NaN):Boolean
        {
            var _local_11:FurnitureData;
            var _local_9:String = getWorldType(_arg_1);
            var _local_10:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_10 != null)
            {
                _local_11 = new FurnitureData(_arg_2, 0, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, 0);
                _local_10.addFurnitureData(_local_11);
            };
            return (true);
        }

        private function addObjectFurnitureFromData(_arg_1:int, _arg_2:int, _arg_3:FurnitureData):Boolean
        {
            var _local_4:RoomInstanceData;
            if (_arg_3 == null)
            {
                _local_4 = getRoomInstanceData(_arg_1);
                if (_local_4 != null)
                {
                    _arg_3 = _local_4.getFurnitureDataWithId(_arg_2);
                };
            };
            if (_arg_3 == null)
            {
                return (false);
            };
            var _local_6:Boolean;
            var _local_9:String = _arg_3.type;
            if (_local_9 == null)
            {
                _local_9 = getFurnitureType(_arg_3.typeId);
                _local_6 = true;
            };
            var _local_7:int = getFurnitureColorIndex(_arg_3.typeId);
            var _local_8:String = getRoomObjectAdURL(_local_9);
            if (_local_9 == null)
            {
                _local_9 = "";
            };
            var _local_10:IRoomObjectController = createObjectFurniture(_arg_1, _arg_2, _local_9);
            if (_local_10 == null)
            {
                return (false);
            };
            if ((((!(_local_10 == null)) && (!(_local_10.getModelController() == null))) && (_local_6)))
            {
                _local_10.getModelController().setNumber("furniture_color", _local_7, true);
                _local_10.getModelController().setNumber("furniture_type_id", _arg_3.typeId, true);
                _local_10.getModelController().setString("furniture_ad_url", _local_8, true);
                _local_10.getModelController().setNumber("furniture_real_room_object", ((_arg_3.realRoomObject) ? 1 : 0), false);
                _local_10.getModelController().setNumber("furniture_expiry_time", _arg_3.expiryTime);
                _local_10.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
                _local_10.getModelController().setNumber("furniture_usage_policy", _arg_3.usagePolicy);
                _local_10.getModelController().setNumber("furniture_owner_id", _arg_3.ownerId);
                _local_10.getModelController().setString("furniture_owner_name", _arg_3.ownerName);
            };
            if (!updateObjectFurniture(_arg_1, _arg_2, _arg_3.loc, _arg_3.dir, _arg_3.state, _arg_3.data, _arg_3.extra))
            {
                return (false);
            };
            if (_arg_3.sizeZ >= 0)
            {
                if (!updateObjectFurnitureHeight(_arg_1, _arg_2, _arg_3.sizeZ))
                {
                    return (false);
                };
            };
            if (events != null)
            {
                events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED", _arg_1, _arg_2, 10));
            };
            var _local_5:ISelectedRoomObjectData = getPlacedObjectData(_arg_1);
            if ((((_local_5) && (Math.abs(_local_5.id) == _arg_2)) && (_local_5.category == 10)))
            {
                selectRoomObject(_arg_1, _arg_2, 10);
            };
            if (((_local_10.isInitialized()) && (_arg_3.synchronized)))
            {
                addObjectToTileMap(_arg_1, _local_10);
            };
            return (true);
        }

        public function changeObjectState(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_6:Number;
            var _local_5:int;
            var _local_4:IStuffData;
            var _local_7:RoomObjectDataUpdateMessage;
            var _local_8:IRoomObjectController = getObject(getRoomIdentifier(_arg_1), _arg_2, _arg_3);
            if (((!(_local_8 == null)) && (!(_local_8.getModelController() == null))))
            {
                _local_6 = _local_8.getModelController().getNumber("furniture_automatic_state_index");
                if (isNaN(_local_6))
                {
                    _local_6 = 1;
                }
                else
                {
                    _local_6 = (_local_6 + 1);
                };
                _local_8.getModelController().setNumber("furniture_automatic_state_index", _local_6);
                _local_5 = _local_8.getModel().getNumber("furniture_data_format");
                _local_4 = _SafeStr_80.getStuffDataWrapperForType(_local_5);
                _local_4.initializeFromRoomObjectModel(_local_8.getModel());
                _local_7 = new RoomObjectDataUpdateMessage(_local_6, _local_4);
                if (_local_8.getEventHandler() != null)
                {
                    _local_8.getEventHandler().processUpdateMessage(_local_7);
                };
            };
        }

        public function changeObjectModelData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:int):Boolean
        {
            var _local_6:RoomObjectModelDataUpdateMessage;
            var _local_7:IRoomObjectController = getObject(getRoomIdentifier(_arg_1), _arg_2, _arg_3);
            if (_local_7 == null)
            {
                return (false);
            };
            if (((!(_local_7 == null)) && (!(_local_7.getEventHandler() == null))))
            {
                _local_6 = new RoomObjectModelDataUpdateMessage(_arg_4, _arg_5);
                _local_7.getEventHandler().processUpdateMessage(_local_6);
            };
            return (true);
        }

        public function updateObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:int, _arg_6:IStuffData, _arg_7:Number=NaN):Boolean
        {
            var _local_10:IRoomObjectController = getObjectFurniture(_arg_1, _arg_2);
            if (_local_10 == null)
            {
                return (false);
            };
            var _local_8:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(_arg_3, _arg_4);
            var _local_9:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(_arg_5, _arg_6, _arg_7);
            if (((!(_local_10 == null)) && (!(_local_10.getEventHandler() == null))))
            {
                _local_10.getEventHandler().processUpdateMessage(_local_8);
                _local_10.getEventHandler().processUpdateMessage(_local_9);
            };
            return (true);
        }

        public function updateObjectFurnitureHeight(_arg_1:int, _arg_2:int, _arg_3:Number):Boolean
        {
            var _local_4:RoomObjectHeightUpdateMessage;
            var _local_5:IRoomObjectController = getObjectFurniture(_arg_1, _arg_2);
            if (_local_5 == null)
            {
                return (false);
            };
            if (((!(_local_5 == null)) && (!(_local_5.getEventHandler() == null))))
            {
                _local_4 = new RoomObjectHeightUpdateMessage(null, null, _arg_3);
                _local_5.getEventHandler().processUpdateMessage(_local_4);
            };
            return (true);
        }

        public function updateObjectFurnitureLocation(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:IVector3d):Boolean
        {
            var _local_5:RoomObjectMoveUpdateMessage;
            var _local_6:IRoomObjectController = getObjectFurniture(_arg_1, _arg_2);
            if (_local_6 == null)
            {
                return (false);
            };
            if (((!(_local_6 == null)) && (!(_local_6.getEventHandler() == null))))
            {
                _local_5 = new RoomObjectMoveUpdateMessage(_arg_3, _arg_4, null, (!(_arg_4 == null)));
                _local_6.getEventHandler().processUpdateMessage(_local_5);
            };
            return (true);
        }

        public function updateObjectFurnitureExpiryTime(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:IRoomObjectController = getObjectFurniture(_arg_1, _arg_2);
            if (_local_4 == null)
            {
                return (false);
            };
            _local_4.getModelController().setNumber("furniture_expiry_time", _arg_3);
            _local_4.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
            return (true);
        }

        private function createObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:String):IRoomObjectController
        {
            var _local_4:int = 10;
            var _local_5:IRoomObjectController = createObject(getRoomIdentifier(_arg_1), _arg_2, _arg_3, _local_4);
            return (_local_5);
        }

        private function getObjectFurniture(_arg_1:int, _arg_2:int):IRoomObjectController
        {
            return (getObject(getRoomIdentifier(_arg_1), _arg_2, 10));
        }

        public function disposeObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int=-1, _arg_4:Boolean=false):void
        {
            var _local_14:IRoomObject;
            var _local_12:Point;
            var _local_9:IRoomObjectModel;
            var _local_10:Boolean;
            var _local_11:int;
            var _local_7:String;
            var _local_13:int;
            var _local_8:IStuffData;
            var _local_5:BitmapData;
            var _local_6:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_6 != null)
            {
                _local_6.getFurnitureDataWithId(_arg_2);
            };
            if ((((_sessionDataManager) && (_arg_3 == _sessionDataManager.userId)) && (!(FurniId.isBuilderClubId(_arg_2)))))
            {
                _local_14 = getRoomObject(_arg_1, _arg_2, 10);
                if (_local_14)
                {
                    _local_12 = getRoomObjectScreenLocation(_arg_1, _arg_2, 10, _SafeStr_430);
                    if (_local_12)
                    {
                        _local_9 = _local_14.getModel();
                        _local_10 = (_local_9.getNumber("furniture_disable_picking_animation") == 1);
                        if (!_local_10)
                        {
                            _local_11 = _local_9.getNumber("furniture_type_id");
                            _local_7 = _local_9.getString("furniture_extras");
                            _local_13 = _local_9.getNumber("furniture_data_format");
                            _local_8 = _SafeStr_80.getStuffDataWrapperForType(_local_13);
                            _local_5 = getFurnitureIcon(_local_11, null, _local_7, _local_8).data;
                            if (_local_5)
                            {
                                _toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY", _local_5, _local_12.x, _local_12.y);
                            };
                        };
                    };
                };
            };
            disposeObject(_arg_1, _arg_2, 10);
            removeButtonMouseCursorOwner(_arg_1, 10, _arg_2);
            if (_arg_4)
            {
                refreshTileObjectMap(_arg_1, "RoomEngine.disposeObjectFurniture()");
            };
        }

        public function addObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:String, _arg_8:int=0, _arg_9:int=0, _arg_10:String="", _arg_11:int=-1, _arg_12:Boolean=true):Boolean
        {
            var _local_15:LegacyStuffData;
            var _local_14:FurnitureData;
            var _local_13:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_13 != null)
            {
                _local_15 = new LegacyStuffData();
                _local_15.setString(_arg_7);
                _local_14 = new FurnitureData(_arg_2, _arg_3, null, _arg_4, _arg_5, _arg_6, _local_15, NaN, _arg_11, _arg_8, _arg_9, _arg_10, true, _arg_12);
                _local_13.addWallItemData(_local_14);
            };
            return (true);
        }

        private function addObjectWallItemFromData(_arg_1:int, _arg_2:int, _arg_3:FurnitureData):Boolean
        {
            var _local_4:RoomInstanceData;
            if (_arg_3 == null)
            {
                _local_4 = getRoomInstanceData(_arg_1);
                if (_local_4 != null)
                {
                    _arg_3 = _local_4.getWallItemDataWithId(_arg_2);
                };
            };
            if (_arg_3 == null)
            {
                return (false);
            };
            var _local_6:String = "";
            if (_arg_3.data != null)
            {
                _local_6 = _arg_3.data.getLegacyString();
            };
            var _local_9:String = getWallItemType(_arg_3.typeId, _local_6);
            var _local_7:int = getWallItemColorIndex(_arg_3.typeId);
            var _local_8:String = getRoomObjectAdURL(_local_9);
            if (_local_9 == null)
            {
                _local_9 = "";
            };
            var _local_10:IRoomObjectController = createObjectWallItem(_arg_1, _arg_2, _local_9);
            if (_local_10 == null)
            {
                return (false);
            };
            if (((!(_local_10 == null)) && (!(_local_10.getModelController() == null))))
            {
                _local_10.getModelController().setNumber("furniture_color", _local_7, false);
                _local_10.getModelController().setNumber("furniture_type_id", _arg_3.typeId, true);
                _local_10.getModelController().setString("furniture_ad_url", _local_8, true);
                _local_10.getModelController().setNumber("furniture_real_room_object", ((_arg_3.realRoomObject) ? 1 : 0), false);
                _local_10.getModelController().setNumber("object_accurate_z_value", 1, true);
                _local_10.getModelController().setNumber("furniture_usage_policy", _arg_3.usagePolicy);
                _local_10.getModelController().setNumber("furniture_expiry_time", _arg_3.expiryTime);
                _local_10.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
                _local_10.getModelController().setNumber("furniture_owner_id", _arg_3.ownerId);
                _local_10.getModelController().setString("furniture_owner_name", _arg_3.ownerName);
            };
            _local_6 = "";
            if (_arg_3.data != null)
            {
                _local_6 = _arg_3.data.getLegacyString();
            };
            if (!updateObjectWallItem(_arg_1, _arg_2, _arg_3.loc, _arg_3.dir, _arg_3.state, _local_6))
            {
                return (false);
            };
            if (events != null)
            {
                events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED", _arg_1, _arg_2, 20));
            };
            var _local_5:ISelectedRoomObjectData = getPlacedObjectData(_arg_1);
            if ((((_local_5) && (_local_5.id == _arg_2)) && (_local_5.category == 20)))
            {
                selectRoomObject(_arg_1, _arg_2, 20);
            };
            return (true);
        }

        public function updateObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:int, _arg_6:String):Boolean
        {
            var _local_10:IRoomObjectController = getObjectWallItem(_arg_1, _arg_2);
            if (_local_10 == null)
            {
                return (false);
            };
            var _local_8:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(_arg_3, _arg_4);
            var _local_7:LegacyStuffData = new LegacyStuffData();
            _local_7.setString(_arg_6);
            var _local_9:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(_arg_5, _local_7);
            if (((!(_local_10 == null)) && (!(_local_10.getEventHandler() == null))))
            {
                _local_10.getEventHandler().processUpdateMessage(_local_8);
                _local_10.getEventHandler().processUpdateMessage(_local_9);
            };
            updateObjectRoomWindow(_arg_1, _arg_2);
            return (true);
        }

        public function updateObjectRoomWindow(_arg_1:int, _arg_2:int, _arg_3:Boolean=true):void
        {
            var _local_5:String;
            var _local_4:IVector3d;
            var _local_7:String = ("20_" + _arg_2);
            var _local_6:RoomObjectRoomMaskUpdateMessage;
            var _local_9:IRoomObjectController = getObjectWallItem(_arg_1, _arg_2);
            if (_local_9 != null)
            {
                if (_local_9.getModel() != null)
                {
                    if (_local_9.getModel().getNumber("furniture_uses_plane_mask") > 0)
                    {
                        _local_5 = _local_9.getModel().getString("furniture_plane_mask_type");
                        _local_4 = _local_9.getLocation();
                        if (_arg_3)
                        {
                            _local_6 = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _local_7, _local_5, _local_4);
                        }
                        else
                        {
                            _local_6 = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _local_7);
                        };
                    };
                };
            }
            else
            {
                _local_6 = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _local_7);
            };
            var _local_8:IRoomObjectController = getObjectRoom(_arg_1);
            if ((((!(_local_8 == null)) && (!(_local_8.getEventHandler() == null))) && (!(_local_6 == null))))
            {
                _local_8.getEventHandler().processUpdateMessage(_local_6);
            };
        }

        public function updateObjectWallItemData(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            var _local_5:IRoomObjectController = getObjectWallItem(_arg_1, _arg_2);
            if (_local_5 == null)
            {
                return (false);
            };
            var _local_4:RoomObjectItemDataUpdateMessage = new RoomObjectItemDataUpdateMessage(_arg_3);
            if (((!(_local_5 == null)) && (!(_local_5.getEventHandler() == null))))
            {
                _local_5.getEventHandler().processUpdateMessage(_local_4);
            };
            return (true);
        }

        private function createObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:String):IRoomObjectController
        {
            var _local_4:int = 20;
            var _local_5:IRoomObjectController = createObject(getRoomIdentifier(_arg_1), _arg_2, _arg_3, _local_4);
            return (_local_5);
        }

        private function getObjectWallItem(_arg_1:int, _arg_2:int):IRoomObjectController
        {
            return (getObject(getRoomIdentifier(_arg_1), _arg_2, 20));
        }

        public function updateObjectWallItemLocation(_arg_1:int, _arg_2:int, _arg_3:IVector3d):Boolean
        {
            var _local_4:RoomObjectMoveUpdateMessage;
            var _local_5:IRoomObjectController = getObjectWallItem(_arg_1, _arg_2);
            if (_local_5 == null)
            {
                return (false);
            };
            if (_local_5.getEventHandler() != null)
            {
                _local_4 = new RoomObjectMoveUpdateMessage(_arg_3, null, null);
                _local_5.getEventHandler().processUpdateMessage(_local_4);
            };
            updateObjectRoomWindow(_arg_1, _arg_2);
            return (true);
        }

        public function updateObjectWallItemExpiryTime(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:IRoomObjectController = getObjectWallItem(_arg_1, _arg_2);
            if (_local_4 == null)
            {
                return (false);
            };
            _local_4.getModelController().setNumber("furniture_expiry_time", _arg_3);
            _local_4.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
            return (true);
        }

        public function disposeObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int=-1):void
        {
            var _local_10:IRoomObject;
            var _local_6:Point;
            var _local_8:IRoomObjectModel;
            var _local_9:int;
            var _local_7:String;
            var _local_4:BitmapData;
            var _local_5:RoomInstanceData = getRoomInstanceData(_arg_1);
            if (_local_5 != null)
            {
                _local_5.getWallItemDataWithId(_arg_2);
            };
            if ((((_sessionDataManager) && (_arg_3 == _sessionDataManager.userId)) && (!(FurniId.isBuilderClubId(_arg_2)))))
            {
                _local_10 = getRoomObject(_arg_1, _arg_2, 20);
                if ((((_local_10) && (_local_10.getType().indexOf("post_it") == -1)) && (_local_10.getType().indexOf("external_image_wallitem") == -1)))
                {
                    _local_6 = getRoomObjectScreenLocation(_arg_1, _arg_2, 20, _SafeStr_430);
                    _local_8 = _local_10.getModel();
                    _local_9 = _local_8.getNumber("furniture_type_id");
                    _local_7 = _local_8.getString("furniture_data");
                    _local_4 = getWallItemIcon(_local_9, null, _local_7).data;
                    if (((_toolbar) && (_local_6)))
                    {
                        _toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY", _local_4, _local_6.x, _local_6.y);
                    };
                };
            };
            disposeObject(_arg_1, _arg_2, 20);
            updateObjectRoomWindow(_arg_1, _arg_2, false);
            removeButtonMouseCursorOwner(_arg_1, 20, _arg_2);
        }

        public function addObjectUser(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Number, _arg_6:int, _arg_7:String=null):Boolean
        {
            var _local_9:RoomObjectUpdateMessage;
            var _local_8:RoomObjectAvatarFigureUpdateMessage;
            if (getObjectUser(_arg_1, _arg_2) != null)
            {
                return (false);
            };
            var _local_10:String = RoomObjectUserTypes.getName(_arg_6);
            if (_local_10 == "pet")
            {
                _local_10 = getPetType(_arg_7);
            };
            var _local_11:IRoomObjectController = createObjectUser(_arg_1, _arg_2, _local_10);
            if (_local_11 == null)
            {
                return (false);
            };
            if (((!(_local_11 == null)) && (!(_local_11.getEventHandler() == null))))
            {
                _local_9 = new RoomObjectAvatarUpdateMessage(fixedUserLocation(_arg_1, _arg_3), null, _arg_4, _arg_5, false, 0);
                _local_11.getEventHandler().processUpdateMessage(_local_9);
                if (_arg_7 != null)
                {
                    _local_8 = new RoomObjectAvatarFigureUpdateMessage(_arg_7);
                    _local_11.getEventHandler().processUpdateMessage(_local_8);
                };
            };
            if (events != null)
            {
                events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED", _arg_1, _arg_2, 100));
            };
            return (true);
        }

        public function addObjectSnowWar(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:int):Boolean
        {
            var _local_5:String;
            var _local_6:RoomObjectUpdateMessage;
            if (_arg_4 == 201)
            {
                _local_5 = "game_snowball";
            }
            else
            {
                if (_arg_4 == 202)
                {
                    _local_5 = "game_snowsplash";
                };
            };
            var _local_7:IRoomObjectController = createObjectSnowWar(_arg_1, _arg_2, _local_5, _arg_4);
            if (!_local_7)
            {
                return (false);
            };
            if (_local_7.getEventHandler())
            {
                _local_6 = new RoomObjectUpdateMessage(_arg_3, null);
                _local_7.getEventHandler().processUpdateMessage(_local_6);
            };
            return (true);
        }

        public function addObjectSnowSplash(_arg_1:int, _arg_2:int, _arg_3:IVector3d):Boolean
        {
            var _local_4:RoomObjectUpdateMessage;
            _roomManager.addObjectUpdateCategory(202);
            var _local_5:IRoomObjectController = createObjectSnowWar(_arg_1, _arg_2, "game_snowsplash", 202);
            if (!_local_5)
            {
                return (false);
            };
            if (_local_5.getEventHandler())
            {
                _local_4 = new RoomObjectUpdateMessage(_arg_3, null);
                _local_5.getEventHandler().processUpdateMessage(_local_4);
            };
            return (true);
        }

        public function updateObjectUser(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Boolean=false, _arg_6:Number=0, _arg_7:IVector3d=null, _arg_8:Number=NaN):Boolean
        {
            var _local_10:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if ((((_local_10 == null) || (_local_10.getEventHandler() == null)) || (_local_10.getModel() == null)))
            {
                return (false);
            };
            if (_arg_3 == null)
            {
                _arg_3 = _local_10.getLocation();
            };
            if (_arg_7 == null)
            {
                _arg_7 = _local_10.getDirection();
            };
            if (isNaN(_arg_8))
            {
                _arg_8 = _local_10.getModel().getNumber("head_direction");
            };
            var _local_9:RoomObjectUpdateMessage = new RoomObjectAvatarUpdateMessage(fixedUserLocation(_arg_1, _arg_3), fixedUserLocation(_arg_1, _arg_4), _arg_7, _arg_8, _arg_5, _arg_6);
            _local_10.getEventHandler().processUpdateMessage(_local_9);
            if ((((roomSessionManager) && (roomSessionManager.getSession(_arg_1))) && (_arg_2 == roomSessionManager.getSession(_arg_1).ownUserRoomId)))
            {
                _roomObjectFactory.events.dispatchEvent(new RoomToObjectOwnAvatarMoveEvent("ROAME_MOVE_TO", _arg_4));
            };
            return (true);
        }

        public function updateObjectSnowWar(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:int):Boolean
        {
            var _local_5:IRoomObjectController = getObject(getRoomIdentifier(_arg_1), _arg_2, _arg_4);
            var _local_6:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(_arg_3, null);
            _local_5.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }

        public function disposeObjectSnowWar(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            disposeObject(_arg_1, _arg_2, _arg_3);
        }

        public function updateObjectUserFlatControl(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            var _local_5:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_5 == null) || (_local_5.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_4:RoomObjectUpdateStateMessage = new RoomObjectAvatarFlatControlUpdateMessage(_arg_3);
            _local_5.getEventHandler().processUpdateMessage(_local_4);
            return (true);
        }

        public function updateObjectUserOwnUserAvatar(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_3 == null) || (_local_3.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_4:RoomObjectUpdateMessage = new RoomObjectAvatarOwnMessage();
            _local_3.getEventHandler().processUpdateMessage(_local_4);
            return (true);
        }

        public function updateObjectUserFigure(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false):Boolean
        {
            var _local_8:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_8 == null) || (_local_8.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_7:RoomObjectUpdateStateMessage = new RoomObjectAvatarFigureUpdateMessage(_arg_3, _arg_4, _arg_5, _arg_6);
            _local_8.getEventHandler().processUpdateMessage(_local_7);
            return (true);
        }

        public function updateObjectUserAction(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:String=null):Boolean
        {
            var _local_7:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_7 == null) || (_local_7.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_6:RoomObjectUpdateStateMessage;
            switch (_arg_3)
            {
                case "figure_talk":
                    _local_6 = new RoomObjectAvatarChatUpdateMessage(_arg_4);
                    break;
                case "figure_sleep":
                    _local_6 = new RoomObjectAvatarSleepUpdateMessage((!(_arg_4 == 0)));
                    break;
                case "figure_is_typing":
                    _local_6 = new RoomObjectAvatarTypingUpdateMessage((!(_arg_4 == 0)));
                    break;
                case "figure_is_muted":
                    _local_6 = new RoomObjectAvatarMutedUpdateMessage((!(_arg_4 == 0)));
                    break;
                case "figure_carry_object":
                    _local_6 = new RoomObjectAvatarCarryObjectUpdateMessage(_arg_4, _arg_5);
                    break;
                case "figure_use_object":
                    _local_6 = new RoomObjectAvatarUseObjectUpdateMessage(_arg_4);
                    break;
                case "figure_dance":
                    _local_6 = new RoomObjectAvatarDanceUpdateMessage(_arg_4);
                    break;
                case "figure_gained_experience":
                    _local_6 = new RoomObjectAvatarExperienceUpdateMessage(_arg_4);
                    break;
                case "figure_number_value":
                    _local_6 = new RoomObjectAvatarPlayerValueUpdateMessage(_arg_4);
                    break;
                case "figure_sign":
                    _local_6 = new RoomObjectAvatarSignUpdateMessage(_arg_4);
                    break;
                case "figure_expression":
                    _local_6 = new RoomObjectAvatarExpressionUpdateMessage(_arg_4);
                    break;
                case "figure_is_playing_game":
                    _local_6 = new RoomObjectAvatarPlayingGameMessage((!(_arg_4 == 0)));
                    break;
                case "figure_guide_status":
                    _local_6 = new RoomObjectAvatarGuideStatusUpdateMessage(_arg_4);
            };
            _local_7.getEventHandler().processUpdateMessage(_local_6);
            return (true);
        }

        public function updateObjectUserPosture(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String=""):Boolean
        {
            var _local_6:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_6 == null) || (_local_6.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_5:RoomObjectUpdateStateMessage = new RoomObjectAvatarPostureUpdateMessage(_arg_3, _arg_4);
            _local_6.getEventHandler().processUpdateMessage(_local_5);
            return (true);
        }

        public function updateObjectUserGesture(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_5:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_5 == null) || (_local_5.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_4:RoomObjectUpdateStateMessage = new RoomObjectAvatarGestureUpdateMessage(_arg_3);
            _local_5.getEventHandler().processUpdateMessage(_local_4);
            return (true);
        }

        public function updateObjectPetGesture(_arg_1:int, _arg_2:int, _arg_3:String):Boolean
        {
            var _local_5:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_5 == null) || (_local_5.getEventHandler() == null)))
            {
                return (false);
            };
            var _local_4:RoomObjectUpdateStateMessage = new RoomObjectAvatarPetGestureUpdateMessage(_arg_3);
            _local_5.getEventHandler().processUpdateMessage(_local_4);
            return (true);
        }

        public function updateObjectUserEffect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int=0):Boolean
        {
            var _local_5:IRoomObjectController = getObjectUser(_arg_1, _arg_2);
            if (((_local_5 == null) || (_local_5.getEventHandler() == null)))
            {
                return (false);
            };
            _local_5.getEventHandler().processUpdateMessage(new RoomObjectAvatarEffectUpdateMessage(_arg_3, _arg_4));
            return (true);
        }

        private function createObjectUser(_arg_1:int, _arg_2:int, _arg_3:String):IRoomObjectController
        {
            var _local_4:int = 100;
            var _local_5:IRoomObjectController = createObject(getRoomIdentifier(_arg_1), _arg_2, _arg_3, _local_4);
            return (_local_5);
        }

        private function createObjectSnowWar(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):IRoomObjectController
        {
            return (createObject(getRoomIdentifier(_arg_1), _arg_2, _arg_3, _arg_4));
        }

        private function getObjectUser(_arg_1:int, _arg_2:int):IRoomObjectController
        {
            return (getObject(getRoomIdentifier(_arg_1), _arg_2, 100));
        }

        public function disposeObjectUser(_arg_1:int, _arg_2:int):void
        {
            disposeObject(_arg_1, _arg_2, 100);
        }

        private function createObject(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int):IRoomObjectController
        {
            var _local_5:IRoomInstance = _roomManager.getRoom(_arg_1);
            if (_local_5 == null)
            {
                return (null);
            };
            var _local_6:IRoomObjectController;
            _local_6 = (_local_5.createRoomObject(_arg_2, _arg_3, _arg_4) as IRoomObjectController);
            return (_local_6);
        }

        private function getObject(_arg_1:String, _arg_2:int, _arg_3:int):IRoomObjectController
        {
            var _local_4:IRoomInstance;
            if (_roomManager != null)
            {
                _local_4 = _roomManager.getRoom(_arg_1);
            };
            if (_local_4 == null)
            {
                return (null);
            };
            var _local_5:IRoomObjectController;
            _local_5 = (_local_4.getObject(_arg_2, _arg_3) as IRoomObjectController);
            if (_local_5 == null)
            {
                if (_arg_3 == 10)
                {
                    addObjectFurnitureFromData(getRoomId(_arg_1), _arg_2, null);
                    _local_5 = (_local_4.getObject(_arg_2, _arg_3) as IRoomObjectController);
                }
                else
                {
                    if (_arg_3 == 20)
                    {
                        addObjectWallItemFromData(getRoomId(_arg_1), _arg_2, null);
                        _local_5 = (_local_4.getObject(_arg_2, _arg_3) as IRoomObjectController);
                    };
                };
            };
            return (_local_5);
        }

        private function disposeObject(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:IRoomInstance;
            if (_roomManager != null)
            {
                _local_4 = getRoom(_arg_1);
                if (_local_4 == null)
                {
                    return;
                };
                if (_local_4.disposeObject(_arg_2, _arg_3))
                {
                    if (events != null)
                    {
                        events.dispatchEvent(new RoomEngineObjectEvent("REOE_REMOVED", _arg_1, _arg_2, _arg_3));
                    };
                };
            };
        }

        private function roomObjectEventHandler(_arg_1:RoomObjectEvent):void
        {
            var _local_2:String;
            var _local_3:int;
            if (_eventHandler != null)
            {
                _local_2 = getRoomObjectRoomIdentifier(_arg_1.object);
                if (_local_2 != null)
                {
                    _local_3 = getRoomId(_local_2);
                    _eventHandler.handleRoomObjectEvent(_arg_1, _local_3);
                };
            };
        }

        private function getRoomObjectRoomIdentifier(_arg_1:IRoomObject):String
        {
            if (((!(_arg_1 == null)) && (!(_arg_1.getModel() == null))))
            {
                return (_arg_1.getModel().getString("object_room_id"));
            };
            return (null);
        }

        public function createScreenShot(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            var _local_10:ByteArray;
            var _local_7:FileReference;
            var _local_5:Date;
            var _local_6:String;
            var _local_4:RegExp = /[:\/\\\*\?"<>\|%]/g;
            _arg_3 = _arg_3.replace(_local_4, "");
            var _local_9:IRoomRenderingCanvas = getRoomCanvas(_arg_1, _arg_2);
            if (!_local_9)
            {
                return;
            };
            var _local_8:BitmapData = _local_9.takeScreenShot();
            if (PlayerVersionCheck.isVersionAtLeast(11, 3))
            {
            };
            if (_local_10 == null)
            {
                _local_10 = PNGEncoder.encode(_local_8);
            };
            try
            {
                _local_7 = new FileReference();
                _local_7.save(_local_10, _arg_3);
            }
            catch(error:Error)
            {
                _local_5 = new Date();
                _local_6 = (([_local_5.getFullYear(), _local_5.getMonth(), _local_5.getDate()].join("-") + " ") + [_local_5.getHours(), _local_5.getMinutes(), _local_5.getSeconds()].join("."));
                _arg_3 = ("Habbo " + _local_6);
                _local_7 = new FileReference();
                _local_7.save(_local_10, _arg_3);
            };
        }

        public function getFurnitureIconUrl(_arg_1:int):String
        {
            var _local_3:String;
            var _local_2:String = "";
            if (_roomContentLoader != null)
            {
                _local_3 = _roomContentLoader.getActiveObjectType(_arg_1);
                _local_2 = String(_roomContentLoader.getActiveObjectColorIndex(_arg_1));
            };
            return (_roomContentLoader.getObjectUrl(_local_3, _local_2));
        }

        public function getFurnitureIcon(_arg_1:int, _arg_2:IGetImageListener, _arg_3:String=null, _arg_4:IStuffData=null, _arg_5:Boolean=false):_SafeStr_147
        {
            return (getFurnitureImage(_arg_1, new Vector3d(), 1, _arg_2, 0, _arg_3, -1, -1, _arg_4, _arg_5));
        }

        public function getWallItemIconUrl(_arg_1:int, _arg_2:String=null):String
        {
            var _local_4:String;
            var _local_3:String = "";
            if (_roomContentLoader != null)
            {
                _local_4 = _roomContentLoader.getWallItemType(_arg_1, _arg_2);
                _local_3 = String(_roomContentLoader.getWallItemColorIndex(_arg_1));
            };
            return (_roomContentLoader.getObjectUrl(_local_4, _local_3));
        }

        public function getWallItemIcon(_arg_1:int, _arg_2:IGetImageListener, _arg_3:String=null):_SafeStr_147
        {
            return (getWallItemImage(_arg_1, new Vector3d(), 1, _arg_2, 0, _arg_3));
        }

        public function getFurnitureImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0, _arg_6:String=null, _arg_7:int=-1, _arg_8:int=-1, _arg_9:IStuffData=null, _arg_10:Boolean=false):_SafeStr_147
        {
            var _local_12:String;
            var _local_11:String = "";
            if (_roomContentLoader != null)
            {
                _local_12 = _roomContentLoader.getActiveObjectType(_arg_1);
                _local_11 = String(_roomContentLoader.getActiveObjectColorIndex(_arg_1));
            };
            if ((((_arg_3 == 1) && (!(_arg_4 == null))) && (!(_arg_10))))
            {
                return (getGenericRoomObjectThumbnail(_local_12, _local_11, _arg_4, _arg_6, _arg_9));
            };
            return (getGenericRoomObjectImage(_local_12, _local_11, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_9, _arg_7, _arg_8));
        }

        public function getPetImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:int, _arg_6:IGetImageListener, _arg_7:Boolean=true, _arg_8:uint=0, _arg_9:Array=null, _arg_10:String=null):_SafeStr_147
        {
            var _local_11:String;
            var _local_13:String = ((((_arg_1 + " ") + _arg_2) + " ") + _arg_3.toString(16));
            if (!_arg_7)
            {
                _local_13 = (_local_13 + " head");
            };
            if (_arg_9 != null)
            {
                _local_13 = (_local_13 + (" " + _arg_9.length));
                for each (var _local_12:PetCustomPart in _arg_9)
                {
                    _local_13 = (_local_13 + (((((" " + _local_12.layerId) + " ") + _local_12.partId) + " ") + _local_12.paletteId));
                };
            };
            if (_roomContentLoader != null)
            {
                _local_11 = _roomContentLoader.getPetType(_arg_1);
            };
            return (getGenericRoomObjectImage(_local_11, _local_13, _arg_4, _arg_5, _arg_6, _arg_8, null, null, -1, -1, _arg_10));
        }

        public function getWallItemImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0, _arg_6:String=null, _arg_7:int=-1, _arg_8:int=-1):_SafeStr_147
        {
            var _local_10:String;
            var _local_9:String = "";
            if (_roomContentLoader != null)
            {
                _local_10 = _roomContentLoader.getWallItemType(_arg_1, _arg_6);
                _local_9 = String(_roomContentLoader.getWallItemColorIndex(_arg_1));
            };
            if (((_arg_3 == 1) && (!(_arg_4 == null))))
            {
                return (getGenericRoomObjectThumbnail(_local_10, _local_9, _arg_4, _arg_6, null));
            };
            return (getGenericRoomObjectImage(_local_10, _local_9, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, null, _arg_7, _arg_8));
        }

        public function getRoomImage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:IGetImageListener, _arg_6:String=null):_SafeStr_147
        {
            if (_arg_1 == null)
            {
                _arg_1 = "";
            };
            if (_arg_2 == null)
            {
                _arg_2 = "";
            };
            if (_arg_3 == null)
            {
                _arg_3 = "";
            };
            var _local_8:String = "room";
            var _local_7:String = (((((_arg_1 + "\n") + _arg_2) + "\n") + _arg_3) + "\n");
            if (_arg_6 != null)
            {
                _local_7 = (_local_7 + _arg_6);
            };
            return (getGenericRoomObjectImage(_local_8, _local_7, new Vector3d(), _arg_4, _arg_5));
        }

        public function getRoomObjectImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:int, _arg_6:IGetImageListener, _arg_7:uint=0):_SafeStr_147
        {
            var _local_9:String;
            var _local_16:IRoomObject;
            var _local_8:int;
            var _local_10:String;
            var _local_13:String = "";
            var _local_14:IStuffData;
            var _local_15:int = -1;
            var _local_12:String = getRoomIdentifier(_arg_1);
            var _local_11:IRoomInstance = _roomManager.getRoom(_local_12);
            if (_local_11 != null)
            {
                _local_16 = _local_11.getObject(_arg_2, _arg_3);
                if (((!(_local_16 == null)) && (!(_local_16.getModel() == null))))
                {
                    _local_10 = _local_16.getType();
                    _local_15 = _local_16.getId();
                    switch (_arg_3)
                    {
                        case 10:
                        case 20:
                            _local_13 = String(_local_16.getModel().getNumber("furniture_color"));
                            _local_9 = _local_16.getModel().getString("furniture_extras");
                            _local_8 = _local_16.getModel().getNumber("furniture_data_format");
                            if (_local_8 != 0)
                            {
                                _local_14 = _SafeStr_80.getStuffDataWrapperForType(_local_8);
                                _local_14.initializeFromRoomObjectModel(_local_16.getModel());
                            };
                            break;
                        case 100:
                            _local_13 = _local_16.getModel().getString("figure");
                    };
                };
            };
            return (getGenericRoomObjectImage(_local_10, _local_13, _arg_4, _arg_5, _arg_6, _arg_7, _local_9, _local_14, -1, -1, null, _local_15));
        }

        private function initializeRoomForGettingImage(_arg_1:IRoomObjectController, _arg_2:String):void
        {
            var _local_3:Array;
            var _local_8:String;
            var _local_9:String;
            var _local_12:String;
            var _local_4:String;
            var _local_11:int;
            var _local_5:RoomPlaneParser;
            var _local_14:int;
            var _local_13:int;
            var _local_6:XML;
            var _local_7:RoomObjectRoomMaskUpdateMessage;
            var _local_10:String;
            if (_arg_2 != null)
            {
                _local_3 = _arg_2.split("\n");
                if (_local_3.length >= 3)
                {
                    _local_8 = _local_3[0];
                    _local_9 = _local_3[1];
                    _local_12 = _local_3[2];
                    _local_4 = _local_3[3];
                    _local_11 = 6;
                    _local_5 = new RoomPlaneParser();
                    _local_5.initializeTileMap((_local_11 + 2), (_local_11 + 2));
                    _local_14 = 1;
                    while (_local_14 < (1 + _local_11))
                    {
                        _local_13 = 1;
                        while (_local_13 < (1 + _local_11))
                        {
                            _local_5.setTileHeight(_local_13, _local_14, 0);
                            _local_13++;
                        };
                        _local_14++;
                    };
                    _local_5.wallHeight = _local_11;
                    _local_5.initializeFromTileData();
                    _local_6 = _local_5.getXML();
                    _arg_1.getEventHandler().initialize(_local_6);
                    _arg_1.getModelController().setString("room_floor_type", _local_8);
                    _arg_1.getModelController().setString("room_wall_type", _local_9);
                    _arg_1.getModelController().setString("room_landscape_type", _local_12);
                    if (_local_4 != null)
                    {
                        _local_7 = null;
                        _local_10 = "20_1";
                        _local_7 = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _local_10, _local_4, new Vector3d(2.5, 0.5, 2));
                        _arg_1.getEventHandler().processUpdateMessage(_local_7);
                    };
                    _local_5.dispose();
                };
            };
        }

        public function getGenericRoomObjectThumbnail(_arg_1:String, _arg_2:String, _arg_3:IGetImageListener, _arg_4:String=null, _arg_5:IStuffData=null):_SafeStr_147
        {
            var _local_9:Vector.<IGetImageListener> = undefined;
            var _local_13:BitmapDataAsset;
            var _local_8:BitmapData;
            var _local_7:_SafeStr_147 = new _SafeStr_147();
            _local_7.id = -1;
            if (((!(_isInitialized)) || (_arg_1 == null)))
            {
                return (_local_7);
            };
            var _local_6:IRoomInstance = _roomManager.getRoom("temporary_room");
            if (_local_6 == null)
            {
                _local_6 = _roomManager.createRoom("temporary_room", null);
                if (_local_6 == null)
                {
                    return (_local_7);
                };
            };
            var _local_11:int = _SafeStr_421.reserveNumber();
            var _local_12:int = getRoomObjectCategory(_arg_1);
            if (_local_11 < 0)
            {
                return (_local_7);
            };
            _local_11 = (_local_11 + 1);
            _local_7.id = _local_11;
            _local_7.data = null;
            var _local_10:String = [_arg_1, _arg_2].join("_");
            if (((!(assets.hasAsset(_local_10))) && (!(_arg_3 == null))))
            {
                _local_9 = _SafeStr_423.getValue(_local_10);
                if (_local_9 == null)
                {
                    _local_9 = new Vector.<IGetImageListener>(0);
                    _SafeStr_423.add(_local_10, _local_9);
                    _roomContentLoader.loadThumbnailContent(_local_11, _arg_1, _arg_2, null);
                };
                _local_9.push(_arg_3);
            }
            else
            {
                _local_13 = (assets.getAssetByName(_local_10) as BitmapDataAsset);
                if (((_local_13) && (!(_local_13.disposed))))
                {
                    _local_8 = (_local_13.content as BitmapData);
                    try
                    {
                        if (((((!(_local_8 == null)) && (_local_8 is BitmapData)) && (_local_8.width > 0)) && (_local_8.height > 0)))
                        {
                            _local_7.data = _local_8.clone();
                        }
                        else
                        {
                            Logger.log(("Could not process thumbnail for icon (disposed?): " + _local_10));
                        };
                    }
                    catch(error:Error)
                    {
                        Logger.log(("Could not process thumbnail for icon: " + _local_10));
                    };
                };
                _SafeStr_421.freeNumber((_local_11 - 1));
                _local_7.id = 0;
            };
            return (_local_7);
        }

        public function getGenericRoomObjectImage(_arg_1:String, _arg_2:String, _arg_3:IVector3d, _arg_4:int, _arg_5:IGetImageListener, _arg_6:uint=0, _arg_7:String=null, _arg_8:IStuffData=null, _arg_9:int=-1, _arg_10:int=-1, _arg_11:String=null, _arg_12:int=-1):_SafeStr_147
        {
            var _local_18:PetFigureData;
            var _local_23:RoomObjectDataUpdateMessage;
            var _local_15:int;
            var _local_17:_SafeStr_147 = new _SafeStr_147();
            _local_17.id = -1;
            if (((!(_isInitialized)) || (_arg_1 == null)))
            {
                return (_local_17);
            };
            var _local_16:IRoomInstance = _roomManager.getRoom("temporary_room");
            if (_local_16 == null)
            {
                _local_16 = _roomManager.createRoom("temporary_room", null);
                if (_local_16 == null)
                {
                    return (_local_17);
                };
            };
            var _local_21:int = _SafeStr_420.reserveNumber();
            var _local_22:int = getRoomObjectCategory(_arg_1);
            if (_local_21 < 0)
            {
                return (_local_17);
            };
            _local_21 = (_local_21 + 1);
            var _local_24:IRoomObjectController = (_local_16.createRoomObject(_local_21, _arg_1, _local_22) as IRoomObjectController);
            if ((((_local_24 == null) || (_local_24.getModelController() == null)) || (_local_24.getEventHandler() == null)))
            {
                return (_local_17);
            };
            var _local_13:IRoomObjectModelController = _local_24.getModelController();
            switch (_local_22)
            {
                case 10:
                case 20:
                    _local_13.setNumber("furniture_color", int(_arg_2));
                    _local_13.setString("furniture_extras", _arg_7);
                    break;
                case 100:
                    if (((((_arg_1 == "user") || (_arg_1 == "bot")) || (_arg_1 == "rentable_bot")) || (_arg_1 == "pet")))
                    {
                        _local_13.setString("figure", _arg_2);
                    }
                    else
                    {
                        _local_18 = new PetFigureData(_arg_2);
                        _local_13.setNumber("pet_palette_index", _local_18.paletteId);
                        _local_13.setNumber("pet_color", _local_18.color);
                        if (_local_18.headOnly)
                        {
                            _local_13.setNumber("pet_head_only", 1);
                        };
                        if (_local_18.hasCustomParts)
                        {
                            _local_13.setNumberArray("pet_custom_layer_ids", _local_18.customLayerIds);
                            _local_13.setNumberArray("pet_custom_part_ids", _local_18.customPartIds);
                            _local_13.setNumberArray("pet_custom_palette_ids", _local_18.customPaletteIds);
                        };
                        if (_arg_11 != null)
                        {
                            _local_13.setString("figure_posture", _arg_11);
                        };
                    };
                    break;
                case 0:
                    initializeRoomForGettingImage(_local_24, _arg_2);
            };
            _local_24.setDirection(_arg_3);
            var _local_14:IRoomObjectSpriteVisualization;
            _local_14 = (_local_24.getVisualization() as IRoomObjectSpriteVisualization);
            if (_local_14 == null)
            {
                _local_16.disposeObject(_local_21, _local_22);
                return (_local_17);
            };
            if (((_arg_9 > -1) || (_arg_8)))
            {
                if (((!(_arg_8 == null)) && (!(_arg_8.getLegacyString() == ""))))
                {
                    _local_23 = new RoomObjectDataUpdateMessage(int(_arg_8.getLegacyString()), _arg_8);
                }
                else
                {
                    _local_23 = new RoomObjectDataUpdateMessage(_arg_9, _arg_8);
                };
                if (_local_24.getEventHandler() != null)
                {
                    _local_24.getEventHandler().processUpdateMessage(_local_23);
                };
            };
            var _local_20:RoomGeometry = new RoomGeometry(_arg_4, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
            _local_14.update(_local_20, 0, true, false);
            if (_arg_10 > 0)
            {
                _local_15 = 0;
                while (_local_15 < _arg_10)
                {
                    _local_14.update(_local_20, 0, true, false);
                    _local_15++;
                };
            };
            var _local_19:BitmapData = _local_14.getImage(_arg_6, _arg_12);
            _local_17.data = _local_19;
            _local_17.id = _local_21;
            if (((!(isRoomObjectContentAvailable(_arg_1))) && (!(_arg_5 == null))))
            {
                _SafeStr_422.add(_local_21, _arg_5);
                _local_13.setNumber("image_query_scale", _arg_4, true);
            }
            else
            {
                _local_16.disposeObject(_local_21, _local_22);
                _SafeStr_420.freeNumber((_local_21 - 1));
                _local_17.id = 0;
            };
            _local_20.dispose();
            return (_local_17);
        }

        public function getRoomObjectBoundingRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Rectangle
        {
            var _local_11:IRoomObject;
            var _local_6:IRoomObjectVisualization;
            var _local_5:Rectangle;
            var _local_7:IRoomRenderingCanvas;
            var _local_9:Number;
            var _local_8:Point;
            var _local_10:IRoomGeometry = getRoomCanvasGeometry(_arg_1, _arg_4);
            if (_local_10 != null)
            {
                _local_11 = getRoomObject(_arg_1, _arg_2, _arg_3);
                if (_local_11 != null)
                {
                    _local_6 = _local_11.getVisualization();
                    if (_local_6 != null)
                    {
                        _local_5 = _local_6.boundingRectangle;
                        _local_7 = getRoomCanvas(_arg_1, _arg_4);
                        _local_9 = ((_local_7) ? _local_7.scale : 1);
                        _local_8 = _local_10.getScreenPoint(_local_11.getLocation());
                        if (_local_8 != null)
                        {
                            _local_5.left = (_local_5.left * _local_9);
                            _local_5.top = (_local_5.top * _local_9);
                            _local_5.width = (_local_5.width * _local_9);
                            _local_5.height = (_local_5.height * _local_9);
                            _local_8.x = (_local_8.x * _local_9);
                            _local_8.y = (_local_8.y * _local_9);
                            _local_5.offset(_local_8.x, _local_8.y);
                            if (_local_7 != null)
                            {
                                _local_5.offset(((_local_7.width / 2) + _local_7.screenOffsetX), ((_local_7.height / 2) + _local_7.screenOffsetY));
                                return (_local_5);
                            };
                        };
                    };
                };
            };
            return (null);
        }

        public function getRoomObjectScreenLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int=-1):Point
        {
            var _local_8:IRoomObject;
            var _local_6:Point;
            var _local_5:IRoomRenderingCanvas;
            if (_arg_4 == -1)
            {
                _arg_4 = _SafeStr_430;
            };
            var _local_7:IRoomGeometry = getRoomCanvasGeometry(_arg_1, _arg_4);
            if (_local_7 != null)
            {
                _local_8 = getRoomObject(_arg_1, _arg_2, _arg_3);
                if (_local_8 != null)
                {
                    _local_6 = _local_7.getScreenPoint(_local_8.getLocation());
                    if (_local_6 != null)
                    {
                        _local_5 = getRoomCanvas(_arg_1, _arg_4);
                        if (_local_5 != null)
                        {
                            _local_6.x = (_local_6.x * _local_5.scale);
                            _local_6.y = (_local_6.y * _local_5.scale);
                            _local_6.offset(((_local_5.width / 2) + _local_5.screenOffsetX), ((_local_5.height / 2) + _local_5.screenOffsetY));
                        };
                        return (_local_6);
                    };
                };
            };
            return (null);
        }

        public function getActiveRoomBoundingRectangle(_arg_1:int):Rectangle
        {
            return (getRoomObjectBoundingRectangle(_SafeStr_418, -1, 0, _arg_1));
        }

        public function getActiveRoomActiveCanvas():IRoomRenderingCanvas
        {
            return (getRoomCanvas(_SafeStr_418, _SafeStr_430));
        }

        public function isRoomObjectContentAvailable(_arg_1:String):Boolean
        {
            return (_roomManager.isContentAvailable(_arg_1));
        }

        public function iconLoaded(_arg_1:int, _arg_2:String, _arg_3:Boolean):void
        {
            var _local_7:BitmapDataAsset;
            var _local_4:BitmapData;
            if (_roomContentLoader == null)
            {
                return;
            };
            if (_arg_1 == -1)
            {
                return;
            };
            _SafeStr_421.freeNumber((_arg_1 - 1));
            var _local_5:Vector.<IGetImageListener> = _SafeStr_423.getValue(_arg_2);
            if (_local_5 != null)
            {
                _SafeStr_423.remove(_arg_2);
                _local_7 = (assets.getAssetByName(_arg_2) as BitmapDataAsset);
                _local_4 = (_local_7.content as BitmapData);
                if (((_local_7) && (!(_local_7.disposed))))
                {
                    for each (var _local_6:IGetImageListener in _local_5)
                    {
                        if (_local_6 != null)
                        {
                            try
                            {
                                if (((((!(_local_4 == null)) && (_local_4 is BitmapData)) && (_local_4.width > 0)) && (_local_4.height > 0)))
                                {
                                    _local_6.imageReady(_arg_1, _local_4.clone());
                                }
                                else
                                {
                                    Logger.log(("Could not load thumbnail for icon (disposed?): " + _arg_2));
                                };
                            }
                            catch(error:Error)
                            {
                                Logger.log(("Could not load thumbnail for icon: " + _arg_2));
                            };
                        };
                    };
                };
            };
        }

        public function contentLoaded(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_6:int;
            var _local_14:IRoomObject;
            var _local_11:int;
            var _local_9:BitmapData;
            var _local_4:IRoomObjectSpriteVisualization;
            var _local_7:Number;
            var _local_5:IGetImageListener;
            if (!_arg_2)
            {
                Logger.log(("[RoomEngine] Failed to load content:  " + _arg_1));
            };
            var _local_8:IRoomInstance = _roomManager.getRoom("temporary_room");
            if (_local_8 == null)
            {
                Logger.log(((("No room instance for " + _arg_1) + " room: ") + "temporary_room"));
                return;
            };
            if (_roomContentLoader == null)
            {
                return;
            };
            var _local_10:RoomGeometry;
            var _local_13:Number = 0;
            var _local_12:int = _roomContentLoader.getObjectCategory(_arg_1);
            var _local_3:int = _local_8.getObjectCount(_local_12);
            _local_6 = (_local_3 - 1);
            while (_local_6 >= 0)
            {
                _local_14 = _local_8.getObjectWithIndex(_local_6, _local_12);
                if ((((!(_local_14 == null)) && (!(_local_14.getModel() == null))) && (_local_14.getType() == _arg_1)))
                {
                    _local_11 = _local_14.getId();
                    _local_9 = null;
                    _local_4 = null;
                    _local_4 = (_local_14.getVisualization() as IRoomObjectSpriteVisualization);
                    if (_local_4 != null)
                    {
                        _local_7 = _local_14.getModel().getNumber("image_query_scale");
                        if (((!(_local_10 == null)) && (!(_local_13 == _local_7))))
                        {
                            _local_10.dispose();
                            _local_10 = null;
                        };
                        if (_local_10 == null)
                        {
                            _local_13 = _local_7;
                            _local_10 = new RoomGeometry(_local_7, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
                        };
                        _local_4.update(_local_10, 0, true, false);
                        _local_9 = _local_4.image;
                    };
                    _local_8.disposeObject(_local_11, _local_12);
                    _SafeStr_420.freeNumber((_local_11 - 1));
                    _local_5 = (_SafeStr_422.remove(String(_local_11)) as IGetImageListener);
                    if (_local_5 != null)
                    {
                        if (_local_9 != null)
                        {
                            _local_5.imageReady(_local_11, _local_9);
                        }
                        else
                        {
                            _local_5.imageFailed(_local_11);
                        };
                    }
                    else
                    {
                        if (_local_9 != null)
                        {
                            _local_9.dispose();
                        };
                    };
                };
                _local_6--;
            };
            if (_local_10 != null)
            {
                _local_10.dispose();
            };
        }

        public function objectInitialized(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_5:int;
            var _local_4:IStuffData;
            var _local_6:int;
            var _local_7:RoomObjectDataUpdateMessage;
            var _local_8:int = getRoomId(_arg_1);
            if (_arg_3 == 20)
            {
                updateObjectRoomWindow(_local_8, _arg_2);
            };
            var _local_9:IRoomObjectController = (getRoomObject(_local_8, _arg_2, _arg_3) as IRoomObjectController);
            if ((((!(_local_9 == null)) && (!(_local_9.getModel() == null))) && (!(_local_9.getEventHandler() == null))))
            {
                if (!isNaN(_local_9.getModel().getNumber("furniture_data_format")))
                {
                    _local_5 = _local_9.getModel().getNumber("furniture_data_format");
                    _local_4 = _SafeStr_80.getStuffDataWrapperForType(_local_5);
                    _local_4.initializeFromRoomObjectModel(_local_9.getModel());
                    _local_6 = _local_9.getState(0);
                    _local_7 = new RoomObjectDataUpdateMessage(_local_6, _local_4);
                    _local_9.getEventHandler().processUpdateMessage(_local_7);
                };
                if (events != null)
                {
                    events.dispatchEvent(new RoomEngineObjectEvent("REOE_CONTENT_UPDATED", _local_8, _arg_2, _arg_3));
                };
            };
            if (_arg_1 != "temporary_room")
            {
                addObjectToTileMap(_local_8, _local_9);
            };
        }

        public function objectsInitialized(_arg_1:String):void
        {
            var _local_2:int;
            if (events != null)
            {
                _local_2 = getRoomId(_arg_1);
                events.dispatchEvent(new RoomEngineEvent("REE_OBJECTS_INITIALIZED", _local_2));
            };
        }

        public function selectAvatar(_arg_1:int, _arg_2:int):void
        {
            if (_eventHandler != null)
            {
                _eventHandler.setSelectedAvatar(_arg_1, _arg_2, true);
            };
        }

        public function getSelectedAvatarId():int
        {
            if (_eventHandler != null)
            {
                return (_eventHandler.getSelectedAvatarId());
            };
            return (-1);
        }

        public function selectRoomObject(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (_eventHandler == null)
            {
                return;
            };
            _eventHandler.setSelectedObject(_arg_1, _arg_2, _arg_3);
        }

        protected function addObjectToTileMap(_arg_1:int, _arg_2:IRoomObject):void
        {
            var _local_3:TileObjectMap = getRoomInstanceData(_arg_1).tileObjectMap;
            if (_local_3)
            {
                _local_3.addRoomObject(_arg_2);
            };
        }

        public function refreshTileObjectMap(_arg_1:int, _arg_2:String):void
        {
            var _local_3:TileObjectMap = getRoomInstanceData(_arg_1).tileObjectMap;
            if (_local_3)
            {
                _local_3.populate(getRoomObjects(_arg_1, 10));
            };
        }

        private function showRoomAd(_arg_1:AdEvent):void
        {
            var _local_3:IRoomObjectController;
            var _local_2:RoomObjectRoomAdUpdateMessage;
            if (_roomContentLoader != null)
            {
                _local_3 = getObjectRoom(_arg_1.roomId);
                if (_local_3 == null)
                {
                    return;
                };
                _local_2 = null;
                _local_2 = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_AD_ACTIVATE", "room_ad_image_asset", _arg_1.clickUrl);
                _local_3.getEventHandler().processUpdateMessage(_local_2);
            };
        }

        public function requestRoomAdImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String):void
        {
            if (_adManager != null)
            {
                _adManager.loadRoomAdImage(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }

        private function onRoomAdImageLoaded(_arg_1:AdEvent):void
        {
            var _local_2:RoomObjectRoomAdUpdateMessage;
            var _local_3:IRoomObjectController = getObjectRoom(_arg_1.roomId);
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:IRoomObjectController = getObjectFurniture(_arg_1.roomId, _arg_1.objectId);
            if (((_local_4 == null) || (_local_4.getEventHandler() == null)))
            {
                return;
            };
            if (_arg_1.image != null)
            {
                _roomContentLoader.addGraphicAsset(_local_4.getType(), _arg_1.imageUrl, _arg_1.image, true);
            };
            switch (_arg_1.type)
            {
                case "AE_ROOM_AD_IMAGE_LOADED":
                    _local_2 = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_BILLBOARD_IMAGE_LOADED", _arg_1.imageUrl, _arg_1.clickUrl, _arg_1.objectId, _arg_1.image);
                    break;
                case "AE_ROOM_AD_IMAGE_LOADING_FAILED":
                    _local_2 = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED", _arg_1.imageUrl, _arg_1.clickUrl, _arg_1.objectId, _arg_1.image);
                    break;
                default:
            };
            if (_local_2 != null)
            {
                _local_4.getEventHandler().processUpdateMessage(_local_2);
            };
        }

        public function insertContentLibrary(_arg_1:int, _arg_2:int, _arg_3:IAssetLibrary):Boolean
        {
            return (_roomContentLoader.insertObjectContent(_arg_1, _arg_2, _arg_3));
        }

        public function setActiveObjectType(_arg_1:int, _arg_2:String):void
        {
            _roomContentLoader.setActiveObjectType(_arg_1, _arg_2);
        }

        override public function purge():void
        {
            super.purge();
            if (_roomContentLoader)
            {
                _roomContentLoader.purge();
            };
        }

        public function requestBadgeImageAsset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean=true):void
        {
            var _local_10:IRoomInstance;
            var _local_6:Array;
            var _local_11:IRoomObjectController;
            if (_arg_1 == 0)
            {
                _local_10 = _roomManager.getRoom("temporary_room");
                if (_local_10 != null)
                {
                    _local_11 = (_local_10.getObject(_arg_2, _arg_3) as IRoomObjectController);
                };
            }
            else
            {
                _local_11 = getObjectFurniture(_arg_1, _arg_2);
            };
            if (((_local_11 == null) || (_local_11.getEventHandler() == null)))
            {
                return;
            };
            var _local_8:Function = ((_arg_5) ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName);
            var _local_7:String = _local_8.call(null, _arg_4);
            if (!_local_7)
            {
                _local_7 = "loading_icon";
                if (!_SafeStr_426)
                {
                    _SafeStr_426 = new Map();
                };
                if (_SafeStr_426.length == 0)
                {
                    _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY", onBadgeLoaded);
                };
                _local_6 = _SafeStr_426.getValue(_arg_4);
                if (_local_6 == null)
                {
                    _local_6 = [];
                };
                _local_6.push(new RoomObjectBadgeImageAssetListener(_local_11, _arg_5));
                _SafeStr_426[_arg_4] = _local_6;
            }
            else
            {
                addBadgeGraphicAssets(_local_11, _arg_4, _arg_5);
            };
            var _local_9:RoomObjectGroupBadgeUpdateMessage = new RoomObjectGroupBadgeUpdateMessage(_arg_4, _local_7);
            if (_local_9 != null)
            {
                _local_11.getEventHandler().processUpdateMessage(_local_9);
            };
        }

        private function addBadgeGraphicAssets(_arg_1:IRoomObjectController, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_9:Function = ((_arg_3) ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName);
            var _local_10:Function = ((_arg_3) ? _sessionDataManager.getGroupBadgeSmallAssetName : _sessionDataManager.getBadgeImageSmallAssetName);
            var _local_11:Function = ((_arg_3) ? _sessionDataManager.getGroupBadgeImage : _sessionDataManager.getBadgeImage);
            var _local_8:Function = ((_arg_3) ? _sessionDataManager.getGroupBadgeSmallImage : _sessionDataManager.getBadgeSmallImage);
            var _local_7:String = String(_local_9.call(null, _arg_2));
            var _local_4:BitmapData = BitmapData(_local_11.call(null, _arg_2));
            _roomContentLoader.addGraphicAsset(_arg_1.getType(), _local_7, _local_4, false);
            var _local_5:String = String(_local_10.call(null, _arg_2));
            var _local_6:BitmapData = _local_8.call(null, _arg_2);
            if (_local_6)
            {
                _roomContentLoader.addGraphicAsset(_arg_1.getType(), _local_5, _local_6, false);
            };
        }

        private function onBadgeLoaded(_arg_1:BadgeImageReadyEvent):void
        {
            var _local_4:int;
            var _local_3:RoomObjectBadgeImageAssetListener;
            var _local_5:Function;
            var _local_6:RoomObjectGroupBadgeUpdateMessage;
            var _local_2:Array = (_SafeStr_426.getValue(_arg_1.badgeId) as Array);
            if (_local_2 == null)
            {
                Logger.log(("Could not find matching objects for group badge asset request " + _arg_1.badgeId));
                return;
            };
            _local_4 = 0;
            while (_local_4 < _local_2.length)
            {
                _local_3 = _local_2[_local_4];
                addBadgeGraphicAssets(_local_3.object, _arg_1.badgeId, _local_3.groupBadge);
                _local_5 = ((_local_3.groupBadge) ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName);
                _local_6 = new RoomObjectGroupBadgeUpdateMessage(_arg_1.badgeId, _local_5.call(null, _arg_1.badgeId));
                if (((!(_local_6 == null)) && (!(_local_3.object.getEventHandler() == null))))
                {
                    _local_3.object.getEventHandler().processUpdateMessage(_local_6);
                };
                _local_4++;
            };
            _SafeStr_426.remove(_arg_1.badgeId);
            if (_SafeStr_426.length == 0)
            {
                _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", onBadgeLoaded);
            };
        }

        public function get isDecorateMode():Boolean
        {
            if (!_roomSessionManager)
            {
                return (false);
            };
            var _local_1:IRoomSession = _roomSessionManager.getSession(_SafeStr_418);
            return ((_local_1) && (_local_1.isUserDecorating));
        }

        public function get isGameMode():Boolean
        {
            return (_isGameMode);
        }

        public function set isGameMode(_arg_1:Boolean):void
        {
            _isGameMode = _arg_1;
        }

        public function showUseProductSelection(_arg_1:int, _arg_2:int, _arg_3:int=-1):void
        {
            var _local_5:int;
            var _local_4:String;
            if (_roomContentLoader != null)
            {
                _local_4 = _roomContentLoader.getActiveObjectType(_arg_2);
                _local_5 = getRoomObjectCategory(_local_4);
                events.dispatchEvent(new RoomEngineUseProductEvent("ROSM_USE_PRODUCT_FROM_INVENTORY", _SafeStr_418, _arg_3, _local_5, _arg_1, _arg_2));
            };
        }

        public function setAvatarEffect(_arg_1:int):void
        {
            if (((_sessionDataManager == null) || (_roomSessionManager == null)))
            {
                return;
            };
            var _local_2:IRoomSession = _roomSessionManager.getSession(_SafeStr_418);
            if (_local_2 == null)
            {
                return;
            };
            updateObjectUserEffect(activeRoomId, _local_2.ownUserRoomId, _arg_1);
        }

        public function get playerUnderCursor():int
        {
            return (_playerUnderCursor);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        private function fixedUserLocation(_arg_1:int, _arg_2:IVector3d):IVector3d
        {
            if (_arg_2 == null)
            {
                return (null);
            };
            var _local_5:FurniStackingHeightMap = getFurniStackingHeightMap(_arg_1);
            var _local_7:LegacyWallGeometry = getLegacyGeometry(_arg_1);
            if (((_local_5 == null) || (_local_7 == null)))
            {
                return (_arg_2);
            };
            var _local_6:Number = _arg_2.z;
            var _local_3:Number = _local_5.getTileHeight(_arg_2.x, _arg_2.y);
            var _local_4:Number = _local_7.getTileHeight(_arg_2.x, _arg_2.y);
            if (((Math.abs((_local_6 - _local_3)) < 0.1) && (Math.abs((_local_3 - _local_4)) < 0.1)))
            {
                _local_6 = _local_7.getFloorAltitude(_arg_2.x, _arg_2.y);
            };
            return (new Vector3d(_arg_2.x, _arg_2.y, _local_6));
        }

        private function get cameraFollowDuration():int
        {
            return ((getBoolean("room.camera.follow_user")) ? 1000 : 0);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function getRenderRoomMessage(_arg_1:Rectangle, _arg_2:uint, _arg_3:Boolean=false, _arg_4:Boolean=true, _arg_5:Boolean=false, _arg_6:int=-1):IMessageComposer
        {
            var _local_8:IRoomRenderingCanvas;
            if (_arg_6 > -1)
            {
                _local_8 = getRoomCanvas(_SafeStr_418, _arg_6);
            }
            else
            {
                _local_8 = getActiveRoomActiveCanvas();
            };
            if (!_local_8)
            {
                return (null);
            };
            if (_arg_5)
            {
                _local_8.skipSpriteVisibilityChecking();
            };
            var _local_12:int = -1;
            if (((!(_arg_4)) && (!(_roomSessionManager.getSession(_SafeStr_418) == null))))
            {
                _local_12 = _roomSessionManager.getSession(_SafeStr_418).ownUserRoomId;
            };
            var _local_11:SpriteDataCollector = new SpriteDataCollector();
            var _local_10:String = _local_11.getFurniData(_arg_1, _local_8, this, _local_12);
            var _local_9:String = _local_11.getRoomRenderingModifiers(this);
            var _local_7:Array = _local_11.getRoomPlanes(_arg_1, _local_8, this, _arg_2);
            if (_arg_5)
            {
                _local_8.resumeSpriteVisibilityChecking();
            };
            if (_arg_3)
            {
                return (new RenderRoomThumbnailMessageComposer(_local_7, _local_10, _local_9, _SafeStr_418, _sessionDataManager.topSecurityLevel));
            };
            return (new RenderRoomMessageComposer(_local_7, _local_10, _local_9, _SafeStr_418, _sessionDataManager.topSecurityLevel));
        }

        public function get roomContentLoader():RoomContentLoader
        {
            return (_roomContentLoader);
        }


    }
}
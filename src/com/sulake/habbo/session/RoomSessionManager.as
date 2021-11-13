package com.sulake.habbo.session
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboFreeFlowChat;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDRoomEngine;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.handler.RoomSessionHandler;
    import com.sulake.habbo.session.handler.RoomChatHandler;
    import com.sulake.habbo.session.handler.RoomUsersHandler;
    import com.sulake.habbo.session.handler.RoomPermissionsHandler;
    import com.sulake.habbo.session.handler.AvatarEffectsHandler;
    import com.sulake.habbo.session.handler.RoomDataHandler;
    import com.sulake.habbo.session.handler.PresentHandler;
    import com.sulake.habbo.session.handler.GenericErrorHandler;
    import com.sulake.habbo.session.handler.PollHandler;
    import com.sulake.habbo.session.handler.WordQuizHandler;
    import com.sulake.habbo.session.handler.RoomDimmerPresetsHandler;
    import com.sulake.habbo.session.handler.PetPackageHandler;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.roomdirectory.RoomNetworkOpenConnectionMessageComposer;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.handler.BaseHandler;
    import com.sulake.iid.*;

    public class RoomSessionManager extends Component implements IRoomSessionManager, IRoomHandlerListener 
    {

        public static const _SafeStr_1416:uint = 2;
        public static const SETUP_WITHOUT_TRACKING:uint = 3;
        public static const _SafeStr_3712:uint = 4;

        private var _communication:IHabboCommunicationManager = null;
        private var _handlers:Array = null;
        private var _SafeStr_580:Boolean = false;
        private var _SafeStr_582:Map = null;
        private var _SafeStr_583:RoomSession;
        private var _sessionStarting:Boolean = false;
        private var _habboTracking:IHabboTracking;
        private var _roomEngine:IRoomEngine;
        private var _freeFlowChat:IHabboFreeFlowChat;
        private var _SafeStr_584:Boolean;
        private var _SafeStr_581:Boolean;
        private var _SafeStr_585:Array;
        private var _viewerSession:RoomSession;

        public function RoomSessionManager(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
            _SafeStr_581 = (!((_arg_2 & 0x01) == 0));
            _handlers = [];
            _SafeStr_582 = new Map();
        }

        public function get initialized():Boolean
        {
            return ((allRequiredDependenciesInjected) && (_SafeStr_580));
        }

        public function get sessionStarting():Boolean
        {
            return (_sessionStarting);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }, ((flags & 0x02) == 0)), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _habboTracking = _arg_1;
            }, ((flags & 0x03) == 0)), new ComponentDependency(new IIDHabboFreeFlowChat(), function (_arg_1:IHabboFreeFlowChat):void
            {
                _freeFlowChat = _arg_1;
            }, false), new ComponentDependency(new IIDHabboConfigurationManager(), null), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, ((flags & 0x04) == 0), [{
                "type":"REE_ENGINE_INITIALIZED",
                "callback":onRoomEngineInitialized
            }])]));
        }

        override protected function initComponent():void
        {
            createHandlers();
            if (((_SafeStr_581) && (!(_communication == null))))
            {
                _communication.addHabboConnectionMessageEvent(new RoomVisualizationSettingsEvent(onRoomVisualizationSettings));
            };
            executePendingSessionRequest();
        }

        override public function dispose():void
        {
            var _local_4:String;
            var _local_2:RoomSession;
            var _local_3:int;
            var _local_1:IDisposable;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_582)
            {
                while (_SafeStr_582.length > 0)
                {
                    _local_4 = (_SafeStr_582.getKey(0) as String);
                    _local_2 = (_SafeStr_582.remove(_local_4) as RoomSession);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                };
                _SafeStr_582.dispose();
                _SafeStr_582 = null;
            };
            if (_handlers)
            {
                _local_3 = 0;
                while (_local_3 < _handlers.length)
                {
                    _local_1 = (_handlers[_local_3] as IDisposable);
                    if (_local_1)
                    {
                        _local_1.dispose();
                    };
                    _local_3++;
                };
                _handlers = null;
            };
            super.dispose();
        }

        private function onRoomEngineInitialized(_arg_1:RoomEngineEvent):void
        {
            _SafeStr_580 = true;
            executePendingSessionRequest();
        }

        private function createHandlers():void
        {
            var _local_1:IConnection;
            if (_communication)
            {
                _local_1 = _communication.connection;
                _handlers.push(new RoomSessionHandler(_local_1, this));
                _handlers.push(new RoomChatHandler(_local_1, this));
                _handlers.push(new RoomUsersHandler(_local_1, this));
                _handlers.push(new RoomPermissionsHandler(_local_1, this));
                _handlers.push(new AvatarEffectsHandler(_local_1, this));
                _handlers.push(new RoomDataHandler(_local_1, this));
                _handlers.push(new PresentHandler(_local_1, this));
                _handlers.push(new GenericErrorHandler(_local_1, this));
                _handlers.push(new PollHandler(_local_1, this));
                _handlers.push(new WordQuizHandler(_local_1, this));
                _handlers.push(new RoomDimmerPresetsHandler(_local_1, this));
                _handlers.push(new PetPackageHandler(_local_1, this));
            };
        }

        private function executePendingSessionRequest():void
        {
            if (((initialized) && (!(_SafeStr_583 == null))))
            {
                createSession(_SafeStr_583);
                _SafeStr_583 = null;
            };
        }

        private function onRoomVisualizationSettings(_arg_1:RoomVisualizationSettingsEvent):void
        {
            var _local_3:int;
            var _local_8:int;
            var _local_2:int;
            var _local_6:int;
            var _local_9:int;
            var _local_4:DisplayObject;
            var _local_7:IRoomGeometry;
            if (((_SafeStr_584) || (!(_SafeStr_581))))
            {
                return;
            };
            _SafeStr_584 = true;
            var _local_5:IRoomSession = getSession(0);
            if (_local_5 != null)
            {
                _local_3 = 1;
                _local_8 = 2;
                _local_2 = 2;
                _local_6 = 0x0400;
                _local_9 = 0x0300;
                _local_4 = _roomEngine.createRoomCanvas(_local_5.roomId, _local_3, _local_6, _local_9, 64);
                if (_local_4 != null)
                {
                    context.displayObjectContainer.addChild(_local_4);
                    context.displayObjectContainer.addEventListener("resize", onResize);
                    _roomEngine.setRoomCanvasMask(_local_5.roomId, _local_3, true);
                    _local_7 = _roomEngine.getRoomCanvasGeometry(_local_5.roomId, _local_3);
                    if (_local_7 != null)
                    {
                        _local_7.adjustLocation(new Vector3d(_local_8, _local_2, 0), 30);
                    };
                    _roomEngine.setRoomCanvasScreenOffset(_local_5.roomId, _local_3, new Point(0, -400));
                };
                if (((!(_freeFlowChat == null)) && (_freeFlowChat.displayObject)))
                {
                    context.displayObjectContainer.addChild(_freeFlowChat.displayObject);
                };
            };
        }

        private function onResize(_arg_1:Event):void
        {
            if (!_SafeStr_581)
            {
                return;
            };
            var _local_2:IRoomSession = getSession(0);
            if (_local_2 == null)
            {
                return;
            };
            _roomEngine.modifyRoomCanvas(_local_2.roomId, 1, context.displayObjectContainer.width, context.displayObjectContainer.height);
        }

        public function gotoRoom(_arg_1:int, _arg_2:String="", _arg_3:String=""):Boolean
        {
            var _local_4:RoomSession = new RoomSession();
            _local_4.roomId = _arg_1;
            _local_4.roomPassword = _arg_2;
            _local_4.roomResources = _arg_3;
            _local_4.habboTracking = _habboTracking;
            return (createSession(_local_4));
        }

        public function gotoRoomNetwork(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:RoomSession = new RoomSession();
            _local_3.roomId = 1;
            _local_3.roomPassword = "";
            _local_3.habboTracking = _habboTracking;
            _local_3.openConnectionComposer = new RoomNetworkOpenConnectionMessageComposer(_arg_1, _arg_2);
            return (createSession(_local_3));
        }

        private function createSession(_arg_1:RoomSession):Boolean
        {
            if (!initialized)
            {
                Logger.log(((("[RoomSessionManager] Not initialized, crating pending session for room: " + _arg_1.roomId) + ". Room Engine Initialized: ") + _SafeStr_580));
                _SafeStr_583 = _arg_1;
                return (false);
            };
            var _local_2:String = getRoomIdentifier(_arg_1.roomId);
            _sessionStarting = true;
            if (_SafeStr_582.getValue(_local_2) != null)
            {
                disposeSession(_arg_1.roomId, false);
            };
            _arg_1.connection = ((_communication) ? _communication.connection : null);
            _SafeStr_582.add(_local_2, _arg_1);
            events.dispatchEvent(new RoomSessionEvent("RSE_CREATED", _arg_1));
            if (_SafeStr_581)
            {
                _roomEngine.events.addEventListener("RCLE_SUCCESS", onRoomContentLoaded);
                _SafeStr_585 = [];
                _viewerSession = _arg_1;
                if (_SafeStr_585.length == 0)
                {
                    startSession(_arg_1);
                };
            };
            return (true);
        }

        private function onRoomContentLoaded(_arg_1:Event):void
        {
            if (((_SafeStr_585 == null) || (_SafeStr_585.length == 0)))
            {
                return;
            };
            var _local_2:int = _SafeStr_585.indexOf(_arg_1["contentType"]);
            if (_local_2 != -1)
            {
                _SafeStr_585.splice(_local_2, 1);
            };
            if (_SafeStr_585.length == 0)
            {
                startSession(_viewerSession);
            };
        }

        public function startSession(_arg_1:IRoomSession):Boolean
        {
            if (_arg_1.state == "RSE_STARTED")
            {
                return (false);
            };
            if (_arg_1.isGameSession)
            {
                return (true);
            };
            if (_arg_1.start())
            {
                _sessionStarting = false;
                events.dispatchEvent(new RoomSessionEvent("RSE_STARTED", _arg_1));
                updateHandlers(_arg_1);
            }
            else
            {
                disposeSession(_arg_1.roomId);
                _sessionStarting = false;
                return (false);
            };
            return (true);
        }

        public function startGameSession():void
        {
            var _local_1:RoomSession = new RoomSession();
            _local_1.roomId = 1;
            _local_1.habboTracking = _habboTracking;
            _local_1.isGameSession = true;
            _local_1.connection = _communication.connection;
            _SafeStr_582.add(getRoomIdentifier(_local_1.roomId), _local_1);
            events.dispatchEvent(new RoomSessionEvent("RSE_CREATED", _local_1));
        }

        public function disposeGameSession():void
        {
            var _local_2:String = getRoomIdentifier(1);
            var _local_1:RoomSession = _SafeStr_582.getValue(_local_2);
            if (((_local_1) && (_local_1.isGameSession)))
            {
                disposeSession(1, false);
            };
        }

        public function sessionUpdate(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IRoomSession = getSession(_arg_1);
            if (_local_3 != null)
            {
                switch (_arg_2)
                {
                    case "RS_CONNECTED":
                        return;
                    case "RS_READY":
                        return;
                    case "RS_DISCONNECTED":
                        disposeSession(_arg_1);
                        return;
                };
            };
        }

        public function sessionReinitialize(_arg_1:int, _arg_2:int):void
        {
            var _local_4:RoomSession;
            var _local_5:String = getRoomIdentifier(_arg_1);
            var _local_3:RoomSession = (_SafeStr_582.remove(_local_5) as RoomSession);
            if (_local_3 != null)
            {
                _local_3.reset(_arg_2);
                _local_5 = getRoomIdentifier(_arg_2);
                _local_4 = _SafeStr_582.remove(_local_5);
                if (_local_4 != null)
                {
                };
                _SafeStr_582.add(_local_5, _local_3);
                updateHandlers(_local_3);
            };
        }

        public function getSession(_arg_1:int):IRoomSession
        {
            var _local_2:String = getRoomIdentifier(_arg_1);
            return (_SafeStr_582.getValue(_local_2) as IRoomSession);
        }

        public function disposeSession(_arg_1:int, _arg_2:Boolean=true):void
        {
            var _local_4:String = getRoomIdentifier(_arg_1);
            var _local_3:RoomSession = (_SafeStr_582.remove(_local_4) as RoomSession);
            if (_local_3 != null)
            {
                events.dispatchEvent(new RoomSessionEvent("RSE_ENDED", _local_3, _arg_2));
                _local_3.dispose();
            };
        }

        private function updateHandlers(_arg_1:IRoomSession):void
        {
            var _local_3:int;
            var _local_2:BaseHandler;
            if (((!(_arg_1 == null)) && (!(_handlers == null))))
            {
                _local_3 = 0;
                while (_local_3 < _handlers.length)
                {
                    _local_2 = (_handlers[_local_3] as BaseHandler);
                    if (_local_2 != null)
                    {
                        _local_2._SafeStr_586 = _arg_1.roomId;
                    };
                    _local_3++;
                };
            };
        }

        private function getRoomIdentifier(_arg_1:int):String
        {
            return ("hard_coded_room_id");
        }


    }
}


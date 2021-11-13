package com.sulake.habbo.game.snowwar.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.game.snowwar.KeyboardControl;
    import flash.display.Stage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.IRoomCreator;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FuseObjectData;
    import com.sulake.habbo.game.snowwar.Tile;
    import flash.events.MouseEvent;
    import com.sulake.habbo.game.snowwar.utils.Direction8;
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballPileGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.TreeGameObject;
    import flash.utils.getTimer;
    import com.sulake.habbo.game.snowwar.arena.IGameObject;
    import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowWarGameObject;
    import com.sulake.habbo.game.snowwar.SnowWarGameArena;
    import com.sulake.habbo.avatar.IAvatarFigureContainer;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.habbo.game.snowwar.utils.Direction360;
    import com.sulake.habbo.room.IRoomEngineServices;
    import com.sulake.habbo.room.RoomEngine;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class GameArenaView implements IDisposable
    {

        private static const GAME_ROOM_ID:int = 1;
        private static const TILE_CURSOR_STATE_TEAM_1:int = 3;
        private static const TILE_CURSOR_STATE_TEAM_2:int = 2;
        private static const TILE_CURSOR_STATE_TEAM_3:int = 4;
        private static const TILE_CURSOR_STATE_TEAM_4:int = 5;
        private static const EFFECT_RED_TEAM:int = 95;
        private static const EFFECT_BLUE_TEAM:int = 96;
        private static const EFFECT_CROSSHAIR:int = 98;
        private static const SPLASH_LIFE_SPAN_TIME:int = 500;

        private var _SafeStr_2499:SnowWarEngine;
        private var _SafeStr_2537:Array = [];
        private var _SafeStr_2538:Array = [];
        private var _SafeStr_2539:Array = [];
        private var _SafeStr_2540:KeyboardControl;
        private var _disposed:Boolean = false;
        private var _SafeStr_2541:SnowWarUI;
        private var _SafeStr_2542:Boolean;
        private var _SafeStr_1161:Stage;
        private var _SafeStr_2543:Boolean;

        public function GameArenaView(_arg_1:SnowWarEngine)
        {
            _SafeStr_2499 = _arg_1;
            _SafeStr_2499.roomEngine.addObjectUpdateCategory(202);
        }

        public function dispose():void
        {
            _SafeStr_2499.roomEngine.disposeRoom(1);
            _SafeStr_2499.roomEngine.removeObjectUpdateCategory(202);
            if (_SafeStr_2540)
            {
                _SafeStr_2540.dispose();
                _SafeStr_2540 = null;
            };
            if (_SafeStr_1161 != null)
            {
                _SafeStr_1161.removeEventListener("mouseMove", onMouseMove);
                _SafeStr_1161 = null;
            };
            _SafeStr_2499 = null;
            _SafeStr_2537 = null;
            _SafeStr_2538 = null;
            if (_SafeStr_2541)
            {
                _SafeStr_2541.dispose();
                _SafeStr_2541 = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function init():void
        {
            var _local_11:int;
            var _local_10:int;
            var _local_12:Number;
            var _local_1:Vector3d;
            var _local_5:Vector3d;
            var _local_13:int;
            var _local_9:IStuffData;
            var _local_14:int;
            var _local_6:Number;
            _SafeStr_2499.roomEngine.isGameMode = true;
            var _local_7:SnowWarGameStage = (_SafeStr_2499.gameArena.getCurrentStage() as SnowWarGameStage);
            var _local_2:GameLevelData = _local_7.gameLevelData;
            var _local_8:Array = _local_7.getTiles();
            var _local_3:RoomPlaneParser = new RoomPlaneParser();
            _local_3.initializeTileMap(_local_2.width, _local_2.height);
            _local_11 = 0;
            while (_local_11 < _local_2.height)
            {
                _local_10 = 0;
                while (_local_10 < _local_2.width)
                {
                    _local_3.setTileHeight(_local_10, _local_11, ((_local_8[_local_11][_local_10] == null) ? -100 : 0));
                    _local_10++;
                };
                _local_11++;
            };
            _local_3.initializeFromTileData();
            _SafeStr_2499.roomEngine.initializeRoom(1, _local_3.getXML());
            (_SafeStr_2499.roomEngine as IRoomCreator).updateObjectRoomVisibilities(1, false);
            _local_3.dispose();
            for each (var _local_4:FuseObjectData in _local_7.gameLevelData.fuseObjects)
            {
                _local_12 = (_local_4.altitude / Tile.TILE_HALFWIDTH);
                _local_1 = new Vector3d(_local_4.x, _local_4.y, _local_12);
                _local_5 = new Vector3d((_local_4.direction * 45));
                _local_13 = _SafeStr_2499.roomEngine.getFurnitureTypeId(_local_4.name);
                _local_9 = _local_4.stuffData;
                _local_14 = 0;
                _local_6 = parseInt(_local_9.getLegacyString());
                if (!isNaN(_local_6))
                {
                    _local_14 = _local_6;
                };
                _SafeStr_2499.roomEngine.addObjectFurniture(1, _local_4.id, _local_13, _local_1, _local_5, _local_14, _local_9);
            };
            _SafeStr_2499.roomUI.visible = false;
            _SafeStr_1161 = _SafeStr_2499.context.displayObjectContainer.stage;
            _SafeStr_1161.addEventListener("mouseMove", onMouseMove);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            _SafeStr_2543 = ((_arg_1.altKey) || (_arg_1.shiftKey));
        }

        public function initGameUI(_arg_1:int):void
        {
            _SafeStr_2541 = new SnowWarUI(_SafeStr_2499);
            _SafeStr_2541.init();
            initCountDown();
        }

        public function removeGameUI():void
        {
            if (_SafeStr_2541)
            {
                _SafeStr_2541.dispose();
                _SafeStr_2541 = null;
            };
        }

        public function update(_arg_1:uint, _arg_2:Boolean=false):void
        {
            var _local_11:Direction8;
            var _local_25:HumanGameObject;
            var _local_16:Number;
            var _local_13:Number;
            var _local_9:int;
            var _local_18:int;
            var _local_5:int;
            var _local_17:IRoomObject;
            var _local_22:IVector3d;
            var _local_21:int;
            var _local_26:*;
            var _local_7:HumanGameObject;
            var _local_4:Boolean;
            var _local_19:int;
            var _local_24:SnowBallGameObject;
            var _local_6:SnowballMachineGameObject;
            var _local_8:SnowballPileGameObject;
            var _local_20:TreeGameObject;
            if (((_arg_2) && (_SafeStr_2540)))
            {
                _local_11 = _SafeStr_2540.direction;
                if (_local_11)
                {
                    _local_25 = (_SafeStr_2499.gameArena.getCurrentStage().getGameObject(_SafeStr_2499.ownId) as HumanGameObject);
                    _local_16 = (_local_25.currentLocation.x / 3200);
                    _local_13 = (_local_25.currentLocation.y / 3200);
                    _local_16 = (_local_16 + (_local_11.getUnitVectorXcomponent() * 2));
                    _local_13 = (_local_13 + (_local_11.getUnitVectorYcomponent() * 2));
                    _SafeStr_2499.moveOwnAvatarTo(_local_16, _local_13);
                };
            };
            var _local_23:int = getTimer();
            for each (var _local_12:IGameObject in _SafeStr_2499.gameArena.getCurrentStage().resetRemovedGameObjects())
            {
                _local_9 = _local_12.gameObjectId;
                _local_18 = _SafeStr_2537.indexOf(_local_9);
                if (_local_18 > -1)
                {
                    _SafeStr_2499.roomEngine.disposeObjectUser(1, _local_9);
                    _SafeStr_2537.splice(_local_18, 1);
                };
                _local_5 = _SafeStr_2538.indexOf(_local_9);
                if (_local_5 > -1)
                {
                    _local_17 = _SafeStr_2499.roomEngine.getRoomObject(1, _local_9, 201);
                    _local_22 = _local_17.getLocation();
                    _SafeStr_2499.roomEngine.disposeObjectSnowWar(1, _local_9, 201);
                    _SafeStr_2538.splice(_local_5, 1);
                    if (!ISynchronizedGameObject(_local_12).isActive)
                    {
                        _SafeStr_2499.roomEngine.addObjectSnowWar(1, _local_9, _local_22, 202);
                        _SafeStr_2539.push({
                            "id":_local_9,
                            "time":_local_23,
                            "category":202
                        });
                    };
                };
            };
            _local_21 = (_SafeStr_2539.length - 1);
            while (_local_21 > -1)
            {
                _local_26 = _SafeStr_2539[_local_21];
                if ((_local_23 - _local_26.time) >= 500)
                {
                    _SafeStr_2499.roomEngine.disposeObjectSnowWar(1, _local_26.id, _local_26.category);
                    _SafeStr_2539.splice(_local_21, 1);
                };
                _local_21--;
            };
            var _local_10:Array = _SafeStr_2499.gameArena.getCurrentStage().getGameObjects();
            var _local_15:Boolean;
            for each (var _local_3:SnowWarGameObject in _local_10)
            {
                _local_7 = (_local_3 as HumanGameObject);
                if (_local_7)
                {
                    _local_4 = (_local_7.posture == "swrun");
                    _local_15 = ((_local_15) || (_local_4));
                    updateHumanGameObject(_local_7);
                    if (_local_7.gameObjectId == _SafeStr_2499.ownId)
                    {
                        _local_19 = (_SafeStr_2499.gameArena.getExtension() as SnowWarGameArena).getPulseInterval();
                        _SafeStr_2541.timer = (_SafeStr_2499.stageLength - ((_SafeStr_2499.currentSubTurn * _local_19) / 1000));
                        _SafeStr_2541.ownScore = _local_7.score;
                        _SafeStr_2541.snowballs = _local_7.snowballs;
                        _SafeStr_2541.hitPoints = _local_7.hitPoints;
                    };
                };
                _local_24 = (_local_3 as SnowBallGameObject);
                if (_local_24)
                {
                    updateSnowballGameObject(_local_24);
                };
                _local_6 = (_local_3 as SnowballMachineGameObject);
                if (_local_6)
                {
                    updateSnowballMachineGameObject(_local_6);
                };
                _local_8 = (_local_3 as SnowballPileGameObject);
                if (_local_8)
                {
                    updateSnowballPileGameObject(_local_8);
                };
                _local_20 = (_local_3 as TreeGameObject);
                if (_local_20)
                {
                    updateTreeGameObject(_local_20);
                };
            };
            if (_SafeStr_2541)
            {
                _SafeStr_2541.update(_arg_1);
            };
            if (((_local_15) && (!(_SafeStr_2542))))
            {
                _SafeStr_2542 = true;
                SnowWarEngine.playSound("HBSTG_snowwar_walk", 2147483647);
            }
            else
            {
                if (((!(_local_15)) && (_SafeStr_2542)))
                {
                    _SafeStr_2542 = false;
                    SnowWarEngine.stopSound("HBSTG_snowwar_walk");
                };
            };
            var _local_14:HumanGameObject = _SafeStr_2499.getCurrentPlayer();
            _SafeStr_2499.roomEngine.updateObjectUserEffect(1, _local_14.gameObjectId, ((_local_14.team == 1) ? 96 : 95));
        }

        private function updateHumanGameObject(_arg_1:HumanGameObject):void
        {
            var _local_3:IAvatarFigureContainer;
            var _local_9:Boolean;
            var _local_12:IRoomObjectSpriteVisualization;
            var _local_6:Boolean;
            var _local_7:Number = (_arg_1.currentLocation.x / 3200);
            var _local_4:Number = (_arg_1.currentLocation.y / 3200);
            var _local_5:int = _arg_1.gameObjectId;
            var _local_10:int = _arg_1.getBodyDirection();
            var _local_8:int = Direction360.direction8ToDirection360Value(Direction8.getDirection8(_local_10));
            var _local_2:IVector3d = new Vector3d(_local_8, 0, 0);
            if (_SafeStr_2537.indexOf(_local_5) == -1)
            {
                _local_3 = _SafeStr_2499.avatarManager.createFigureContainer(_arg_1.figure);
                switch (_arg_1.team)
                {
                    case 1:
                        _local_3.updatePart("ch", 20000, [1]);
                        break;
                    case 2:
                        _local_3.updatePart("ch", 20001, [1]);
                        break;
                    default:
                        _local_3.updatePart("ch", 20000, [1]);
                };
                _local_3.removePart("cc");
                _SafeStr_2499.roomEngine.addObjectUser(1, _local_5, new Vector3d(_local_7, _local_4, 0), _local_2, _local_8, 1, _local_3.getFigureString());
                _SafeStr_2499.roomEngine.updateObjectUserPosture(1, _local_5, "std");
                _SafeStr_2499.roomEngine.updateObjectUserAction(1, _local_5, "figure_is_playing_game", 1);
                _SafeStr_2537.push(_local_5);
                switch (_arg_1.visualizationMode)
                {
                    case 1:
                        visualizeAsGhost(getRoomUserObject(_local_5));
                        break;
                    case 2:
                        hideVisualization(getRoomUserObject(_local_5));
                    default:
                };
            }
            else
            {
                _SafeStr_2499.roomEngine.updateObjectUser(1, _local_5, new Vector3d(_local_7, _local_4, 0), new Vector3d(_local_7, _local_4, 0), false, 0, _local_2, _local_8);
                _SafeStr_2499.roomEngine.updateObjectUserPosture(1, _local_5, _arg_1.posture);
                _local_9 = ((!(_arg_1.posture == "swdieback")) && (!(_arg_1.posture == "swdiefront")));
                _SafeStr_2499.roomEngine.updateObjectUserAction(1, _local_5, "figure_is_playing_game", int(_local_9));
            };
            var _local_11:IRoomObject = getRoomUserObject(_local_5);
            if (_local_11 != null)
            {
                _local_12 = (_local_11.getVisualization() as IRoomObjectSpriteVisualization);
                _local_12.getSprite(0).alpha = ((_arg_1.invincible) ? 100 : 0xFF);
                _local_6 = (!(_arg_1.team == _SafeStr_2499.getCurrentPlayer().team));
                if (_local_6)
                {
                    if (((((_SafeStr_2499.roomEngine as IRoomEngineServices).playerUnderCursor == _local_5) && (!(_arg_1.invincible))) && (!(_arg_1.isStunned()))))
                    {
                        _SafeStr_2499.roomEngine.updateObjectUserEffect(1, _local_5, 98);
                    }
                    else
                    {
                        _SafeStr_2499.roomEngine.updateObjectUserEffect(1, _local_5, 0);
                    };
                };
            };
        }

        private function updateSnowballGameObject(_arg_1:SnowBallGameObject):void
        {
            var _local_5:Number = (_arg_1.location3D.x / 3200);
            var _local_3:Number = (_arg_1.location3D.y / 3200);
            var _local_4:Number = (_arg_1.location3D.z / Tile.TILE_HALFWIDTH);
            var _local_2:Vector3d = new Vector3d(_local_5, _local_3, _local_4);
            var _local_6:int = _arg_1.gameObjectId;
            if (_SafeStr_2538.indexOf(_local_6) == -1)
            {
                _SafeStr_2499.roomEngine.addObjectSnowWar(1, _local_6, _local_2, 201);
                _SafeStr_2538.push(_local_6);
            }
            else
            {
                _SafeStr_2499.roomEngine.updateObjectSnowWar(1, _local_6, _local_2, 201);
            };
        }

        private function updateSnowballMachineGameObject(_arg_1:SnowballMachineGameObject):void
        {
            var _local_3:RoomEngine = (_SafeStr_2499.roomEngine as RoomEngine);
            var _local_2:IRoomObjectController = (_local_3.getRoomObject(1, _arg_1.fuseObjectId, 10) as IRoomObjectController);
            if (_local_2.getState(0) != _arg_1.snowballCount)
            {
                _local_3.updateObjectFurniture(1, _arg_1.fuseObjectId, null, null, _arg_1.snowballCount, null);
                _local_2.setState(_arg_1.snowballCount, 0);
            };
        }

        private function updateSnowballPileGameObject(_arg_1:SnowballPileGameObject):void
        {
            var _local_3:RoomEngine = (_SafeStr_2499.roomEngine as RoomEngine);
            var _local_2:IRoomObjectController = (_local_3.getRoomObject(1, _arg_1.fuseObjectId, 10) as IRoomObjectController);
            var _local_4:int = (_arg_1.maxSnowballs - _arg_1.snowballCount);
            if (((_local_2) && (!(_local_2.getState(0) == _local_4))))
            {
                _local_3.updateObjectFurniture(1, _arg_1.fuseObjectId, null, null, _local_4, null);
                _local_2.setState(_local_4, 0);
            };
        }

        private function updateTreeGameObject(_arg_1:TreeGameObject):void
        {
            var _local_3:RoomEngine = (_SafeStr_2499.roomEngine as RoomEngine);
            var _local_2:IRoomObjectController = (_local_3.getRoomObject(1, _arg_1.fuseObjectId, 10) as IRoomObjectController);
            if (((_local_2) && (!(_local_2.getState(0) == _arg_1.hits))))
            {
                _local_3.updateObjectFurniture(1, _arg_1.fuseObjectId, null, null, _arg_1.hits, null);
                _local_2.setState(_arg_1.hits, 0);
            };
        }

        private function getRoomUserObject(_arg_1:int):IRoomObject
        {
            return (_SafeStr_2499.roomEngine.getRoomObject(1, _arg_1, 100));
        }

        private function visualizeAsGhost(_arg_1:IRoomObject):void
        {
            var _local_2:IRoomObjectSpriteVisualization;
            var _local_4:int;
            var _local_3:IRoomObjectSprite;
            if (_arg_1)
            {
                _local_2 = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
                _local_4 = 0;
                while (_local_4 < _local_2.spriteCount)
                {
                    _local_3 = _local_2.getSprite(_local_4);
                    _local_3.blendMode = "hardlight";
                    _local_4++;
                };
            };
        }

        private function hideVisualization(_arg_1:IRoomObject):void
        {
            var _local_2:IRoomObjectSpriteVisualization;
            var _local_4:int;
            var _local_3:IRoomObjectSprite;
            if (_arg_1)
            {
                _local_2 = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
                _local_4 = 0;
                while (_local_4 < _local_2.spriteCount)
                {
                    _local_3 = _local_2.getSprite(_local_4);
                    _local_3.visible = false;
                    _local_4++;
                };
            };
        }

        public function showChecksumError(_arg_1:uint):void
        {
            _SafeStr_2541.showChecksumError(_arg_1);
        }

        private function initCountDown():void
        {
            _SafeStr_2541.initCounter();
            _SafeStr_2541.update(1000);
        }

        public function updateTileCursor(_arg_1:int):void
        {
            var _local_2:int;
            switch (_arg_1)
            {
                case 1:
                    _local_2 = 3;
                    break;
                case 2:
                    _local_2 = 2;
                    break;
                case 3:
                    _local_2 = 4;
                    break;
                case 4:
                    _local_2 = 5;
                    break;
                default:
                    _local_2 = 0;
            };
            _SafeStr_2499.roomEngine.setTileCursorState(1, _local_2);
        }

        public function stopWaitingForSnowball():void
        {
            if (_SafeStr_2541)
            {
                _SafeStr_2541.stopWaitingForSnowball();
            };
        }

        public function startWaitingForSnowball():void
        {
            if (_SafeStr_2541)
            {
                _SafeStr_2541.startWaitingForSnowball();
            };
        }

        public function flashOwnScore(_arg_1:Boolean):void
        {
            if (_SafeStr_2541)
            {
                _SafeStr_2541.flashOwnScore(_arg_1);
            };
        }


    }
}
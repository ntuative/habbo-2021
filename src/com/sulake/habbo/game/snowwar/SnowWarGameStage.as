package com.sulake.habbo.game.snowwar
{
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.game.snowwar.utils.Direction360;
    import com.sulake.habbo.game.snowwar.utils.Direction8;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FuseObjectData;
    import com.sulake.habbo.game.snowwar.utils.Location3D;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowWarGameObject;
    import com.sulake.habbo.game.snowwar.utils.ICollidable;

    public class SnowWarGameStage extends SynchronizedGameStage 
    {

        public static const SCREEN_CENTER_TILE_X:int = 25;
        public static const SCREEN_CENTER_TILE_Y:int = 25;
        private static const INFINITE_HEIGHT:int = 100000;

        private var _tiles:Array = [];


        public static function calculateDirectionTowardsCenter(_arg_1:Tile):Direction8
        {
            return (Direction360.direction360ValueToDirection8(Direction360.getAngleFromComponents((25 - _arg_1.fuseLocation[0]), (25 - _arg_1.fuseLocation[1]))));
        }


        override public function dispose():void
        {
            var _local_3:int;
            var _local_1:int;
            var _local_2:Tile;
            super.dispose();
            if (((_tiles) && (_tiles.length > 0)))
            {
                _local_3 = 0;
                while (_local_3 < _tiles.length)
                {
                    _local_1 = 0;
                    while (_local_1 < (_tiles[0] as Array).length)
                    {
                        _local_2 = _tiles[_local_3][_local_1];
                        if (_local_2)
                        {
                            _local_2.dispose();
                        };
                        _local_1++;
                    };
                    _local_3++;
                };
            };
            _tiles = [];
        }

        override public function initialize(_arg_1:SynchronizedGameArena, _arg_2:GameLevelData):void
        {
            super.initialize(_arg_1, _arg_2);
            if (_SafeStr_2482 == null)
            {
                _SafeStr_2482 = new Map();
            };
            linkTiles(_arg_2);
            addFuseObjectsAndHeights(_arg_2.fuseObjects);
        }

        private function addFuseObjectsAndHeights(_arg_1:Array):void
        {
            var _local_2:Tile;
            for each (var _local_3:FuseObjectData in _arg_1)
            {
                _local_2 = getTileAt(_local_3.x, _local_3.y);
                if (_local_2)
                {
                    _local_2.addFuseObject(_local_3);
                    checkAndAdjustNeighbouringTiles(_local_3);
                };
            };
        }

        private function checkAndAdjustNeighbouringTiles(_arg_1:FuseObjectData):void
        {
            var _local_5:Tile;
            var _local_2:int;
            var _local_6:int;
            var _local_7:int = _arg_1.direction;
            var _local_3:int = _arg_1.xDimension;
            var _local_4:int = _arg_1.yDimension;
            if (((_local_7 == Direction8.E.intValue()) || (_local_7 == Direction8.W.intValue())))
            {
                _local_2 = _local_3;
                _local_3 = _local_4;
                _local_4 = _local_2;
            };
            _local_6 = 1;
            while (_local_6 < _local_3)
            {
                _local_5 = getTileAt((_arg_1.x + _local_6), _arg_1.y);
                if (_local_5)
                {
                    _local_5.addToHeight(_arg_1.height);
                    if (!_arg_1.canStandOn)
                    {
                        _local_5.blocked = true;
                    };
                };
                _local_6++;
            };
            _local_6 = 1;
            while (_local_6 < _local_4)
            {
                _local_5 = getTileAt(_arg_1.x, (_arg_1.y + _local_6));
                if (_local_5)
                {
                    _local_5.addToHeight(_arg_1.height);
                    if (!_arg_1.canStandOn)
                    {
                        _local_5.blocked = true;
                    };
                };
                _local_6++;
            };
        }

        public function addGameObjectToTile(_arg_1:SnowWarGameObject):void
        {
            var _local_3:Location3D = _arg_1.location3D;
            var _local_2:Tile = getTileAt(Tile.convertToTileX(_local_3.x), Tile.convertToTileY(_local_3.y));
            if (_local_2)
            {
                _local_2.addGameObject(_arg_1);
            };
        }

        private function linkTiles(_arg_1:GameLevelData):void
        {
            var _local_7:Tile;
            var _local_10:int;
            var _local_8:int;
            var _local_11:Tile;
            var _local_6:Tile;
            var _local_2:Tile;
            var _local_3:Tile;
            var _local_5:Array = parseHeightMap(_arg_1.heightMap, _arg_1.width, _arg_1.height);
            var _local_9:int = _arg_1.height;
            var _local_4:int = _arg_1.width;
            _tiles = [];
            _local_10 = 0;
            while (_local_10 < _local_9)
            {
                _tiles[_local_10] = [];
                _local_8 = 0;
                while (_local_8 < _local_4)
                {
                    _tiles[_local_10][_local_8] = null;
                    if (_local_5[_local_10][_local_8] != 100000)
                    {
                        _local_7 = new Tile(_local_8, _local_10);
                        _tiles[_local_10][_local_8] = _local_7;
                        _local_11 = getTileAt((_local_8 + 1), (_local_10 - 1));
                        if (_local_11 != null)
                        {
                            _local_7.linkTile(_local_11, Direction8.NE);
                        };
                        _local_6 = getTileAt(_local_8, (_local_10 - 1));
                        if (_local_6 != null)
                        {
                            _local_7.linkTile(_local_6, Direction8.N);
                        };
                        _local_2 = getTileAt((_local_8 - 1), (_local_10 - 1));
                        if (_local_2 != null)
                        {
                            _local_7.linkTile(_local_2, Direction8.NW);
                        };
                        _local_3 = getTileAt((_local_8 - 1), _local_10);
                        if (_local_3 != null)
                        {
                            _local_7.linkTile(_local_3, Direction8.W);
                        };
                    };
                    _local_8++;
                };
                _local_10++;
            };
        }

        public function getTiles():Array
        {
            return (_tiles);
        }

        public function testCollisionWithGround(_arg_1:ICollidable):Boolean
        {
            if (_arg_1.location3D.z < 1)
            {
                return (true);
            };
            var _local_3:int = Tile.convertToTileX(_arg_1.location3D.x);
            var _local_4:int = Tile.convertToTileY(_arg_1.location3D.y);
            var _local_2:Tile = getTileAt(_local_3, _local_4);
            if (_local_2)
            {
                return (_arg_1.location3D.z < _local_2.height);
            };
            return (false);
        }

        public function positionIsWalkable(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:int = Tile.convertToTileX(_arg_1);
            var _local_5:int = Tile.convertToTileY(_arg_2);
            var _local_3:Tile = getTileAt(_local_4, _local_5);
            if (_local_3)
            {
                return (_local_3.canMoveTo(null));
            };
            return (false);
        }

        public function getTileAt(_arg_1:int, _arg_2:int):Tile
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _tiles[0].length)) || (_arg_2 < 0)) || (_arg_2 >= _tiles.length)))
            {
                return (null);
            };
            return (_tiles[_arg_2][_arg_1]);
        }

        private function parseHeightMap(_arg_1:String, _arg_2:int, _arg_3:int):Array
        {
            var _local_7:int;
            var _local_6:String;
            var _local_8:int;
            var _local_4:String;
            var _local_11:int;
            var _local_9:int;
            var _local_10:Array = _arg_1.split("\r");
            var _local_5:Array = [];
            _local_7 = 0;
            while (_local_7 < _local_10.length)
            {
                _local_6 = _local_10[_local_7];
                _local_5[_local_7] = [];
                _local_8 = (_local_6.length - 1);
                while (_local_8 >= 0)
                {
                    _local_4 = _local_6.charAt(_local_8);
                    _local_11 = parseInt(_local_4);
                    if (!isNaN(parseInt(_local_4)))
                    {
                        _local_5[_local_7][_local_8] = _local_11;
                    }
                    else
                    {
                        if (_local_4 == "x")
                        {
                            _local_5[_local_7][_local_8] = 100000;
                        }
                        else
                        {
                            _local_5[_local_7][_local_8] = (10 + (_local_4.charCodeAt(0) - "a".charCodeAt(0)));
                        };
                    };
                    if (((_local_5[_local_7][_local_8] > _local_9) && (!(_local_5[_local_7][_local_8] == 100000))))
                    {
                        _local_9 = _local_5[_local_7][_local_8];
                    };
                    _local_8--;
                };
                _local_7++;
            };
            return (_local_5);
        }

        public function resetTiles():void
        {
            var _local_3:int;
            var _local_1:int;
            var _local_2:Tile;
            if (((_tiles) && (_tiles.length > 0)))
            {
                _local_3 = 0;
                while (_local_3 < _tiles.length)
                {
                    _local_1 = 0;
                    while (_local_1 < (_tiles[0] as Array).length)
                    {
                        _local_2 = _tiles[_local_3][_local_1];
                        if (_local_2)
                        {
                            _local_2.removeGameObject();
                        };
                        _local_1++;
                    };
                    _local_3++;
                };
            };
        }


    }
}


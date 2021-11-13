package com.sulake.habbo.game.snowwar
{
    import com.sulake.habbo.game.snowwar.utils.AbstractAStarNode;
    import com.sulake.habbo.game.snowwar.utils._SafeStr_206;
    import com.sulake.habbo.game.snowwar.utils.Location3D;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowWarGameObject;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FuseObjectData;
    import com.sulake.habbo.game.snowwar.utils.Direction8;
    import com.sulake.habbo.game.snowwar.arena.IGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.utils.IAStarNode;

    public class Tile extends AbstractAStarNode 
    {

        public static const TILE_WIDTH:int = 3200;
        public static const TILE_HALFWIDTH:int = _SafeStr_206.javaDiv((3200 / 2));
        public static const TILE_ONEANDHALFWIDTH:int = (3200 + TILE_HALFWIDTH);
        public static const TILE_DIAMETER:int = Math.sqrt(20480000);

        private var _location:Location3D;
        private var _SafeStr_2604:Array;
        private var _gameObject:SnowWarGameObject;
        private var _fuseLocation:Array;
        private var _fuseObjects:Array;
        private var _SafeStr_2605:Boolean;
        private var _height:int;

        public function Tile(_arg_1:int, _arg_2:int)
        {
            _SafeStr_2604 = [];
            _fuseLocation = [_arg_1, _arg_2, 0];
            _location = new Location3D((_arg_1 * 3200), (_arg_2 * 3200), 0);
            _fuseObjects = [];
        }

        public static function convertToTileX(_arg_1:int):int
        {
            return (_SafeStr_206.javaDiv(((_arg_1 + Tile.TILE_HALFWIDTH) / 3200)));
        }

        public static function convertToTileY(_arg_1:int):int
        {
            return (_SafeStr_206.javaDiv(((_arg_1 + Tile.TILE_HALFWIDTH) / 3200)));
        }

        public static function convertFromTileX(_arg_1:int):int
        {
            return (_arg_1 * 3200);
        }

        public static function convertFromTileY(_arg_1:int):int
        {
            return (_arg_1 * 3200);
        }


        override public function dispose():void
        {
            super.dispose();
            if (_location != null)
            {
                _location.dispose();
                _location = null;
            };
            _SafeStr_2604 = [];
            _gameObject = null;
            _fuseLocation = [];
            _fuseObjects = [];
            _SafeStr_2605 = false;
        }

        public function get fuseObjects():Array
        {
            return (_fuseObjects);
        }

        public function addFuseObject(_arg_1:FuseObjectData):void
        {
            fuseObjects.push(_arg_1);
            addToHeight(_arg_1.height);
        }

        public function addToHeight(_arg_1:int):void
        {
            _height = (_height + _arg_1);
            if (_height < 0)
            {
                _height = 0;
            };
        }

        public function get fuseLocation():Array
        {
            return (_fuseLocation);
        }

        public function get location():Location3D
        {
            return (_location);
        }

        public function locationIsInTileRange(_arg_1:Location3D):Boolean
        {
            var _local_2:int = (_location.x - _arg_1.x);
            if (_local_2 < 0)
            {
                _local_2 = -(_local_2);
            };
            var _local_3:int = (_location.y - _arg_1.y);
            if (_local_3 < 0)
            {
                _local_3 = -(_local_3);
            };
            return ((_local_2 < TILE_HALFWIDTH) && (_local_3 < TILE_HALFWIDTH));
        }

        public function linkTile(_arg_1:Tile, _arg_2:Direction8):void
        {
            createLinkToTile(_arg_1, _arg_2);
            _arg_1.createLinkToTile(this, _arg_2.oppositeDirection());
        }

        private function createLinkToTile(_arg_1:Tile, _arg_2:Direction8):void
        {
            _SafeStr_2604[_arg_2.intValue()] = _arg_1;
        }

        public function getTileInDirection(_arg_1:Direction8):Tile
        {
            return (_SafeStr_2604[_arg_1.intValue()]);
        }

        public function canMoveTo(_arg_1:IGameObject):Boolean
        {
            var _local_2:Boolean;
            if (_arg_1)
            {
                _local_2 = (((!(occupyingHuman == null)) && (_arg_1.isGhost)) && (occupyingHuman.ghostObjectId == _arg_1.gameObjectId));
            };
            var _local_3:Boolean;
            if (fuseObjects.length == 1)
            {
                _local_3 = (!((fuseObjects[0] as FuseObjectData).canStandOn));
            }
            else
            {
                if (fuseObjects.length > 1)
                {
                    _local_3 = true;
                };
            };
            return (((!(_local_3)) && ((_gameObject == null) || (_local_2))) && (!(_SafeStr_2605)));
        }

        public function addGameObject(_arg_1:SnowWarGameObject):Boolean
        {
            var _local_2:Boolean;
            if (!_gameObject)
            {
                _gameObject = _arg_1;
                _local_2 = true;
            };
            return (_local_2);
        }

        public function removeGameObject():SnowWarGameObject
        {
            var _local_1:SnowWarGameObject;
            if (_gameObject)
            {
                _local_1 = _gameObject;
                _gameObject = null;
            };
            return (_local_1);
        }

        public function get gameObject():SnowWarGameObject
        {
            return (_gameObject);
        }

        public function get occupyingHuman():HumanGameObject
        {
            if (((_gameObject) && (_gameObject is HumanGameObject)))
            {
                return (gameObject as HumanGameObject);
            };
            return (null);
        }

        public function removeOccupyingHuman():HumanGameObject
        {
            var _local_1:HumanGameObject = occupyingHuman;
            if (_local_1)
            {
                _gameObject = null;
            };
            return (_local_1);
        }

        override public function distanceTo(_arg_1:IAStarNode):int
        {
            var _local_2:Tile = (_arg_1 as Tile);
            return (_location.distanceTo(_local_2.location));
        }

        override public function directionTo(_arg_1:IAStarNode):Direction8
        {
            var _local_2:Tile = (_arg_1 as Tile);
            return (_location.directionTo(_local_2.location));
        }

        override public function getNodeAt(_arg_1:Direction8):IAStarNode
        {
            return (_SafeStr_2604[_arg_1.intValue()]);
        }

        override public function directionIsBlocked(_arg_1:Direction8, _arg_2:IGameObject):Boolean
        {
            return (canMoveTo(_arg_2));
        }

        override public function getPathCost(_arg_1:Direction8, _arg_2:IGameObject):int
        {
            if (_arg_1.isDiagonal())
            {
                return (3200);
            };
            return (TILE_DIAMETER);
        }

        public function get height():int
        {
            return (_height);
        }

        public function toString():String
        {
            return (((((" X:" + _location.x) + " Y:") + _location.y) + " Z:") + _location.z);
        }

        public function set blocked(_arg_1:Boolean):void
        {
            _SafeStr_2605 = _arg_1;
        }


    }
}


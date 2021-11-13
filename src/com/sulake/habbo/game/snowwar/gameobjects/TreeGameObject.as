package com.sulake.habbo.game.snowwar.gameobjects
{
    import com.sulake.habbo.game.snowwar.Tile;
    import com.sulake.habbo.game.snowwar.utils.Direction8;
    import com.sulake.habbo.game.snowwar.utils.Direction360;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.TreeGameObjectData;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;
    import com.sulake.core.runtime.exceptions.Exception;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.game.snowwar.utils.Location3D;

    public class TreeGameObject extends SnowWarGameObject 
    {

        private static const NO_BOUNDING_DATA:Array = [0];
        private static const BOUNDING_DATA:Array = [((3200 - SnowBallGameObject.BOUNDING_DATA[0]) - 1)];

        private var _fuseObjectId:int;
        private var _SafeStr_2511:Tile;
        private var _direction8:Direction8;
        private var _direction360:Direction360;
        private var _collisionHeight:int;
        private var _maxHits:int;
        private var _hits:int;

        public function TreeGameObject(_arg_1:TreeGameObjectData, _arg_2:SnowWarGameStage)
        {
            super(_arg_1.id, false);
            isActive = true;
            _SafeStr_2511 = _arg_2.getTileAt(Tile.convertToTileX(_arg_1.locationX3D), Tile.convertToTileY(_arg_1.locationY3D));
            _direction8 = Direction8.getDirection8(_arg_1.direction);
            _direction360 = new Direction360(Direction360.direction8ToDirection360Value(_direction8));
            _fuseObjectId = _arg_1.fuseObjectId;
            _collisionHeight = _arg_1.height;
            _hits = _arg_1.hits;
            _maxHits = _arg_1.maxHits;
            if (_hits < _maxHits)
            {
                _arg_2.addGameObjectToTile(this);
            };
            _SafeStr_2511.addToHeight(-(_collisionHeight));
            _SafeStr_2511.blocked = true;
        }

        override public function get numberOfVariables():int
        {
            return (9);
        }

        override public function getVariable(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (2);
                case 1:
                    return (gameObjectId);
                case 2:
                    return (_SafeStr_2511.location.x);
                case 3:
                    return (_SafeStr_2511.location.y);
                case 4:
                    return (_direction8.intValue());
                case 5:
                    return (_collisionHeight);
                case 6:
                    return (_fuseObjectId);
                case 7:
                    return (_maxHits);
                case 8:
                    return (_hits);
                default:
                    throw (new Exception(("No such variable:" + _arg_1)));
            };
        }

        override public function get boundingType():int
        {
            return (2);
        }

        override public function subturn(_arg_1:SynchronizedGameStage):void
        {
        }

        override public function get boundingData():Array
        {
            if (_hits < _maxHits)
            {
                return (BOUNDING_DATA);
            };
            return (NO_BOUNDING_DATA);
        }

        override public function get location3D():Location3D
        {
            return (_SafeStr_2511.location);
        }

        override public function get direction360():Direction360
        {
            return (_direction360);
        }

        override public function onSnowBallHit(_arg_1:SnowWarGameStage, _arg_2:SnowBallGameObject):void
        {
            if (_hits < _maxHits)
            {
                _hits++;
            };
            if (_hits >= _maxHits)
            {
                _SafeStr_2511.removeGameObject();
            };
        }

        public function get maxHits():int
        {
            return (_maxHits);
        }

        public function get hits():int
        {
            return (_hits);
        }

        public function get fuseObjectId():int
        {
            return (_fuseObjectId);
        }

        override public function get collisionHeight():int
        {
            return (_collisionHeight);
        }


    }
}


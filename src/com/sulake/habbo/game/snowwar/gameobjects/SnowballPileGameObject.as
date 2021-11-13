package com.sulake.habbo.game.snowwar.gameobjects
{
    import com.sulake.habbo.game.snowwar.Tile;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballPileGameObjectData;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;
    import com.sulake.core.runtime.exceptions.Exception;

    public class SnowballPileGameObject extends SnowballGivingGameObject 
    {

        private static const BOUNDING_DATA_PER_SNOWBALL:int = 100;

        private var _boundingData:Array;
        private var _maxSnowballs:int;

        public function SnowballPileGameObject(_arg_1:SnowballPileGameObjectData, _arg_2:SnowWarGameStage)
        {
            super(_arg_1.id, _arg_1.snowballCount, _arg_2.getTileAt(Tile.convertToTileX(_arg_1.locationX3D), Tile.convertToTileY(_arg_1.locationY3D)), _arg_1.fuseObjectId);
            _maxSnowballs = _arg_1.maxSnowballs;
            if (_SafeStr_2510 > 0)
            {
                _arg_2.addGameObjectToTile(this);
            };
            _boundingData = [(_SafeStr_2510 * 100)];
        }

        override public function get numberOfVariables():int
        {
            return (7);
        }

        override public function getVariable(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (3);
                case 1:
                    return (_SafeStr_2501);
                case 2:
                    return (_SafeStr_2491.location.x);
                case 3:
                    return (_SafeStr_2491.location.y);
                case 4:
                    return (_maxSnowballs);
                case 5:
                    return (_SafeStr_2510);
                case 6:
                    return (_SafeStr_2509);
                default:
                    throw (new Exception(("No such variable:" + _arg_1)));
            };
        }

        override public function get boundingData():Array
        {
            return (_boundingData);
        }

        override protected function onSnowballPickup():void
        {
            _boundingData = [(_SafeStr_2510 * 100)];
            if (_SafeStr_2510 <= 0)
            {
                _SafeStr_2491.removeGameObject();
            };
        }

        public function get maxSnowballs():int
        {
            return (_maxSnowballs);
        }


    }
}


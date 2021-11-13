package com.sulake.habbo.game.snowwar.gameobjects
{
    import com.sulake.habbo.game.snowwar.utils.Direction8;
    import com.sulake.habbo.game.snowwar.Tile;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballMachineGameObjectData;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;
    import com.sulake.core.runtime.exceptions.Exception;

    public class SnowballMachineGameObject extends SnowballGivingGameObject 
    {

        public static var BOUNDING_DATA:Array = [1200];

        private var _maxSnowballs:int;
        private var _currentDirection:Direction8;

        public function SnowballMachineGameObject(_arg_1:SnowballMachineGameObjectData, _arg_2:SnowWarGameStage)
        {
            super(_arg_1.id, _arg_1.snowballCount, _arg_2.getTileAt(Tile.convertToTileX(_arg_1.locationX3D), Tile.convertToTileY(_arg_1.locationY3D)), _arg_1.fuseObjectId);
            _maxSnowballs = _arg_1.maxSnowballs;
            _currentDirection = Direction8.getDirection8(_arg_1.direction);
            _arg_2.addGameObjectToTile(this);
        }

        override public function dispose():void
        {
            super.dispose();
            _currentDirection = null;
        }

        override public function get numberOfVariables():int
        {
            return (8);
        }

        override public function getVariable(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (4);
                case 1:
                    return (_SafeStr_2501);
                case 2:
                    return (_SafeStr_2491.location.x);
                case 3:
                    return (_SafeStr_2491.location.y);
                case 4:
                    return (_currentDirection.intValue());
                case 5:
                    return (_maxSnowballs);
                case 6:
                    return (_SafeStr_2510);
                case 7:
                    return (_SafeStr_2509);
                default:
                    throw (new Exception(("No such variable:" + _arg_1)));
            };
        }

        override public function get boundingData():Array
        {
            return (BOUNDING_DATA);
        }

        public function createSnowball():void
        {
            if (_SafeStr_2510 < _maxSnowballs)
            {
                _SafeStr_2510++;
            };
        }


    }
}


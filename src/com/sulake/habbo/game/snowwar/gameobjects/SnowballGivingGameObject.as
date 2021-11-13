package com.sulake.habbo.game.snowwar.gameobjects
{
    import com.sulake.habbo.game.snowwar.Tile;
    import com.sulake.habbo.game.snowwar.utils.Direction360;
    import com.sulake.habbo.game.snowwar.utils.Location3D;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;

    public class SnowballGivingGameObject extends SnowWarGameObject 
    {

        protected var _SafeStr_2509:int;
        protected var _SafeStr_2510:int;
        protected var _SafeStr_2491:Tile;

        public function SnowballGivingGameObject(_arg_1:int, _arg_2:int, _arg_3:Tile, _arg_4:int)
        {
            super(_arg_1, false);
            _active = true;
            _SafeStr_2510 = _arg_2;
            _SafeStr_2491 = _arg_3;
            _SafeStr_2509 = _arg_4;
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_2491 = null;
        }

        override public function get direction360():Direction360
        {
            return (null);
        }

        override public function get boundingType():int
        {
            return (2);
        }

        override public function get location3D():Location3D
        {
            return (_SafeStr_2491.location);
        }

        public function get fuseObjectId():int
        {
            return (_SafeStr_2509);
        }

        public function get snowballCount():int
        {
            return (_SafeStr_2510);
        }

        override public function subturn(_arg_1:SynchronizedGameStage):void
        {
        }

        public function pickupSnowballs(_arg_1:int):int
        {
            if (_SafeStr_2510 < _arg_1)
            {
                _arg_1 = _SafeStr_2510;
            };
            _SafeStr_2510 = (_SafeStr_2510 - _arg_1);
            onSnowballPickup();
            return (_arg_1);
        }

        override public function onSnowBallHit(_arg_1:SnowWarGameStage, _arg_2:SnowBallGameObject):void
        {
        }

        protected function onSnowballPickup():void
        {
        }


    }
}


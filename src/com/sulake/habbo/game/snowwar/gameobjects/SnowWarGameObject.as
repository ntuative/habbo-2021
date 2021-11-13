package com.sulake.habbo.game.snowwar.gameobjects
{
    import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
    import com.sulake.habbo.game.snowwar.utils.ICollidable;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.game.snowwar.utils.Location3D;
    import com.sulake.habbo.game.snowwar.utils.Direction360;
    import com.sulake.habbo.game.snowwar.utils.CollisionDetection;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;

    public class SnowWarGameObject implements ISynchronizedGameObject, ICollidable 
    {

        protected var _active:Boolean = false;
        protected var _SafeStr_2501:int = -1;
        protected var _SafeStr_2502:Boolean = false;
        private var _disposed:Boolean = false;

        public function SnowWarGameObject(_arg_1:int, _arg_2:Boolean)
        {
            _SafeStr_2501 = ((_arg_2) ? -(_arg_1) : _arg_1);
            _SafeStr_2502 = _arg_2;
        }

        public function dispose():void
        {
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get isActive():Boolean
        {
            return (_active);
        }

        public function set isActive(_arg_1:Boolean):void
        {
            this._active = _arg_1;
        }

        public function get numberOfVariables():int
        {
            return (-1);
        }

        public function getVariable(_arg_1:int):int
        {
            return (-1);
        }

        public function get gameObjectId():int
        {
            return (_SafeStr_2501);
        }

        public function set gameObjectId(_arg_1:int):void
        {
            _SafeStr_2501 = _arg_1;
        }

        public function subturn(_arg_1:SynchronizedGameStage):void
        {
        }

        public function get boundingType():int
        {
            return (0);
        }

        public function get boundingData():Array
        {
            return (null);
        }

        public function get location3D():Location3D
        {
            return (null);
        }

        public function get direction360():Direction360
        {
            return (null);
        }

        public function get isGhost():Boolean
        {
            return (_SafeStr_2502);
        }

        public function get ghostObjectId():int
        {
            return (-(_SafeStr_2501 + 1));
        }

        public function onRemove():void
        {
        }

        public function get collisionHeight():int
        {
            return (boundingData[0]);
        }

        public function testSnowBallCollision(_arg_1:SnowBallGameObject):Boolean
        {
            return ((_arg_1.location3D.z < collisionHeight) && (CollisionDetection.testForObjectToObjectCollision(this, _arg_1)));
        }

        public function onSnowBallHit(_arg_1:SnowWarGameStage, _arg_2:SnowBallGameObject):void
        {
        }


    }
}


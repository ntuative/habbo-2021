package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class NewMoveTargetEvent extends SnowWarGameEvent 
    {

        private var _humanGameObject:HumanGameObject;
        private var _x:int;
        private var _y:int;

        public function NewMoveTargetEvent(_arg_1:HumanGameObject, _arg_2:int, _arg_3:int)
        {
            this._humanGameObject = _arg_1;
            this._x = _arg_2;
            this._y = _arg_3;
        }

        override public function dispose():void
        {
            super.dispose();
            _humanGameObject = null;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            _humanGameObject.changeMoveTarget(_x, _y);
        }

        public function get humanGameObject():HumanGameObject
        {
            return (_humanGameObject);
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }


    }
}
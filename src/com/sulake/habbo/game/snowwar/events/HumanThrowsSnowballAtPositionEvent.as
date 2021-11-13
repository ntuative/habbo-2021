package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class HumanThrowsSnowballAtPositionEvent extends SnowWarGameEvent 
    {

        private var _human:HumanGameObject;
        private var _targetX:int;
        private var _targetY:int;
        private var _trajectory:int;

        public function HumanThrowsSnowballAtPositionEvent(_arg_1:HumanGameObject, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            this._human = _arg_1;
            this._targetX = _arg_2;
            this._targetY = _arg_3;
            this._trajectory = _arg_4;
        }

        override public function dispose():void
        {
            super.dispose();
            _human = null;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            human.throwSnowball(targetX, targetY);
            human.startThrowTimer();
            SnowWarEngine.playSound("HBSTG_snowwar_throw");
        }

        public function get human():HumanGameObject
        {
            return (_human);
        }

        public function get targetX():int
        {
            return (_targetX);
        }

        public function get targetY():int
        {
            return (_targetY);
        }

        public function get trajectory():int
        {
            return (_trajectory);
        }


    }
}
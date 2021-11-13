package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class HumanThrowsSnowballAtHumanEvent extends SnowWarGameEvent 
    {

        private var _human:HumanGameObject;
        private var _targetHuman:HumanGameObject;
        private var _trajectory:int;

        public function HumanThrowsSnowballAtHumanEvent(_arg_1:HumanGameObject, _arg_2:HumanGameObject, _arg_3:int)
        {
            _human = _arg_1;
            _targetHuman = _arg_2;
            _trajectory = _arg_3;
        }

        override public function dispose():void
        {
            super.dispose();
            _human = null;
            _targetHuman = null;
            _trajectory = 0;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            human.throwSnowball(_targetHuman.currentLocation.x, _targetHuman.currentLocation.y);
            human.startThrowTimer();
            SnowWarEngine.playSound("HBSTG_snowwar_throw");
        }

        public function get human():HumanGameObject
        {
            return (_human);
        }

        public function get targetHuman():HumanGameObject
        {
            return (_targetHuman);
        }

        public function get trajectory():int
        {
            return (_trajectory);
        }


    }
}
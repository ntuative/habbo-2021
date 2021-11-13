package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class HumanStartsToMakeASnowballEvent extends SnowWarGameEvent 
    {

        private var _human:HumanGameObject;

        public function HumanStartsToMakeASnowballEvent(_arg_1:HumanGameObject)
        {
            _human = _arg_1;
        }

        override public function dispose():void
        {
            super.dispose();
            _human = null;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            _human.startMakingSnowball();
        }

        public function get human():HumanGameObject
        {
            return (_human);
        }


    }
}
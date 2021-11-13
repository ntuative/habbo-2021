package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class HumanLeftGameEvent extends SnowWarGameEvent 
    {

        private var _SafeStr_2485:HumanGameObject;

        public function HumanLeftGameEvent(_arg_1:HumanGameObject)
        {
            _SafeStr_2485 = _arg_1;
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_2485 = null;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            _arg_1.putGameObjectOnDeleteList(_SafeStr_2485);
            _SafeStr_2485.onRemove();
        }


    }
}


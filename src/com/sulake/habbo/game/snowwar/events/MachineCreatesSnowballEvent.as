package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class MachineCreatesSnowballEvent extends SnowWarGameEvent 
    {

        private var _SafeStr_2489:SnowballMachineGameObject;

        public function MachineCreatesSnowballEvent(_arg_1:SnowballMachineGameObject)
        {
            _SafeStr_2489 = _arg_1;
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_2489 = null;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            if (_SafeStr_2489)
            {
                _SafeStr_2489.createSnowball();
            }
            else
            {
                HabboGamesCom.log("Too early for this stuff..");
            };
        }


    }
}


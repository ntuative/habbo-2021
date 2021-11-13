package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.SnowballGivingGameObject;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class HumanGetsSnowballsFromMachineEvent extends SnowWarGameEvent 
    {

        private var _human:HumanGameObject;
        private var _SafeStr_2489:SnowballGivingGameObject;

        public function HumanGetsSnowballsFromMachineEvent(_arg_1:HumanGameObject, _arg_2:SnowballGivingGameObject)
        {
            _human = _arg_1;
            _SafeStr_2489 = _arg_2;
        }

        override public function dispose():void
        {
            super.dispose();
            _human = null;
            _SafeStr_2489 = null;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            var _local_3:int;
            var _local_2:HumanGameObject;
            var _local_4:int = _human.getRemainingSnowballCapacity();
            if (_local_4 > 0)
            {
                _local_3 = _SafeStr_2489.pickupSnowballs(1);
                if (_local_3 > 0)
                {
                    _human.addSnowballs(_local_3);
                    _local_2 = (_arg_1.getGameObject(_human.ghostObjectId) as HumanGameObject);
                    if (_local_2)
                    {
                        _local_2.addSnowballs(_local_3);
                    };
                    SnowWarEngine.playSound("HBSTG_snowwar_get_snowball");
                };
            };
        }

        public function get human():HumanGameObject
        {
            return (_human);
        }


    }
}


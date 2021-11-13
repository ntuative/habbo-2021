package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class SnowWarGameEvent implements ISynchronizedGameEvent 
    {

        private var _disposed:Boolean = false;


        public function apply(_arg_1:SynchronizedGameStage):void
        {
        }

        public function dispose():void
        {
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}
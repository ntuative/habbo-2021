package com.sulake.habbo.game.snowwar
{
    import com.sulake.habbo.game.snowwar.arena.IGameArenaExtension;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
    import com.sulake.habbo.game.snowwar.arena.IGameStage;

    public class SnowWarGameArena implements IGameArenaExtension 
    {

        private var _SafeStr_2474:SynchronizedGameArena;
        private var _disposed:Boolean = false;


        public function dispose():void
        {
            _disposed = true;
            _SafeStr_2474 = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set gameArena(_arg_1:SynchronizedGameArena):void
        {
            _SafeStr_2474 = _arg_1;
        }

        public function getPulseInterval():int
        {
            return (50);
        }

        public function getNumberOfSubTurns():int
        {
            return (3);
        }

        public function createGameStage():IGameStage
        {
            return (new SnowWarGameStage());
        }

        public function pulse():void
        {
        }

        public function isDeathMatch():Boolean
        {
            return (_SafeStr_2474.numberOfTeams == 1);
        }


    }
}


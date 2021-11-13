package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;

    public class DefaultGameStage implements IGameStage 
    {

        protected var _SafeStr_2474:SynchronizedGameArena;
        protected var _SafeStr_2475:GameLevelData;
        private var _disposed:Boolean = false;


        public function dispose():void
        {
            _disposed = true;
            _SafeStr_2474 = null;
            _SafeStr_2475 = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function initialize(_arg_1:SynchronizedGameArena, _arg_2:GameLevelData):void
        {
            _SafeStr_2474 = _arg_1;
            _SafeStr_2475 = _arg_2;
        }

        public function get gameArena():SynchronizedGameArena
        {
            return (_SafeStr_2474);
        }

        public function get gameLevelData():GameLevelData
        {
            return (_SafeStr_2475);
        }

        public function get roomType():String
        {
            return ("");
        }


    }
}


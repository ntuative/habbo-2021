package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;

    public class SynchronizedGameArena implements IDisposable 
    {

        private var _gameEngine:SnowWarEngine;
        private var _SafeStr_2476:Array;
        protected var _SafeStr_2477:int;
        private var _subturn:int;
        private var _SafeStr_2478:int = 1;
        private var _SafeStr_2479:SynchronizedGameStage;
        private var _extension:IGameArenaExtension;
        private var _checkSums:Map;
        private var _disposed:Boolean = false;
        private var _SafeStr_2480:Boolean = false;
        private var _numberOfTeams:int;
        private var _SafeStr_2481:Array;


        public function dispose():void
        {
            _disposed = true;
            _gameEngine = null;
            _SafeStr_2476 = null;
            _SafeStr_2479 = null;
            if (_extension != null)
            {
                _extension.dispose();
                _extension = null;
            };
            _checkSums = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function initialize(_arg_1:SnowWarEngine, _arg_2:int):void
        {
            _gameEngine = _arg_1;
            _SafeStr_2479 = new SnowWarGameStage();
            _checkSums = new Map();
            _SafeStr_2476 = [];
            _numberOfTeams = _arg_2;
            _SafeStr_2477 = 0;
            _subturn = 0;
            _SafeStr_2476[_SafeStr_2477] = initEmptyEventQueue();
            _checkSums = new Map();
            resetTeamScores();
        }

        public function get gameEngine():SnowWarEngine
        {
            return (_gameEngine);
        }

        public function pulse():void
        {
            gamePulse();
        }

        public function gamePulse():void
        {
            var _local_1:Array;
            var _local_4:ISynchronizedGameEvent;
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((("Turn " + _SafeStr_2477) + " subturn ") + (_subturn + 1)) + "/") + getNumberOfSubTurns()));
            };
            var _local_3:SynchronizedGameStage = SynchronizedGameStage(getCurrentStage());
            var _local_2:Array = _SafeStr_2476[_SafeStr_2477];
            if (_local_2)
            {
                _local_1 = _local_2[_subturn];
                while (_local_1.length > 0)
                {
                    _local_4 = (_local_1.shift() as ISynchronizedGameEvent);
                    if (HabboGamesCom.logEnabled)
                    {
                        HabboGamesCom.log(((((((("GameInstance::gameTurn: applying event " + _local_4) + " turn ") + _SafeStr_2477) + " subturn ") + (_subturn + 1)) + "/") + getNumberOfSubTurns()));
                    };
                    _local_4.apply(_local_3);
                };
            };
            if (!_SafeStr_2480)
            {
                _local_3.subturn();
            };
            if (_subturn >= (getNumberOfSubTurns() - 1))
            {
                if ((_SafeStr_2477 % _SafeStr_2478) == 0)
                {
                    _checkSums[_SafeStr_2477] = getCurrentStage().calculateChecksum(_SafeStr_2477);
                };
                _SafeStr_2477++;
                _SafeStr_2480 = false;
                if (HabboGamesCom.logEnabled)
                {
                    HabboGamesCom.log(("Turn:" + _SafeStr_2477));
                };
            };
            _subturn++;
            if (_subturn >= getNumberOfSubTurns())
            {
                _subturn = 0;
            };
        }

        public function addGameEvent(_arg_1:int, _arg_2:int, _arg_3:ISynchronizedGameEvent):void
        {
            var _local_4:Array = _SafeStr_2476[_arg_1];
            if (_local_4 == null)
            {
                _local_4 = initEmptyEventQueue();
                _SafeStr_2476[_arg_1] = _local_4;
            };
            _local_4[_arg_2].push(_arg_3);
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((("Add game event: " + _arg_3) + " (subturn/turn): ") + _arg_2) + "/") + _arg_1));
            };
        }

        public function debugEventQueue():void
        {
            var _local_5:int;
            var _local_1:Array;
            var _local_6:int;
            var _local_4:Array;
            var _local_2:String = "";
            _local_5 = 0;
            while (_local_5 < _SafeStr_2476.length)
            {
                _local_1 = _SafeStr_2476[_local_5];
                if (_local_1 != null)
                {
                    _local_6 = 0;
                    while (_local_6 < getNumberOfSubTurns())
                    {
                        _local_4 = _local_1[_local_6];
                        if (_local_4.length != 0)
                        {
                            _local_2 = (_local_2 + (((_local_5 + " (") + _local_6) + ") : "));
                            for each (var _local_3:ISynchronizedGameEvent in _local_4)
                            {
                                _local_2 = (_local_2 + _local_3);
                            };
                            _local_2 = (_local_2 + "\n");
                        };
                        _local_6++;
                    };
                };
                _local_5++;
            };
            HabboGamesCom.log(_local_2);
        }

        public function getNumberOfSubTurns():int
        {
            return (this.getExtension().getNumberOfSubTurns());
        }

        public function getTurnNumber():int
        {
            return (_SafeStr_2477);
        }

        public function get subturn():int
        {
            return (_subturn);
        }

        public function getCurrentStage():SynchronizedGameStage
        {
            return (_SafeStr_2479);
        }

        public function getExtension():IGameArenaExtension
        {
            return (_extension);
        }

        public function setExtension(_arg_1:IGameArenaExtension):void
        {
            _extension = _arg_1;
            _arg_1.gameArena = this;
        }

        public function getCheckSum(_arg_1:int):int
        {
            return (_checkSums[_arg_1]);
        }

        public function seekToTurn(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_2477 = _arg_1;
            _subturn = 0;
            _checkSums[_arg_1] = _arg_2;
            _SafeStr_2476 = [];
            _SafeStr_2476[_SafeStr_2477] = initEmptyEventQueue();
            _SafeStr_2480 = true;
        }

        private function initEmptyEventQueue():Array
        {
            var _local_1:int;
            var _local_2:Array = [];
            _local_1 = 0;
            while (_local_1 < getNumberOfSubTurns())
            {
                _local_2[_local_1] = [];
                _local_1++;
            };
            return (_local_2);
        }

        public function get numberOfTeams():int
        {
            return (_numberOfTeams);
        }

        private function resetTeamScores():void
        {
            var _local_1:int;
            _SafeStr_2481 = [];
            _local_1 = 0;
            while (_local_1 < _numberOfTeams)
            {
                _SafeStr_2481[_local_1] = 0;
                _local_1++;
            };
        }

        public function addTeamScore(_arg_1:int, _arg_2:int):void
        {
            if (((_arg_1 > 0) && (_arg_1 <= _numberOfTeams)))
            {
                var _local_3:int = (_arg_1 - 1);
                var _local_4:int = (_SafeStr_2481[_local_3] + _arg_2);
                _SafeStr_2481[_local_3] = _local_4;
            };
        }

        public function getTeamScores():Array
        {
            return (_SafeStr_2481);
        }


    }
}


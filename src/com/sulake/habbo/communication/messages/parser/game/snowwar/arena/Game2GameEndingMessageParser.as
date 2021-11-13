package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamScoreData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2GameEndingMessageParser implements IMessageParser 
    {

        private var _timeToNextState:int;
        private var _teams:Array;
        private var _teamScores:Array;
        private var _generalStats:Game2SnowWarGameStats;
        private var _gameResult:Game2GameResult;


        public function flush():Boolean
        {
            _timeToNextState = -1;
            _teams = [];
            _teamScores = [];
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _timeToNextState = _arg_1.readInteger();
            _gameResult = new Game2GameResult(_arg_1);
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _teams.push(new Game2TeamScoreData(_arg_1));
                _local_3++;
            };
            _generalStats = new Game2SnowWarGameStats(_arg_1);
            return (true);
        }

        public function get timeToNextState():int
        {
            return (_timeToNextState);
        }

        public function get teams():Array
        {
            return (_teams);
        }

        public function get teamScores():Array
        {
            return (_teamScores);
        }

        public function get gameResult():Game2GameResult
        {
            return (_gameResult);
        }

        public function get generalStats():Game2SnowWarGameStats
        {
            return (_generalStats);
        }


    }
}
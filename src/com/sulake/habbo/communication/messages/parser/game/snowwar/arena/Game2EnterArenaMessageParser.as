package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2EnterArenaMessageParser implements IMessageParser 
    {

        private var _gameType:int;
        private var _fieldType:int;
        private var _numberOfTeams:int;
        private var _players:Array;
        private var _gameLevel:GameLevelData;

        public function Game2EnterArenaMessageParser()
        {
            _players = [];
        }

        public function flush():Boolean
        {
            _gameType = -1;
            _fieldType = -1;
            _numberOfTeams = -1;
            for each (var _local_1:Game2PlayerData in _players)
            {
                _local_1.dispose();
            };
            _players = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:Game2PlayerData;
            _gameType = _arg_1.readInteger();
            _fieldType = _arg_1.readInteger();
            _numberOfTeams = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = new Game2PlayerData();
                _local_4.parse(_arg_1);
                _players.push(_local_4);
                _local_3++;
            };
            _gameLevel = new GameLevelData(_arg_1);
            return (true);
        }

        public function get gameType():int
        {
            return (_gameType);
        }

        public function get fieldType():int
        {
            return (_fieldType);
        }

        public function get numberOfTeams():int
        {
            return (_numberOfTeams);
        }

        public function get players():Array
        {
            return (_players);
        }

        public function get gameLevel():GameLevelData
        {
            return (_gameLevel);
        }


    }
}
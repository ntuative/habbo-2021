package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GameLobbyData 
    {

        private var _gameId:int;
        private var _levelName:String;
        private var _gameType:int;
        private var _fieldType:int;
        private var _numberOfTeams:int;
        private var _maximumPlayers:int;
        private var _owningPlayerName:String;
        private var _levelEntryId:int;
        private var _players:Array = [];

        public function GameLobbyData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _gameId = _arg_1.readInteger();
            _levelName = _arg_1.readString();
            _gameType = _arg_1.readInteger();
            _fieldType = _arg_1.readInteger();
            _numberOfTeams = _arg_1.readInteger();
            _maximumPlayers = _arg_1.readInteger();
            _owningPlayerName = _arg_1.readString();
            _levelEntryId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _players.push(new GameLobbyPlayerData(_arg_1));
                _local_3++;
            };
        }

        public function get gameId():int
        {
            return (_gameId);
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

        public function get maximumPlayers():int
        {
            return (_maximumPlayers);
        }

        public function get owningPlayerName():String
        {
            return (_owningPlayerName);
        }

        public function get levelEntryId():int
        {
            return (_levelEntryId);
        }

        public function get players():Array
        {
            return (_players);
        }


    }
}
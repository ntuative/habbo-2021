package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2GroupLeaderboardParser implements IMessageParser 
    {

        private var _gameTypeId:int;
        private var _leaderboard:Array;
        private var _totalListSize:int;
        private var _favouriteGroupId:int;


        public function flush():Boolean
        {
            _gameTypeId = -1;
            _leaderboard = null;
            _totalListSize = -1;
            _favouriteGroupId = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _leaderboard = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _leaderboard.push(new LeaderboardEntry(_arg_1));
                _local_3++;
            };
            _totalListSize = _arg_1.readInteger();
            _gameTypeId = _arg_1.readInteger();
            _favouriteGroupId = _arg_1.readInteger();
            return (true);
        }

        public function get gameTypeId():int
        {
            return (_gameTypeId);
        }

        public function get leaderboard():Array
        {
            return (_leaderboard);
        }

        public function get totalListSize():int
        {
            return (_totalListSize);
        }

        public function get favouriteGroupId():int
        {
            return (_favouriteGroupId);
        }


    }
}
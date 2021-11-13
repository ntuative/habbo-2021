package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2TeamScoreData 
    {

        private var _score:int;
        private var _teamReference:int;
        private var _players:Array;

        public function Game2TeamScoreData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _teamReference = _arg_1.readInteger();
            _score = _arg_1.readInteger();
            _players = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _players.push(new Game2TeamPlayerData(_teamReference, _arg_1));
                _local_3++;
            };
        }

        public function get score():int
        {
            return (_score);
        }

        public function get teamReference():int
        {
            return (_teamReference);
        }

        public function get players():Array
        {
            return (_players);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WeeklyGameRewardWinnersParser implements IMessageParser 
    {

        private var _gameTypeId:int;
        private var _winners:Array = [];


        public function get gameTypeId():int
        {
            return (_gameTypeId);
        }

        public function get winners():Array
        {
            return (_winners);
        }

        public function flush():Boolean
        {
            _gameTypeId = -1;
            _winners = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _gameTypeId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _winners.push(new GameRewardWinnerEntry(_arg_1));
                _local_3++;
            };
            return (true);
        }


    }
}
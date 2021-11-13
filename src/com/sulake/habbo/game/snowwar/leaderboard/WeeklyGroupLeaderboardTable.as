package com.sulake.habbo.game.snowwar.leaderboard
{
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyGroupLeaderboardComposer;
    import com.sulake.core.communication.messages.IMessageComposer;

    public class WeeklyGroupLeaderboardTable extends TotalGroupLeaderboardTable 
    {

        private var _offset:int = 0;
        private var _maxOffset:int = 0;

        public function WeeklyGroupLeaderboardTable(_arg_1:SnowWarEngine)
        {
            super(_arg_1);
        }

        public function get offset():int
        {
            return (_offset);
        }

        public function set offset(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_arg_1 <= _maxOffset)))
            {
                _offset = _arg_1;
            };
        }

        public function get maxOffset():int
        {
            return (_maxOffset);
        }

        public function set maxOffset(_arg_1:int):void
        {
            _maxOffset = _arg_1;
        }

        override protected function getMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int):IMessageComposer
        {
            return (new Game2GetWeeklyGroupLeaderboardComposer(_arg_1, _offset, _arg_2, _arg_3, _SafeStr_2518, _SafeStr_2519));
        }


    }
}


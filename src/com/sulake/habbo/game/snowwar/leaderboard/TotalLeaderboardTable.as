package com.sulake.habbo.game.snowwar.leaderboard
{
    import com.sulake.habbo.communication.messages.parser.game.score.LeaderboardEntry;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalLeaderboardComposer;
    import com.sulake.core.communication.messages.IMessageComposer;

    public class TotalLeaderboardTable extends LeaderboardTable 
    {

        private var _ownEntry:LeaderboardEntry;

        public function TotalLeaderboardTable(_arg_1:SnowWarEngine)
        {
            super(_arg_1);
            _SafeStr_2518 = (_SafeStr_2518 - 1);
        }

        override public function dispose():void
        {
            super.dispose();
            _ownEntry = null;
        }

        override public function addEntries(_arg_1:Array, _arg_2:int):void
        {
            _ownEntry = _arg_1.pop();
            super.addEntries(_arg_1, _arg_2);
        }

        override protected function getMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int):IMessageComposer
        {
            return (new Game2GetTotalLeaderboardComposer(_arg_1, _arg_2, _arg_3, _SafeStr_2518, _SafeStr_2519));
        }

        override public function getVisibleEntries():Array
        {
            var _local_1:Array = super.getVisibleEntries();
            if (_ownEntry)
            {
                _local_1.push(_ownEntry);
            };
            return (_local_1);
        }

        override protected function initializeList():void
        {
            _SafeStr_2516 = 0;
        }


    }
}


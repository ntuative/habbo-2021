package com.sulake.habbo.game.snowwar.leaderboard
{
    import com.sulake.habbo.communication.messages.parser.game.score.LeaderboardEntry;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalGroupLeaderboardComposer;
    import com.sulake.core.communication.messages.IMessageComposer;

    public class TotalGroupLeaderboardTable extends LeaderboardTable 
    {

        private var _ownEntry:LeaderboardEntry;

        public function TotalGroupLeaderboardTable(_arg_1:SnowWarEngine)
        {
            super(_arg_1);
            _SafeStr_2518 = (_SafeStr_2518 - 1);
        }

        override public function dispose():void
        {
            super.dispose();
            _ownEntry = null;
        }

        override public function addGroupEntries(_arg_1:Array, _arg_2:int, _arg_3:int):void
        {
            if (_arg_3 > 0)
            {
                _ownEntry = _arg_1.pop();
            };
            super.addGroupEntries(_arg_1, _arg_2, _arg_3);
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

        override protected function getMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int):IMessageComposer
        {
            return (new Game2GetTotalGroupLeaderboardComposer(_arg_1, _arg_2, _arg_3, _SafeStr_2518, _SafeStr_2519));
        }


    }
}


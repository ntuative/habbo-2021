package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2WeeklyGroupLeaderboardParser extends Game2LeaderboardParser 
    {

        private var _year:int;
        private var _week:int;
        private var _maxOffset:int;
        private var _currentOffset:int;
        private var _minutesUntilReset:int;
        private var _favouriteGroupId:int;


        public function get year():int
        {
            return (_year);
        }

        public function get week():int
        {
            return (_week);
        }

        public function get maxOffset():int
        {
            return (_maxOffset);
        }

        public function get currentOffset():int
        {
            return (_currentOffset);
        }

        public function get minutesUntilReset():int
        {
            return (_minutesUntilReset);
        }

        public function get favouriteGroupId():int
        {
            return (_favouriteGroupId);
        }

        override public function flush():Boolean
        {
            _year = -1;
            _week = -1;
            _maxOffset = -1;
            _currentOffset = -1;
            _minutesUntilReset = -1;
            _favouriteGroupId = -1;
            return (super.flush());
        }

        override public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _year = _arg_1.readInteger();
            _week = _arg_1.readInteger();
            _maxOffset = _arg_1.readInteger();
            _currentOffset = _arg_1.readInteger();
            _minutesUntilReset = _arg_1.readInteger();
            super.parse(_arg_1);
            _favouriteGroupId = _arg_1.readInteger();
            return (true);
        }


    }
}
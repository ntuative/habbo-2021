package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2PlayerStatsData 
    {

        private var _score:int;
        private var _kills:int;
        private var _deaths:int;
        private var _snowballHits:int;
        private var _snowballHitsTaken:int;
        private var _snowballsThrown:int;
        private var _snowballsCreated:int;
        private var _snowballsFromMachine:int;
        private var _friendlyHits:int;
        private var _friendlyKills:int;

        public function Game2PlayerStatsData(_arg_1:IMessageDataWrapper)
        {
            _score = _arg_1.readInteger();
            _kills = _arg_1.readInteger();
            _deaths = _arg_1.readInteger();
            _snowballHits = _arg_1.readInteger();
            _snowballHitsTaken = _arg_1.readInteger();
            _snowballsThrown = _arg_1.readInteger();
            _snowballsCreated = _arg_1.readInteger();
            _snowballsFromMachine = _arg_1.readInteger();
            _friendlyHits = _arg_1.readInteger();
            _friendlyKills = _arg_1.readInteger();
        }

        public function get score():int
        {
            return (_score);
        }

        public function get kills():int
        {
            return (_kills);
        }

        public function get deaths():int
        {
            return (_deaths);
        }

        public function get snowballHits():int
        {
            return (_snowballHits);
        }

        public function get snowballHitsTaken():int
        {
            return (_snowballHitsTaken);
        }

        public function get snowballsThrown():int
        {
            return (_snowballsThrown);
        }

        public function get snowballsCreated():int
        {
            return (_snowballsCreated);
        }

        public function get snowballsFromMachine():int
        {
            return (_snowballsFromMachine);
        }

        public function get friendlyHits():int
        {
            return (_friendlyHits);
        }

        public function get friendlyKills():int
        {
            return (_friendlyKills);
        }


    }
}
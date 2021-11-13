package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2AccountGameStatusMessageParser implements IMessageParser 
    {

        private var _gameTypeId:int;
        private var _freeGamesLeft:int;
        private var _gamesPlayedTotal:int;


        public function get gameTypeId():int
        {
            return (_gameTypeId);
        }

        public function get freeGamesLeft():int
        {
            return (_freeGamesLeft);
        }

        public function get gamesPlayedTotal():int
        {
            return (_gamesPlayedTotal);
        }

        public function get hasUnlimitedGames():Boolean
        {
            return (_freeGamesLeft == -1);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _gameTypeId = _arg_1.readInteger();
            _freeGamesLeft = _arg_1.readInteger();
            _gamesPlayedTotal = _arg_1.readInteger();
            return (true);
        }


    }
}
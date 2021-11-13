package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2GameDirectoryStatusMessageParser implements IMessageParser 
    {

        public static const _SafeStr_1985:int = 0;
        public static const _SafeStr_1986:int = 1;
        public static const _SafeStr_1987:int = 2;
        public static const _SafeStr_1988:int = 3;

        private var _status:int;
        private var _blockLength:int;
        private var _gamesPlayed:int;
        private var _freeGamesLeft:int;


        public function get status():int
        {
            return (_status);
        }

        public function get blockLength():int
        {
            return (_blockLength);
        }

        public function get gamesPlayed():int
        {
            return (_gamesPlayed);
        }

        public function get freeGamesLeft():int
        {
            return (_freeGamesLeft);
        }

        public function get hasUnlimitedGames():Boolean
        {
            return (_freeGamesLeft == -1);
        }

        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _status = _arg_1.readInteger();
            _blockLength = _arg_1.readInteger();
            _gamesPlayed = _arg_1.readInteger();
            _freeGamesLeft = _arg_1.readInteger();
            return (true);
        }


    }
}


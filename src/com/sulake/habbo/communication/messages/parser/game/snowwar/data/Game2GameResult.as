package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2GameResult 
    {

        public static const _SafeStr_2019:int = 0;
        public static const _SafeStr_2020:int = 1;
        public static const _SafeStr_2021:int = 2;

        private var _isDeathMatch:Boolean;
        private var _resultType:int;
        private var _winnerId:int;

        public function Game2GameResult(_arg_1:IMessageDataWrapper)
        {
            _isDeathMatch = _arg_1.readBoolean();
            _resultType = _arg_1.readInteger();
            _winnerId = _arg_1.readInteger();
        }

        public function get isDeathMatch():Boolean
        {
            return (_isDeathMatch);
        }

        public function get resultType():int
        {
            return (_resultType);
        }

        public function get winnerId():int
        {
            return (_winnerId);
        }


    }
}


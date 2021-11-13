package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2PlayerExitedGameArenaMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _playerGameObjectId:int;


        public function flush():Boolean
        {
            _userId = NaN;
            _playerGameObjectId = NaN;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userId = _arg_1.readInteger();
            _playerGameObjectId = _arg_1.readInteger();
            return (true);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get playerGameObjectId():int
        {
            return (_playerGameObjectId);
        }


    }
}
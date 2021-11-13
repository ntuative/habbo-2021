package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2StageLoadMessageParser implements IMessageParser 
    {

        private var _gameType:int;


        public function flush():Boolean
        {
            _gameType = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _gameType = _arg_1.readInteger();
            return (true);
        }

        public function get gameType():int
        {
            return (_gameType);
        }


    }
}
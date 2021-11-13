package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2GameRejoinMessageParser implements IMessageParser 
    {

        private var _roomBeforeGame:int;


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomBeforeGame = _arg_1.readInteger();
            return (true);
        }

        public function get roomBeforeGame():int
        {
            return (_roomBeforeGame);
        }


    }
}
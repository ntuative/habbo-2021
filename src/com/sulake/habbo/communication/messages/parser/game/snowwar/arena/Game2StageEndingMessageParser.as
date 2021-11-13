package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2StageEndingMessageParser implements IMessageParser 
    {

        private var _timeToNextState:int;


        public function flush():Boolean
        {
            _timeToNextState = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _timeToNextState = _arg_1.readInteger();
            return (true);
        }

        public function get timeToNextState():int
        {
            return (_timeToNextState);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2StageRunningMessageParser implements IMessageParser 
    {

        private var _timeToStageEnd:int;


        public function flush():Boolean
        {
            _timeToStageEnd = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _timeToStageEnd = _arg_1.readInteger();
            return (true);
        }

        public function get timeToStageEnd():int
        {
            return (_timeToStageEnd);
        }


    }
}
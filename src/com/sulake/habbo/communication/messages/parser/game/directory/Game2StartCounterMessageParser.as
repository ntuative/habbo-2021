package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2StartCounterMessageParser implements IMessageParser 
    {

        private var _countDownLength:int;


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _countDownLength = _arg_1.readInteger();
            return (true);
        }

        public function get countDownLength():int
        {
            return (_countDownLength);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2InArenaQueueMessageParser implements IMessageParser 
    {

        private var _position:int;


        public function get position():int
        {
            return (_position);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _position = _arg_1.readInteger();
            return (true);
        }


    }
}
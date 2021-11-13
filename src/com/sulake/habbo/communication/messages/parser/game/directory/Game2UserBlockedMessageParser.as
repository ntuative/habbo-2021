package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2UserBlockedMessageParser implements IMessageParser 
    {

        private var _playerBlockLength:int;


        public function flush():Boolean
        {
            _playerBlockLength = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _playerBlockLength = _arg_1.readInteger();
            return (true);
        }

        public function get playerBlockLength():int
        {
            return (_playerBlockLength);
        }


    }
}
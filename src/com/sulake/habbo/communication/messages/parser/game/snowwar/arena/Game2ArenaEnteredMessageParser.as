package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2ArenaEnteredMessageParser implements IMessageParser 
    {

        private var _player:Game2PlayerData;


        public function flush():Boolean
        {
            if (_player)
            {
                _player.dispose();
                _player = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _player = new Game2PlayerData();
            _player.parse(_arg_1);
            return (true);
        }

        public function get player():Game2PlayerData
        {
            return (_player);
        }


    }
}
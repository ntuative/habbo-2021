package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2GameLongDataMessageParser implements IMessageParser 
    {

        private var _gameLobbyData:GameLobbyData;


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _gameLobbyData = new GameLobbyData(_arg_1);
            return (true);
        }

        public function get gameLobbyData():GameLobbyData
        {
            return (_gameLobbyData);
        }


    }
}
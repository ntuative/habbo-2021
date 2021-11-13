package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2GameStartedMessageParser implements IMessageParser 
    {

        private var _lobbyData:GameLobbyData;


        public function get lobbyData():GameLobbyData
        {
            return (_lobbyData);
        }

        public function flush():Boolean
        {
            _lobbyData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _lobbyData = new GameLobbyData(_arg_1);
            return (true);
        }


    }
}
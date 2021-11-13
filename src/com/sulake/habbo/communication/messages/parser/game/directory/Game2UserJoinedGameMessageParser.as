package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2UserJoinedGameMessageParser implements IMessageParser 
    {

        private var _user:GameLobbyPlayerData;
        private var _wasTeamSwitched:Boolean;


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _user = new GameLobbyPlayerData(_arg_1);
            _wasTeamSwitched = _arg_1.readBoolean();
            return (true);
        }

        public function get user():GameLobbyPlayerData
        {
            return (_user);
        }

        public function get wasTeamSwitched():Boolean
        {
            return (_wasTeamSwitched);
        }


    }
}
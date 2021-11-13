package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.MessageEvent;

    public class Game2FriendsLeaderboardEvent extends MessageEvent 
    {

        public function Game2FriendsLeaderboardEvent(_arg_1:Function)
        {
            super(_arg_1, Game2LeaderboardParser);
        }

        public function getParser():Game2LeaderboardParser
        {
            return (this._SafeStr_816 as Game2LeaderboardParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.MessageEvent;

    public class Game2WeeklyFriendsLeaderboardEvent extends MessageEvent 
    {

        public function Game2WeeklyFriendsLeaderboardEvent(_arg_1:Function)
        {
            super(_arg_1, Game2WeeklyLeaderboardParser);
        }

        public function getParser():Game2WeeklyLeaderboardParser
        {
            return (this._SafeStr_816 as Game2WeeklyLeaderboardParser);
        }


    }
}


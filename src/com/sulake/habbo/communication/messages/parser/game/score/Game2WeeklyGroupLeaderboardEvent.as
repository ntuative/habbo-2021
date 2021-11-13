package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.MessageEvent;

    public class Game2WeeklyGroupLeaderboardEvent extends MessageEvent 
    {

        public function Game2WeeklyGroupLeaderboardEvent(_arg_1:Function)
        {
            super(_arg_1, Game2WeeklyGroupLeaderboardParser);
        }

        public function getParser():Game2WeeklyGroupLeaderboardParser
        {
            return (this._SafeStr_816 as Game2WeeklyGroupLeaderboardParser);
        }


    }
}


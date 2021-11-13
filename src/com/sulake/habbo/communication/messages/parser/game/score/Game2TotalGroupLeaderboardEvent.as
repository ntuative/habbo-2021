package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.MessageEvent;

    public class Game2TotalGroupLeaderboardEvent extends MessageEvent 
    {

        public function Game2TotalGroupLeaderboardEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GroupLeaderboardParser);
        }

        public function getParser():Game2GroupLeaderboardParser
        {
            return (this._SafeStr_816 as Game2GroupLeaderboardParser);
        }


    }
}


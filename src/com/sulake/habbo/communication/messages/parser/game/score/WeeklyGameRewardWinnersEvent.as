package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.MessageEvent;

    public class WeeklyGameRewardWinnersEvent extends MessageEvent 
    {

        public function WeeklyGameRewardWinnersEvent(_arg_1:Function)
        {
            super(_arg_1, WeeklyGameRewardWinnersParser);
        }

        public function getParser():WeeklyGameRewardWinnersParser
        {
            return (this._SafeStr_816 as WeeklyGameRewardWinnersParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.MessageEvent;

    public class WeeklyGameRewardEvent extends MessageEvent 
    {

        public function WeeklyGameRewardEvent(_arg_1:Function)
        {
            super(_arg_1, WeeklyGameRewardParser);
        }

        public function getParser():WeeklyGameRewardParser
        {
            return (this._SafeStr_816 as WeeklyGameRewardParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class UserGameAchievementsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserGameAchievementsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserGameAchievementsMessageParser);
        }

        public function getParser():UserGameAchievementsMessageParser
        {
            return (this._SafeStr_816 as UserGameAchievementsMessageParser);
        }


    }
}


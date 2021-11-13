package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class AchievementResolutionProgressMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementResolutionProgressMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementResolutionProgressMessageParser);
        }

        public function getParser():AchievementResolutionProgressMessageParser
        {
            return (this._SafeStr_816 as AchievementResolutionProgressMessageParser);
        }


    }
}


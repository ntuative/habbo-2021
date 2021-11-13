package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class AchievementResolutionCompletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementResolutionCompletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementResolutionCompletedMessageParser);
        }

        public function getParser():AchievementResolutionCompletedMessageParser
        {
            return (this._SafeStr_816 as AchievementResolutionCompletedMessageParser);
        }


    }
}


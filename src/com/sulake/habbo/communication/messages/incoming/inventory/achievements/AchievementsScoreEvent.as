package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;

        public class AchievementsScoreEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementsScoreEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementsScoreMessageParser);
        }

        public function getParser():AchievementsScoreMessageParser
        {
            return (_SafeStr_816 as AchievementsScoreMessageParser);
        }


    }
}


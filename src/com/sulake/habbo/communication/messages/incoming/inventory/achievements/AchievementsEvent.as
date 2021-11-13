package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;

        public class AchievementsEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementsEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementsMessageParser);
        }

        public function getParser():AchievementsMessageParser
        {
            return (_SafeStr_816 as AchievementsMessageParser);
        }


    }
}


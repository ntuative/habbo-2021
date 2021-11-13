package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;

        public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboAchievementNotificationMessageParser);
        }

        public function getParser():HabboAchievementNotificationMessageParser
        {
            return (_SafeStr_816 as HabboAchievementNotificationMessageParser);
        }


    }
}


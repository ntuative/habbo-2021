package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.notifications.AchievementLevelUpData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboAchievementNotificationMessageParser implements IMessageParser 
    {

        private var _data:AchievementLevelUpData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new AchievementLevelUpData(_arg_1);
            return (true);
        }

        public function get data():AchievementLevelUpData
        {
            return (_data);
        }


    }
}
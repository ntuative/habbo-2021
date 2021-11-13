package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementMessageParser implements IMessageParser 
    {

        private var _achievement:AchievementData;


        public function flush():Boolean
        {
            _achievement = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _achievement = new AchievementData(_arg_1);
            return (true);
        }

        public function get achievement():AchievementData
        {
            return (_achievement);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementsMessageParser implements IMessageParser 
    {

        private var _achievements:Array;
        private var _defaultCategory:String;


        public function flush():Boolean
        {
            _achievements = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _achievements = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _achievements.push(new AchievementData(_arg_1));
                _local_3++;
            };
            _defaultCategory = _arg_1.readString();
            return (true);
        }

        public function get achievements():Array
        {
            return (_achievements);
        }

        public function get defaultCategory():String
        {
            return (_defaultCategory);
        }


    }
}
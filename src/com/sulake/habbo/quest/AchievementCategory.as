package com.sulake.habbo.quest
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;

    public class AchievementCategory 
    {

        private var _code:String;
        private var _achievements:Vector.<AchievementData> = new Vector.<AchievementData>(0);

        public function AchievementCategory(_arg_1:String)
        {
            _code = _arg_1;
        }

        public function add(_arg_1:AchievementData):void
        {
            _achievements.push(_arg_1);
        }

        public function update(_arg_1:AchievementData):void
        {
            var _local_3:int;
            var _local_2:AchievementData;
            _local_3 = 0;
            while (_local_3 < _achievements.length)
            {
                _local_2 = _achievements[_local_3];
                if (_local_2.achievementId == _arg_1.achievementId)
                {
                    _achievements[_local_3] = _arg_1;
                };
                _local_3++;
            };
        }

        public function getProgress():int
        {
            var _local_1:int;
            for each (var _local_2:AchievementData in _achievements)
            {
                _local_1 = (_local_1 + ((_local_2.finalLevel) ? _local_2.level : (_local_2.level - 1)));
            };
            return (_local_1);
        }

        public function getMaxProgress():int
        {
            var _local_1:int;
            for each (var _local_2:AchievementData in _achievements)
            {
                _local_1 = (_local_1 + _local_2.levelCount);
            };
            return (_local_1);
        }

        public function get code():String
        {
            return (_code);
        }

        public function get achievements():Vector.<AchievementData>
        {
            return (_achievements);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.talent
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.utils._SafeStr_25;

        public class TalentTrackLevel 
    {

        private var _level:int;
        private var _state:int;
        private var _tasks:Vector.<TalentTrackTask> = new Vector.<TalentTrackTask>();
        private var _rewardPerks:Vector.<TalentTrackRewardPerk> = new Vector.<TalentTrackRewardPerk>();
        private var _rewardProducts:Vector.<TalentTrackRewardProduct> = new Vector.<TalentTrackRewardProduct>();


        public function parse(_arg_1:IMessageDataWrapper):void
        {
            var _local_2:int;
            var _local_3:int;
            _level = _arg_1.readInteger();
            _state = _arg_1.readInteger();
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _tasks.push(new TalentTrackTask(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _rewardPerks.push(new TalentTrackRewardPerk(_arg_1));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _rewardProducts.push(new TalentTrackRewardProduct(_arg_1));
                _local_3++;
            };
        }

        public function get level():int
        {
            return (_level);
        }

        public function set level(_arg_1:int):void
        {
            _level = _arg_1;
        }

        public function get state():int
        {
            return (_state);
        }

        public function set state(_arg_1:int):void
        {
            _state = _arg_1;
        }

        public function get tasks():Vector.<TalentTrackTask>
        {
            return (_tasks);
        }

        public function get rewardPerks():Vector.<TalentTrackRewardPerk>
        {
            return (_rewardPerks);
        }

        public function get rewardProducts():Vector.<TalentTrackRewardProduct>
        {
            return (_rewardProducts);
        }

        public function get rewardCount():int
        {
            return (_rewardPerks.length + _rewardProducts.length);
        }

        public function get levelProgress():Number
        {
            var _local_2:Number = (1 / _tasks.length);
            var _local_3:Number = 0;
            for each (var _local_1:TalentTrackTask in _tasks)
            {
                if (_local_1.state == 2)
                {
                    _local_3 = (_local_3 + _local_2);
                };
            };
            return (_SafeStr_25.clamp(_local_3));
        }

        public function findTaskByAchievementId(_arg_1:int):TalentTrackTask
        {
            for each (var _local_2:TalentTrackTask in _tasks)
            {
                if (_local_2.achievementId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }


    }
}


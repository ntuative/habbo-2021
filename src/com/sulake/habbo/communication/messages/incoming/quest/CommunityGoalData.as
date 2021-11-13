package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CommunityGoalData implements IDisposable 
    {

        private var _hasGoalExpired:Boolean;
        private var _personalContributionScore:int;
        private var _personalContributionRank:int;
        private var _communityTotalScore:int;
        private var _communityHighestAchievedLevel:int;
        private var _scoreRemainingUntilNextLevel:int;
        private var _percentCompletionTowardsNextLevel:int;
        private var _goalCode:String;
        private var _timeRemainingInSeconds:int;
        private var _rewardUserLimits:Array = [];

        public function CommunityGoalData(_arg_1:IMessageDataWrapper):void
        {
            var _local_3:int;
            super();
            _hasGoalExpired = _arg_1.readBoolean();
            _personalContributionScore = _arg_1.readInteger();
            _personalContributionRank = _arg_1.readInteger();
            _communityTotalScore = _arg_1.readInteger();
            _communityHighestAchievedLevel = _arg_1.readInteger();
            _scoreRemainingUntilNextLevel = _arg_1.readInteger();
            _percentCompletionTowardsNextLevel = _arg_1.readInteger();
            _goalCode = _arg_1.readString();
            _timeRemainingInSeconds = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _rewardUserLimits.push(_arg_1.readInteger());
                _local_3++;
            };
        }

        public function dispose():void
        {
            _rewardUserLimits = null;
        }

        public function get disposed():Boolean
        {
            return (_rewardUserLimits == null);
        }

        public function get hasGoalExpired():Boolean
        {
            return (_hasGoalExpired);
        }

        public function get personalContributionScore():int
        {
            return (_personalContributionScore);
        }

        public function get personalContributionRank():int
        {
            return (_personalContributionRank);
        }

        public function get communityTotalScore():int
        {
            return (_communityTotalScore);
        }

        public function get communityHighestAchievedLevel():int
        {
            return (_communityHighestAchievedLevel);
        }

        public function get scoreRemainingUntilNextLevel():int
        {
            return (_scoreRemainingUntilNextLevel);
        }

        public function get percentCompletionTowardsNextLevel():int
        {
            return (_percentCompletionTowardsNextLevel);
        }

        public function get timeRemainingInSeconds():int
        {
            return (_timeRemainingInSeconds);
        }

        public function get rewardUserLimits():Array
        {
            return (_rewardUserLimits);
        }

        public function get goalCode():String
        {
            return (_goalCode);
        }


    }
}
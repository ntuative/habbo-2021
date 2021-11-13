package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ScrKickbackData 
    {

        private var _currentHcStreak:int;
        private var _firstSubscriptionDate:String;
        private var _kickbackPercentage:Number;
        private var _totalCreditsMissed:int;
        private var _totalCreditsRewarded:int;
        private var _totalCreditsSpent:int;
        private var _creditRewardForStreakBonus:int;
        private var _creditRewardForMonthlySpent:int;
        private var _timeUntilPayday:int;

        public function ScrKickbackData(_arg_1:IMessageDataWrapper=null)
        {
            _currentHcStreak = _arg_1.readInteger();
            _firstSubscriptionDate = _arg_1.readString();
            _kickbackPercentage = _arg_1.readDouble();
            _totalCreditsMissed = _arg_1.readInteger();
            _totalCreditsRewarded = _arg_1.readInteger();
            _totalCreditsSpent = _arg_1.readInteger();
            _creditRewardForStreakBonus = _arg_1.readInteger();
            _creditRewardForMonthlySpent = _arg_1.readInteger();
            _timeUntilPayday = _arg_1.readInteger();
        }

        public function get currentHcStreak():int
        {
            return (_currentHcStreak);
        }

        public function get firstSubscriptionDate():String
        {
            return (_firstSubscriptionDate);
        }

        public function get kickbackPercentage():Number
        {
            return (_kickbackPercentage);
        }

        public function get totalCreditsMissed():int
        {
            return (_totalCreditsMissed);
        }

        public function get totalCreditsRewarded():int
        {
            return (_totalCreditsRewarded);
        }

        public function get totalCreditsSpent():int
        {
            return (_totalCreditsSpent);
        }

        public function get creditRewardForStreakBonus():int
        {
            return (_creditRewardForStreakBonus);
        }

        public function get creditRewardForMonthlySpent():int
        {
            return (_creditRewardForMonthlySpent);
        }

        public function get timeUntilPayday():int
        {
            return (_timeUntilPayday);
        }


    }
}
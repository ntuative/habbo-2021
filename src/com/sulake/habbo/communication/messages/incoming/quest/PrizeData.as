package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PrizeData 
    {

        private var _communityGoalId:int;
        private var _communityGoalCode:String;
        private var _userRank:int;
        private var _rewardCode:String;
        private var _badge:Boolean;
        private var _localizedName:String;

        public function PrizeData(_arg_1:IMessageDataWrapper)
        {
            _communityGoalId = _arg_1.readInteger();
            _communityGoalCode = _arg_1.readString();
            _userRank = _arg_1.readInteger();
            _rewardCode = _arg_1.readString();
            _badge = _arg_1.readBoolean();
            _localizedName = _arg_1.readString();
        }

        public function get communityGoalId():int
        {
            return (_communityGoalId);
        }

        public function get communityGoalCode():String
        {
            return (_communityGoalCode);
        }

        public function get userRank():int
        {
            return (_userRank);
        }

        public function get rewardCode():String
        {
            return (_rewardCode);
        }

        public function get badge():Boolean
        {
            return (_badge);
        }

        public function get localizedName():String
        {
            return (_localizedName);
        }


    }
}
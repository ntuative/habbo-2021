package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementLevelUpData 
    {

        private var _type:int;
        private var _level:int;
        private var _points:int;
        private var _levelRewardPoints:int;
        private var _levelRewardPointType:int;
        private var _bonusPoints:int;
        private var _badgeId:int;
        private var _badgeCode:String = "";
        private var _removedBadgeCode:String = "";
        private var _achievementID:int;
        private var _category:String;
        private var _showDialogToUser:Boolean;

        public function AchievementLevelUpData(_arg_1:IMessageDataWrapper)
        {
            _type = _arg_1.readInteger();
            _level = _arg_1.readInteger();
            _badgeId = _arg_1.readInteger();
            _badgeCode = _arg_1.readString();
            _points = _arg_1.readInteger();
            _levelRewardPoints = _arg_1.readInteger();
            _levelRewardPointType = _arg_1.readInteger();
            _bonusPoints = _arg_1.readInteger();
            _achievementID = _arg_1.readInteger();
            _removedBadgeCode = _arg_1.readString();
            _category = _arg_1.readString();
            _showDialogToUser = _arg_1.readBoolean();
        }

        public function get type():int
        {
            return (_type);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get points():int
        {
            return (_points);
        }

        public function get levelRewardPoints():int
        {
            return (_levelRewardPoints);
        }

        public function get levelRewardPointType():int
        {
            return (_levelRewardPointType);
        }

        public function get bonusPoints():int
        {
            return (_bonusPoints);
        }

        public function get badgeId():int
        {
            return (_badgeId);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get removedBadgeCode():String
        {
            return (_removedBadgeCode);
        }

        public function get achievementID():int
        {
            return (_achievementID);
        }

        public function get category():String
        {
            return (_category);
        }

        public function get showDialogToUser():Boolean
        {
            return (_showDialogToUser);
        }


    }
}
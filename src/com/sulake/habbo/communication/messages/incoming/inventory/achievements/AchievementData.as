package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementData 
    {

        public static const _SafeStr_1780:int = -1;
        public static const _SafeStr_1781:int = 0;
        public static const _SafeStr_1782:int = 1;
        public static const _SafeStr_1783:int = 2;

        private var _achievementId:int;
        private var _level:int;
        private var _badgeId:String;
        private var _scoreAtStartOfLevel:int;
        private var _SafeStr_1784:int;
        private var _levelRewardPoints:int;
        private var _levelRewardPointType:int;
        private var _SafeStr_1785:int;
        private var _finalLevel:Boolean;
        private var _category:String;
        private var _subCategory:String;
        private var _levelCount:int;
        private var _displayMethod:int;
        private var _state:int;

        public function AchievementData(_arg_1:IMessageDataWrapper)
        {
            _achievementId = _arg_1.readInteger();
            _level = _arg_1.readInteger();
            _badgeId = _arg_1.readString();
            _scoreAtStartOfLevel = _arg_1.readInteger();
            _SafeStr_1784 = Math.max(1, _arg_1.readInteger());
            _levelRewardPoints = _arg_1.readInteger();
            _levelRewardPointType = _arg_1.readInteger();
            _SafeStr_1785 = _arg_1.readInteger();
            _finalLevel = _arg_1.readBoolean();
            _category = _arg_1.readString();
            _subCategory = _arg_1.readString();
            _levelCount = _arg_1.readInteger();
            _displayMethod = _arg_1.readInteger();
            _state = _arg_1.readShort();
        }

        public function get achievementId():int
        {
            return (_achievementId);
        }

        public function get badgeId():String
        {
            return (_badgeId);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get scoreAtStartOfLevel():int
        {
            return (_scoreAtStartOfLevel);
        }

        public function get scoreLimit():int
        {
            return (_SafeStr_1784 - _scoreAtStartOfLevel);
        }

        public function get levelRewardPoints():int
        {
            return (_levelRewardPoints);
        }

        public function get levelRewardPointType():int
        {
            return (_levelRewardPointType);
        }

        public function get currentPoints():int
        {
            return (_SafeStr_1785 - _scoreAtStartOfLevel);
        }

        public function get finalLevel():Boolean
        {
            return (_finalLevel);
        }

        public function get category():String
        {
            return (_category);
        }

        public function get subCategory():String
        {
            return (_subCategory);
        }

        public function get levelCount():int
        {
            return (_levelCount);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get firstLevelAchieved():Boolean
        {
            return ((_level > 1) || (_finalLevel));
        }

        public function setMaxProgress():void
        {
            _SafeStr_1785 = _SafeStr_1784;
        }

        public function get displayMethod():int
        {
            return (_displayMethod);
        }


    }
}


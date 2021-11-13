package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementResolutionData 
    {

        public static const _SafeStr_1786:int = 0;

        private var _achievementId:int;
        private var _level:int;
        private var _badgeId:String;
        private var _requiredLevel:int;
        private var _state:int;

        public function AchievementResolutionData(_arg_1:IMessageDataWrapper)
        {
            _achievementId = _arg_1.readInteger();
            _level = _arg_1.readInteger();
            _badgeId = _arg_1.readString();
            _requiredLevel = _arg_1.readInteger();
            _state = _arg_1.readInteger();
        }

        public function dispose():void
        {
            _achievementId = 0;
            _level = 0;
            _badgeId = "";
            _requiredLevel = 0;
        }

        public function get achievementId():int
        {
            return (_achievementId);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get badgeId():String
        {
            return (_badgeId);
        }

        public function get requiredLevel():int
        {
            return (_requiredLevel);
        }

        public function get enabled():Boolean
        {
            return (_state == 0);
        }

        public function get state():int
        {
            return (_state);
        }


    }
}


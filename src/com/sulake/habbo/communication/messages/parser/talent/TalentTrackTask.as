package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TalentTrackTask 
    {

        public static const _SafeStr_2105:String = "ACH_HabboWayGraduate1";
        public static const _SafeStr_2106:String = "ACH_GuideGroupMember1";
        public static const _SafeStr_2107:String = "ACH_SafetyQuizGraduate1";
        public static const _SafeStr_2108:String = "ACH_EmailVerification1";
        public static const ROOM_ENTRY_1:String = "ACH_RoomEntry1";
        public static const ROOM_ENTRY_2:String = "ACH_RoomEntry2";
        public static const _SafeStr_2109:String = "ACH_AvatarLooks1";
        public static const _SafeStr_2110:String = "ACH_GuideAdvertisementReader1";

        private var _achievementId:int;
        private var _requiredLevel:int;
        private var _badgeCode:String;
        private var _state:int;
        private var _currentScore:int;
        private var _totalScore:int;

        public function TalentTrackTask(_arg_1:IMessageDataWrapper)
        {
            _achievementId = _arg_1.readInteger();
            _requiredLevel = _arg_1.readInteger();
            _badgeCode = _arg_1.readString();
            _state = _arg_1.readInteger();
            _currentScore = _arg_1.readInteger();
            _totalScore = _arg_1.readInteger();
        }

        public function get state():int
        {
            return (_state);
        }

        public function get achievementId():int
        {
            return (_achievementId);
        }

        public function get requiredLevel():int
        {
            return (_requiredLevel);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get currentScore():int
        {
            return (_currentScore);
        }

        public function get totalScore():int
        {
            return (_totalScore);
        }

        public function hasProgressDisplay():Boolean
        {
            switch (badgeCode)
            {
                case "ACH_HabboWayGraduate1":
                case "ACH_SafetyQuizGraduate1":
                case "ACH_EmailVerification1":
                case "ACH_AvatarLooks1":
                    return (false);
                default:
                    return (true);
            };
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementResolutionProgressMessageParser implements IMessageParser 
    {

        private var _stuffId:int;
        private var _achievementId:int;
        private var _requiredLevelBadgeCode:String;
        private var _userProgress:int;
        private var _totalProgress:int;
        private var _endTime:int;


        public function flush():Boolean
        {
            _stuffId = -1;
            _achievementId = 0;
            _requiredLevelBadgeCode = "";
            _userProgress = 0;
            _totalProgress = 0;
            _endTime = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _stuffId = _arg_1.readInteger();
            _achievementId = _arg_1.readInteger();
            _requiredLevelBadgeCode = _arg_1.readString();
            _userProgress = _arg_1.readInteger();
            _totalProgress = _arg_1.readInteger();
            _endTime = _arg_1.readInteger();
            return (true);
        }

        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function get achievementId():int
        {
            return (_achievementId);
        }

        public function get requiredLevelBadgeCode():String
        {
            return (_requiredLevelBadgeCode);
        }

        public function get userProgress():int
        {
            return (_userProgress);
        }

        public function get totalProgress():int
        {
            return (_totalProgress);
        }

        public function get endTime():int
        {
            return (_endTime);
        }


    }
}
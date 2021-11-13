package com.sulake.habbo.moderation
{
    public class ModActionDefinition 
    {

        public static const ALERT:int = 1;
        public static const MUTE:int = 2;
        public static const BAN:int = 3;
        public static const KICK:int = 4;
        public static const TRADING_LOCK:int = 5;
        public static const MESSAGE:int = 6;

        private var _actionId:int;
        private var _name:String;
        private var _actionType:int;
        private var _sanctionTypeId:int;
        private var _actionLengthHours:int;

        public function ModActionDefinition(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            _actionId = _arg_1;
            _name = _arg_2;
            _actionType = _arg_3;
            _sanctionTypeId = _arg_4;
            _actionLengthHours = _arg_5;
        }

        public function get actionId():int
        {
            return (_actionId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get actionType():int
        {
            return (_actionType);
        }

        public function get sanctionTypeId():int
        {
            return (_sanctionTypeId);
        }

        public function get actionLengthHours():int
        {
            return (_actionLengthHours);
        }


    }
}
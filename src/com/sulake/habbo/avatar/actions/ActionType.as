package com.sulake.habbo.avatar.actions
{
    public class ActionType 
    {

        private var _id:int;
        private var _value:int;
        private var _prevents:Array = [];
        private var _preventHeadTurn:Boolean = true;
        private var _isAnimated:Boolean = true;

        public function ActionType(_arg_1:XML)
        {
            _id = parseInt(_arg_1.@value);
            _value = parseInt(_arg_1.@value);
            var _local_3:String = String(_arg_1.@prevents);
            if (_local_3 != "")
            {
                _prevents = _local_3.split(",");
            };
            _preventHeadTurn = (String(_arg_1.@preventheadturn) == "true");
            var _local_2:String = String(_arg_1.@animated);
            if (_local_2 == "")
            {
                _isAnimated = true;
            }
            else
            {
                _isAnimated = (_local_2 == "true");
            };
        }

        public function get id():int
        {
            return (_id);
        }

        public function get value():int
        {
            return (_value);
        }

        public function get prevents():Array
        {
            return (_prevents);
        }

        public function get preventHeadTurn():Boolean
        {
            return (_preventHeadTurn);
        }

        public function get isAnimated():Boolean
        {
            return (_isAnimated);
        }


    }
}
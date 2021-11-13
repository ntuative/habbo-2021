package com.sulake.habbo.room.object.data
{
    public class HighScoreData 
    {

        private var _score:int;
        private var _users:Array = [];

        public function HighScoreData()
        {
            _score = -1;
        }

        public function get score():int
        {
            return (_score);
        }

        public function set score(_arg_1:int):void
        {
            _score = _arg_1;
        }

        public function get users():Array
        {
            return (_users);
        }

        public function set users(_arg_1:Array):void
        {
            _users = _arg_1;
        }

        public function addUser(_arg_1:String):void
        {
            _users.push(_arg_1);
        }


    }
}
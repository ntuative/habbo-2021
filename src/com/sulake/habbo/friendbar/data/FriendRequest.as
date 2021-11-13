package com.sulake.habbo.friendbar.data
{
    public class FriendRequest implements IFriendRequest 
    {

        private var _id:int;
        private var _name:String;
        private var _figure:String;

        public function FriendRequest(_arg_1:int, _arg_2:String, _arg_3:String)
        {
            _id = _arg_1;
            _name = _arg_2;
            _figure = _arg_3;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get figure():String
        {
            return (_figure);
        }


    }
}
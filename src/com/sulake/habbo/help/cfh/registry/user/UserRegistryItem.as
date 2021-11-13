package com.sulake.habbo.help.cfh.registry.user
{
    public class UserRegistryItem 
    {

        private var _userId:int;
        private var _userName:String = "";
        private var _roomName:String = "";
        private var _figure:String = "";
        private var _roomId:int;

        public function UserRegistryItem(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:String="")
        {
            _userId = _arg_1;
            _userName = _arg_2;
            _roomId = _arg_4;
            _roomName = _arg_5;
            _figure = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get roomName():String
        {
            return (_roomName);
        }

        public function set roomName(_arg_1:String):void
        {
            _roomName = _arg_1;
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}
package com.sulake.habbo.communication.messages.incoming.users
{
        public class RoomEntryData 
    {

        private var _roomId:int;
        private var _roomName:String;
        private var _hasControllers:Boolean = false;

        public function RoomEntryData(_arg_1:int, _arg_2:String, _arg_3:Boolean)
        {
            _roomId = _arg_1;
            _roomName = _arg_2;
            _hasControllers = _arg_3;
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get roomName():String
        {
            return (_roomName);
        }

        public function get hasControllers():Boolean
        {
            return (_hasControllers);
        }


    }
}
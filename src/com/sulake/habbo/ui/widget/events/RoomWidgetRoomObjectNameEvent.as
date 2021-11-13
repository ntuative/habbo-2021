package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomObjectNameEvent extends RoomWidgetUpdateEvent 
    {

        public static const OBJECT_NAME:String = "RWONE_TYPE";

        private var _userId:int;
        private var _category:int;
        private var _userName:String;
        private var _userType:int;
        private var _roomIndex:int;

        public function RoomWidgetRoomObjectNameEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int)
        {
            _userId = _arg_1;
            _category = _arg_2;
            _userName = _arg_3;
            _userType = _arg_4;
            _roomIndex = _arg_5;
            super("RWONE_TYPE", false, false);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get userType():int
        {
            return (_userType);
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
        }


    }
}
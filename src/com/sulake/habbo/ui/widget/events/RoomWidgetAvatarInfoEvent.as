package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetAvatarInfoEvent extends RoomWidgetUpdateEvent 
    {

        public static const AVATAR_INFO:String = "RWAIE_AVATAR_INFO";

        private var _userId:int;
        private var _userName:String;
        private var _userType:int;
        private var _allowNameChange:Boolean;
        private var _roomIndex:int;

        public function RoomWidgetAvatarInfoEvent(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("RWAIE_AVATAR_INFO", _arg_6, _arg_7);
            _userId = _arg_1;
            _userName = _arg_2;
            _userType = _arg_3;
            _roomIndex = _arg_4;
            _allowNameChange = _arg_5;
        }

        public function get userId():int
        {
            return (_userId);
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

        public function get allowNameChange():Boolean
        {
            return (_allowNameChange);
        }


    }
}
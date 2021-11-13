package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatSelectAvatarMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_SELECT_AVATAR:String = "RWCSAM_MESSAGE_SELECT_AVATAR";

        private var _objectId:int;
        private var _userName:String;
        private var _roomId:int;

        public function RoomWidgetChatSelectAvatarMessage(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int)
        {
            super(_arg_1);
            _objectId = _arg_2;
            _roomId = _arg_4;
            _userName = _arg_3;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}
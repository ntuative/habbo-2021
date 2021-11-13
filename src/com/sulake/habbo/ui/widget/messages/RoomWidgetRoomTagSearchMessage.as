package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetRoomTagSearchMessage extends RoomWidgetMessage 
    {

        public static const ROOM_TAG_SEARCH:String = "RWRTSM_ROOM_TAG_SEARCH";

        private var _tag:String = "";

        public function RoomWidgetRoomTagSearchMessage(_arg_1:String)
        {
            super("RWRTSM_ROOM_TAG_SEARCH");
            _tag = _arg_1;
        }

        public function get tag():String
        {
            return (_tag);
        }


    }
}
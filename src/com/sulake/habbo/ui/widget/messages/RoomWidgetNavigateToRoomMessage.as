package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetNavigateToRoomMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_NAVIGATE_TO_ROOM:String = "RWGOI_MESSAGE_NAVIGATE_TO_ROOM";
        public static const WIDGET_MESSAGE_NAVIGATE_HOME:String = "RWGOI_MESSAGE_NAVIGATE_HOME";

        private var _roomId:int;

        public function RoomWidgetNavigateToRoomMessage(_arg_1:String, _arg_2:int=-1)
        {
            super(_arg_1);
            _roomId = _arg_2;
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}
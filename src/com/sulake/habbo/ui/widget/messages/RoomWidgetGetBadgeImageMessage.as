package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_GET_BADGE_IMAGE:String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";

        private var _badgeId:String = "";

        public function RoomWidgetGetBadgeImageMessage(_arg_1:String)
        {
            super("RWGOI_MESSAGE_GET_BADGE_IMAGE");
            _badgeId = _arg_1;
        }

        public function get badgeId():String
        {
            return (_badgeId);
        }


    }
}
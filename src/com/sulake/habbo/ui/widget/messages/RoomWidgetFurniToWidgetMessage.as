package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFurniToWidgetMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_REQUEST_CREDITFURNI_WIDGET:String = "RWFWM_MESSAGE_REQUEST_CREDITFURNI";
        public static const WIDGET_MESSAGE_REQUEST_STICKIE_WIDGET:String = "RWFWM_MESSAGE_REQUEST_STICKIE";
        public static const WIDGET_MESSAGE_REQUEST_PRESENT_WIDGET:String = "RWFWM_MESSAGE_REQUEST_PRESENT";
        public static const WIDGET_MESSAGE_REQUEST_TROPHY_WIDGET:String = "RWFWM_MESSAGE_REQUEST_TROPHY";
        public static const WIDGET_MESSAGE_REQUEST_TEASER_WIDGET:String = "RWFWM_MESSAGE_REQUEST_TEASER";
        public static const WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET:String = "RWFWM_MESSAGE_REQUEST_ECOTRONBOX";
        public static const WIDGET_MESSAGE_REQUEST_DIMMER_WIDGET:String = "RWFWM_MESSAGE_REQUEST_DIMMER";
        public static const WIDGET_MESSAGE_REQUEST_PLACEHOLDER_WIDGET:String = "RWFWM_MESSAGE_REQUEST_PLACEHOLDER";
        public static const WIDGET_MESSAGE_REQUEST_CLOTHING_CHANGE_WIDGET:String = "RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE";
        public static const WIDGET_MESSAGE_REQUEST_PLAYLIST_EDITOR_WIDGET:String = "RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR";
        public static const WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING:String = "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING";
        public static const _SafeStr_4192:String = "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED";
        public static const WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING:String = "RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _roomId:int = 0;

        public function RoomWidgetFurniToWidgetMessage(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            super(_arg_1);
            _id = _arg_2;
            _category = _arg_3;
            _roomId = _arg_4;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}


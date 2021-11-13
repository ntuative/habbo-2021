package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetToolbarClickedUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const REQUEST_ME_MENU_TOOLBAR_CLICKED_EVENT:String = "RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED";
        public static const ICON_TYPE_ME_MENU:String = "ICON_TYPE_ME_MENU";
        public static const ICON_TYPE_ROOM_INFO:String = "ICON_TYPE_ROOM_INFO";

        private var _iconType:String;
        private var _active:Boolean = false;

        public function RoomWidgetToolbarClickedUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED", _arg_3, _arg_4);
            _iconType = _arg_1;
            _active = _arg_2;
        }

        public function get active():Boolean
        {
            return (_active);
        }

        public function get iconType():String
        {
            return (_iconType);
        }


    }
}
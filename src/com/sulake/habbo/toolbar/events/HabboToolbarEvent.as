package com.sulake.habbo.toolbar.events
{
    import flash.events.Event;

    public class HabboToolbarEvent extends Event 
    {

        public static const TOOLBAR_CLICK:String = "HTE_TOOLBAR_CLICK";
        public static const GROUP_ROOM_INFO_CLICK:String = "HTE_GROUP_ROOM_INFO_CLICK";
        public static const _SafeStr_3769:String = "HTIE_ICON_ZOOM";
        public static const RESIZED:String = "HTE_RESIZED";
        public static const CAMERA_TOGGLE:String = "HTE_ICON_CAMERA";
        public static const CAMERA_LAUNCH_ORIGIN_ROOM_TOOL:String = "roomToolsMenu";
        public static const CAMERA_LAUNCH_ORIGIN_CHAT:String = "chatCameraCommand";
        public static const CAMERA_LAUNCH_ORIGIN_EIW_MAKE_OWN:String = "imageWidgetMakeOwn";
        public static const CAMERA_LAUNCH_ORIGIN_TOOLBAR:String = "toolBarCameraIcon";

        private var _iconId:String;
        private var _iconName:String;

        public function HabboToolbarEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function set iconId(_arg_1:String):void
        {
            _iconId = _arg_1;
        }

        public function get iconId():String
        {
            return (_iconId);
        }

        public function set iconName(_arg_1:String):void
        {
            _iconName = _arg_1;
        }

        public function get iconName():String
        {
            return (_iconName);
        }


    }
}


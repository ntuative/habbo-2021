package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetAvatarEditorUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4028:String = "RWUE_HIDE_AVATAR_EDITOR";
        public static const _SafeStr_4029:String = "RWUE_AVATAR_EDITOR_CLOSED";

        public function RoomWidgetAvatarEditorUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}


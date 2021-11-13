package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetRequestWidgetMessage extends RoomWidgetMessage 
    {

        public static const REQUEST_USER_CHOOSER:String = "RWRWM_USER_CHOOSER";
        public static const REQUEST_FURNI_CHOOSER:String = "RWRWM_FURNI_CHOOSER";
        public static const REQUEST_ME_MENU:String = "RWRWM_ME_MENU";
        public static const REQUEST_EFFECTS:String = "RWRWM_EFFECTS";

        public function RoomWidgetRequestWidgetMessage(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}
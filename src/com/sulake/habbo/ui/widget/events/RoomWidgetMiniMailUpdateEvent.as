package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetMiniMailUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_2800:String = "RWMMUE_new_mini_mail";
        public static const _SafeStr_4037:String = "RWMMUE_unread_mini_mail";

        public function RoomWidgetMiniMailUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}


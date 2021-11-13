package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetShowPlaceholderEvent extends RoomWidgetUpdateEvent 
    {

        public static const SHOW_PLACEHOLDER:String = "RWSPE_SHOW_PLACEHOLDER";

        public function RoomWidgetShowPlaceholderEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}
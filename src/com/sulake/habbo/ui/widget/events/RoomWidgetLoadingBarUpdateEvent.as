package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetLoadingBarUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const SHOW:String = "RWLBUE_SHOW_LOADING_BAR";
        public static const HIDE:String = "RWLBUW_HIDE_LOADING_BAR";

        public function RoomWidgetLoadingBarUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}
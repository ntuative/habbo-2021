package com.sulake.habbo.ui.widget.events
{
    import flash.events.Event;

    public class RoomWidgetUpdateEvent extends Event 
    {

        public static const WIDGET_UPDATE_EVENT_TEST:String = "RWUE_EVENT_TEST";

        public function RoomWidgetUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}
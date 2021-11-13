package com.sulake.core.runtime.events
{
    import flash.events.Event;

    public class HotelViewEvent extends Event 
    {

        public static const HOTEL_VIEW_READY:String = "HOTEL_VIEW_READY";

        public function HotelViewEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}
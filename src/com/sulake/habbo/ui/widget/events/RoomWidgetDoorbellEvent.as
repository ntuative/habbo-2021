package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDoorbellEvent extends RoomWidgetUpdateEvent 
    {

        public static const RINGING:String = "RWDE_RINGING";
        public static const REJECTED:String = "RWDE_REJECTED";
        public static const ACCEPTED:String = "RWDE_ACCEPTED";

        private var _userName:String = "";

        public function RoomWidgetDoorbellEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _userName = _arg_2;
        }

        public function get userName():String
        {
            return (_userName);
        }


    }
}
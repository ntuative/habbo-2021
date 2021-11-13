package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetChooserContentEvent extends RoomWidgetUpdateEvent 
    {

        public static const USER_CHOOSER_CONTENT:String = "RWCCE_USER_CHOOSER_CONTENT";
        public static const FURNI_CHOOSER_CONTENT:String = "RWCCE_FURNI_CHOOSER_CONTENT";

        private var _items:Array;
        private var _isAnyRoomController:Boolean;

        public function RoomWidgetChooserContentEvent(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            _items = _arg_2.slice();
            _isAnyRoomController = _arg_3;
        }

        public function get items():Array
        {
            return (_items);
        }

        public function get isAnyRoomController():Boolean
        {
            return (_isAnyRoomController);
        }


    }
}
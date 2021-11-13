package com.sulake.habbo.ui.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetUserLocationUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const USER_LOCATION_UPDATE:String = "RWULUE_USER_LOCATION_UPDATE";

        private var _userId:int;
        private var _rectangle:Rectangle;
        private var _screenLocation:Point;

        public function RoomWidgetUserLocationUpdateEvent(_arg_1:int, _arg_2:Rectangle, _arg_3:Point, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RWULUE_USER_LOCATION_UPDATE", _arg_4, _arg_5);
            _userId = _arg_1;
            _rectangle = _arg_2;
            _screenLocation = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get rectangle():Rectangle
        {
            return (_rectangle);
        }

        public function get screenLocation():Point
        {
            return (_screenLocation);
        }


    }
}
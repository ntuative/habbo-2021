package com.sulake.habbo.ui.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const ROOM_VIEW_SIZE_CHANGED:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
        public static const ROOM_VIEW_SCALE_CHANGED:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
        public static const ROOM_VIEW_POSITION_CHANGED:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";

        private var _SafeStr_4051:Rectangle;
        private var _SafeStr_4052:Point;
        private var _scale:Number = 0;

        public function RoomWidgetRoomViewUpdateEvent(_arg_1:String, _arg_2:Rectangle=null, _arg_3:Point=null, _arg_4:Number=0, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            _SafeStr_4051 = _arg_2;
            _SafeStr_4052 = _arg_3;
            _scale = _arg_4;
        }

        public function get rect():Rectangle
        {
            if (_SafeStr_4051 != null)
            {
                return (_SafeStr_4051.clone());
            };
            return (null);
        }

        public function get positionDelta():Point
        {
            if (_SafeStr_4052 != null)
            {
                return (_SafeStr_4052.clone());
            };
            return (null);
        }

        public function get scale():Number
        {
            return (_scale);
        }


    }
}


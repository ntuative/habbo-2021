package com.sulake.habbo.room.events
{
    public class RoomEngineHSLColorEnableEvent extends RoomEngineEvent 
    {

        public static const ROOM_BACKGROUND_COLOR:String = "ROHSLCEE_ROOM_BACKGROUND_COLOR";

        private var _enable:Boolean;
        private var _hue:int;
        private var _saturation:int;
        private var _lightness:int;

        public function RoomEngineHSLColorEnableEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_7, _arg_8);
            _enable = _arg_3;
            _hue = _arg_4;
            _saturation = _arg_5;
            _lightness = _arg_6;
        }

        public function get enable():Boolean
        {
            return (_enable);
        }

        public function get hue():int
        {
            return (_hue);
        }

        public function get saturation():int
        {
            return (_saturation);
        }

        public function get lightness():int
        {
            return (_lightness);
        }


    }
}
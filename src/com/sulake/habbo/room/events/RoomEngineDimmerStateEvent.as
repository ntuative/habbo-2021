package com.sulake.habbo.room.events
{
    public class RoomEngineDimmerStateEvent extends RoomEngineEvent 
    {

        public static const _SafeStr_3155:String = "REDSE_ROOM_COLOR";

        private var _state:int;
        private var _presetId:int;
        private var _effectId:int;
        private var _color:uint;
        private var _brightness:int;

        public function RoomEngineDimmerStateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:uint, _arg_6:uint, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super("REDSE_ROOM_COLOR", _arg_1, _arg_7, _arg_8);
            _state = _arg_2;
            _presetId = _arg_3;
            _effectId = _arg_4;
            _color = _arg_5;
            _brightness = _arg_6;
        }

        public function get state():int
        {
            return (_state);
        }

        public function get presetId():int
        {
            return (_presetId);
        }

        public function get effectId():int
        {
            return (_effectId);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get brightness():uint
        {
            return (_brightness);
        }


    }
}


package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectDimmerStateUpdateEvent extends RoomObjectEvent 
    {

        public static const _SafeStr_3155:String = "RODSUE_DIMMER_STATE";

        private var _state:int;
        private var _presetId:int;
        private var _effectId:int;
        private var _color:uint;
        private var _brightness:int;

        public function RoomObjectDimmerStateUpdateEvent(_arg_1:IRoomObject, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:uint, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super("RODSUE_DIMMER_STATE", _arg_1, _arg_7, _arg_8);
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


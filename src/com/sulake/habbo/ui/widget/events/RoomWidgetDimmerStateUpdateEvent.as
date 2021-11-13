package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDimmerStateUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_3155:String = "RWDSUE_DIMMER_STATE";

        private var _state:int;
        private var _presetId:int;
        private var _effectId:int;
        private var _color:uint;
        private var _brightness:int;

        public function RoomWidgetDimmerStateUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:uint, _arg_5:uint, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("RWDSUE_DIMMER_STATE", _arg_6, _arg_7);
            _state = _arg_1;
            _presetId = _arg_2;
            _effectId = _arg_3;
            _color = _arg_4;
            _brightness = _arg_5;
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


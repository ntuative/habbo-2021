package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_SAVE_DIMMER_PRESET:String = "RWSDPM_SAVE_PRESET";

        private var _presetNumber:int;
        private var _effectTypeId:int;
        private var _color:uint;
        private var _brightness:int;
        private var _apply:Boolean;

        public function RoomWidgetDimmerSavePresetMessage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean)
        {
            super("RWSDPM_SAVE_PRESET");
            _presetNumber = _arg_1;
            _effectTypeId = _arg_2;
            _color = _arg_3;
            _brightness = _arg_4;
            _apply = _arg_5;
        }

        public function get presetNumber():int
        {
            return (_presetNumber);
        }

        public function get effectTypeId():int
        {
            return (_effectTypeId);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get brightness():int
        {
            return (_brightness);
        }

        public function get apply():Boolean
        {
            return (_apply);
        }


    }
}
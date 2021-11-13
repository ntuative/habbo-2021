package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerPreviewMessage extends RoomWidgetMessage 
    {

        public static const PREVIEW:String = "RWDPM_PREVIEW_DIMMER_PRESET";

        private var _color:uint;
        private var _brightness:int;
        private var _bgOnly:Boolean;

        public function RoomWidgetDimmerPreviewMessage(_arg_1:uint, _arg_2:int, _arg_3:Boolean)
        {
            super("RWDPM_PREVIEW_DIMMER_PRESET");
            _color = _arg_1;
            _brightness = _arg_2;
            _bgOnly = _arg_3;
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get brightness():int
        {
            return (_brightness);
        }

        public function get bgOnly():Boolean
        {
            return (_bgOnly);
        }


    }
}
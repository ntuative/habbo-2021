package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSettingsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4053:String = "RWSUE_SETTINGS";

        private var _uiVolume:Number;
        private var _furniVolume:Number;
        private var _traxVolume:Number;

        public function RoomWidgetSettingsUpdateEvent(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            _uiVolume = _arg_4;
            _furniVolume = _arg_3;
            _traxVolume = _arg_2;
        }

        public function get uiVolume():Number
        {
            return (_uiVolume);
        }

        public function get furniVolume():Number
        {
            return (_furniVolume);
        }

        public function get traxVolume():Number
        {
            return (_traxVolume);
        }


    }
}


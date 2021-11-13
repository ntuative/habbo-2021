package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDimmerUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4032:String = "RWDUE_PRESETS";
        public static const DIMMER_HIDE:String = "RWDUE_HIDE";

        private var _selectedPresetId:int = 0;
        private var _presets:Array = [];

        public function RoomWidgetDimmerUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get selectedPresetId():int
        {
            return (_selectedPresetId);
        }

        public function get presetCount():int
        {
            return (_presets.length);
        }

        public function get presets():Array
        {
            return (_presets);
        }

        public function set selectedPresetId(_arg_1:int):void
        {
            _selectedPresetId = _arg_1;
        }

        public function storePreset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_5:RoomWidgetDimmerUpdateEventPresetItem = new RoomWidgetDimmerUpdateEventPresetItem(_arg_1, _arg_2, _arg_3, _arg_4);
            _presets[(_arg_1 - 1)] = _local_5;
        }

        public function getPreset(_arg_1:int):RoomWidgetDimmerUpdateEventPresetItem
        {
            if (((_arg_1 < 0) || (_arg_1 >= _presets.count)))
            {
                return (null);
            };
            return (_presets[_arg_1]);
        }


    }
}


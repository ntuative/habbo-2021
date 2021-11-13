package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDimmerPresetsEvent extends RoomSessionEvent 
    {

        public static const ROOM_DIMMER_PRESETS:String = "RSDPE_PRESETS";

        private var _selectedPresetId:int = 0;
        private var _SafeStr_2081:Array = [];

        public function RoomSessionDimmerPresetsEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function get selectedPresetId():int
        {
            return (_selectedPresetId);
        }

        public function get presetCount():int
        {
            return (_SafeStr_2081.length);
        }

        public function set selectedPresetId(_arg_1:int):void
        {
            _selectedPresetId = _arg_1;
        }

        public function storePreset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_5:RoomSessionDimmerPresetsEventPresetItem = new RoomSessionDimmerPresetsEventPresetItem(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_2081[(_arg_1 - 1)] = _local_5;
        }

        public function getPreset(_arg_1:int):RoomSessionDimmerPresetsEventPresetItem
        {
            if (((_arg_1 < 0) || (_arg_1 >= _SafeStr_2081.count)))
            {
                return (null);
            };
            return (_SafeStr_2081[_arg_1]);
        }


    }
}


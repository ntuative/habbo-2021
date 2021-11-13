package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetSelectEffectMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4205:String = "RWCM_MESSAGE_SELECT_EFFECT";
        public static const _SafeStr_4206:String = "RWCM_MESSAGE_UNSELECT_EFFECT";
        public static const _SafeStr_4207:String = "RWCM_MESSAGE_UNSELECT_ALL_EFFECTS";

        private var _effectType:int;

        public function RoomWidgetSelectEffectMessage(_arg_1:String, _arg_2:int=-1)
        {
            super(_arg_1);
            _effectType = _arg_2;
        }

        public function get effectType():int
        {
            return (_effectType);
        }


    }
}


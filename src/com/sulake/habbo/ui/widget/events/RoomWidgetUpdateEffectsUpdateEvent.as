package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUpdateEffectsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4056:String = "RWUEUE_UPDATE_EFFECTS";

        private var _effects:Array;

        public function RoomWidgetUpdateEffectsUpdateEvent(_arg_1:Array=null, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("RWUEUE_UPDATE_EFFECTS", _arg_2, _arg_3);
            _effects = _arg_1;
        }

        public function get effects():Array
        {
            return (_effects);
        }


    }
}


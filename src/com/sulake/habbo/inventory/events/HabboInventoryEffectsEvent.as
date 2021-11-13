package com.sulake.habbo.inventory.events
{
    import flash.events.Event;

    public class HabboInventoryEffectsEvent extends Event 
    {

        public static const _SafeStr_2745:String = "HIEE_EFFECTS_CHANGED";

        private var _SafeStr_2740:Array;

        public function HabboInventoryEffectsEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}


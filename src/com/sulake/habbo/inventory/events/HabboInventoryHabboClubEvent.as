package com.sulake.habbo.inventory.events
{
    import flash.events.Event;

    public class HabboInventoryHabboClubEvent extends Event 
    {

        public static const _SafeStr_2747:String = "HIHCE_HABBO_CLUB_CHANGED";

        public function HabboInventoryHabboClubEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("HIHCE_HABBO_CLUB_CHANGED", _arg_1, _arg_2);
        }

    }
}


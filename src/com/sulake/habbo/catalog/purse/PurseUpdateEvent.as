package com.sulake.habbo.catalog.purse
{
    import flash.events.Event;

    public class PurseUpdateEvent extends Event 
    {

        public static const _SafeStr_1498:String = "catalog_purse_update";

        public function PurseUpdateEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("catalog_purse_update", _arg_1, _arg_2);
        }

    }
}


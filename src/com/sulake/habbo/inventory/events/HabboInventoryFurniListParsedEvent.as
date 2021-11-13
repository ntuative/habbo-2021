package com.sulake.habbo.inventory.events
{
    import flash.events.Event;

    public class HabboInventoryFurniListParsedEvent extends Event 
    {

        public static const _SafeStr_2746:String = "HFLPE_FURNI_LIST_PARSED";

        private var _category:String;

        public function HabboInventoryFurniListParsedEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("HFLPE_FURNI_LIST_PARSED");
            _category = _arg_1;
        }

        public function get category():String
        {
            return (_category);
        }


    }
}


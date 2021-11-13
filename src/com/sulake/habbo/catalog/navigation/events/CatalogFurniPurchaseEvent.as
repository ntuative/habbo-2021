package com.sulake.habbo.catalog.navigation.events
{
    import flash.events.Event;

    public class CatalogFurniPurchaseEvent extends Event 
    {

        public static const CATALOG_FURNI_PURCHASE:String = "CATALOG_FURNI_PURCHASE";

        private var _localizationId:String;

        public function CatalogFurniPurchaseEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("CATALOG_FURNI_PURCHASE", _arg_2, _arg_3);
            _localizationId = _arg_1;
        }

        public function get localizationId():String
        {
            return (_localizationId);
        }


    }
}
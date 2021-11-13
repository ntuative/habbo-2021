package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetPurchaseOverrideEvent extends Event 
    {

        private var _callback:Function;

        public function CatalogWidgetPurchaseOverrideEvent(_arg_1:Function, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("PURCHASE_OVERRIDE", _arg_2, _arg_3);
            _callback = _arg_1;
        }

        public function get callback():Function
        {
            return (_callback);
        }


    }
}
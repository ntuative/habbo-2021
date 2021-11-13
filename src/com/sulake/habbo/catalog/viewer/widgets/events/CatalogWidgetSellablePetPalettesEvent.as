package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetSellablePetPalettesEvent extends Event 
    {

        private var _productCode:String;
        private var _SafeStr_1539:Array;

        public function CatalogWidgetSellablePetPalettesEvent(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("SELLABLE_PET_PALETTES", _arg_3, _arg_4);
            _productCode = _arg_1;
            _SafeStr_1539 = _arg_2;
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get sellablePalettes():Array
        {
            if (_SafeStr_1539 != null)
            {
                return (_SafeStr_1539.slice());
            };
            return ([]);
        }


    }
}


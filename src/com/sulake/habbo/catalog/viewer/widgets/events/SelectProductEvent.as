package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public class SelectProductEvent extends Event 
    {

        private var _offer:IPurchasableOffer;

        public function SelectProductEvent(_arg_1:IPurchasableOffer, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("SELECT_PRODUCT", _arg_2, _arg_3);
            _offer = _arg_1;
        }

        public function get offer():IPurchasableOffer
        {
            return (_offer);
        }


    }
}
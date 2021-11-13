package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public class ProductOfferUpdatedEvent extends Event 
    {

        private var _offer:IPurchasableOffer;

        public function ProductOfferUpdatedEvent(_arg_1:IPurchasableOffer, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("CWE_PRODUCT_OFFER_UPDATED", _arg_2, _arg_3);
            _offer = _arg_1;
        }

        public function get offer():IPurchasableOffer
        {
            return (_offer);
        }


    }
}
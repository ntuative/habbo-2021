package com.sulake.habbo.catalog.viewer.widgets.utils
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.IWindow;

    public class RentUtils 
    {


        public static function updateBuyCaption(_arg_1:IPurchasableOffer, _arg_2:IWindow):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            _arg_2.caption = ((_arg_1.isRentOffer) ? "${catalog.purchase_confirmation.rent}" : "${catalog.purchase_confirmation.buy}");
        }


    }
}
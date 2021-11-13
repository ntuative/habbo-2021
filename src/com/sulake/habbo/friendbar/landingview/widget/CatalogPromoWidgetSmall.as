package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;

    public class CatalogPromoWidgetSmall extends CatalogPromoWidget 
    {

        public function CatalogPromoWidgetSmall(_arg_1:HabboLandingView)
        {
            super(_arg_1);
        }

        override protected function get xmlAssetName():String
        {
            return ("catalog_promo_small");
        }


    }
}
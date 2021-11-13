package com.sulake.habbo.friendbar.landingview.widget.elements
{
    public class _SafeStr_234 extends AbstractButtonElementHandler 
    {


        override protected function onClick():void
        {
            landingView.catalog.openClubCenter();
            landingView.tracking.trackGoogle("landingView", "click_buyVip");
        }


    }
}


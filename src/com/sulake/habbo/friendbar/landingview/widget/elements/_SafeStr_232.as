package com.sulake.habbo.friendbar.landingview.widget.elements
{
    public class _SafeStr_232 extends AbstractButtonElementHandler 
    {


        override protected function onClick():void
        {
            landingView.questEngine.reenableRoomCompetitionWindow();
            landingView.navigator.goToHomeRoom();
            landingView.tracking.trackGoogle("landingView", "click_gotohomeroom");
        }


    }
}


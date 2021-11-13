package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;

    public class PromotedRoomButtonElementHandler extends AbstractButtonElementHandler 
    {

        private var _SafeStr_2346:String;


        override protected function onClick():void
        {
            landingView.goToRoom(_SafeStr_2346);
            landingView.tracking.trackGoogle("landingView", ("click_promotedroom" + _SafeStr_2346));
        }

        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            if (_arg_3.length > 1)
            {
                _SafeStr_2346 = _arg_3[2];
            };
        }


    }
}


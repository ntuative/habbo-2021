package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;

    public class InternalLinkButtonElementHandler extends AbstractButtonElementHandler 
    {

        private var _SafeStr_2344:String;
        private var _SafeStr_2345:String;


        override public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            super.initialize(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_2344 = _arg_3[2];
            _SafeStr_2345 = _arg_4.configurationCode;
        }

        override protected function onClick():void
        {
            landingView.context.createLinkEvent(_SafeStr_2344);
            landingView.tracking.trackEventLog("LandingView", _SafeStr_2345, "client_link", _SafeStr_2344);
        }


    }
}


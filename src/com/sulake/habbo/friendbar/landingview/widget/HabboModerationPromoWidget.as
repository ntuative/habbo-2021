package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;

    public class HabboModerationPromoWidget implements ILandingViewWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;

        public function HabboModerationPromoWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("habbo_moderation_promo"));
            HabboLandingView.positionAfterAndStretch(_container, "title_txt", "hdr_line");
        }

        public function refresh():void
        {
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }


    }
}
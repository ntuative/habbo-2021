package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;

    public class SafetyQuizPromoWidget implements ILandingViewWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _disposed:Boolean;

        public function SafetyQuizPromoWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("safety_quiz_promo"));
            _container.procedure = widgetProcedure;
            refresh();
        }

        private function widgetProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WME_CLICK") && (_arg_2.name == "safety_quiz_button")))
            {
                _landingView.habboHelp.showSafetyBooklet();
            };
        }

        public function refresh():void
        {
            if (((!(_container == null)) && (!(_container.disposed))))
            {
                IAvatarImageWidget(IWidgetWindow(_container.findChildByName("avatar")).widget).figure = _landingView.sessionDataManager.figure;
            };
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_container != null)
                {
                    _container.dispose();
                    _container = null;
                };
                _landingView = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}
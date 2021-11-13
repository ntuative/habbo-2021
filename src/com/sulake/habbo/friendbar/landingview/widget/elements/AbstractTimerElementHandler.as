package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IFloatingElement;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ICountdownWidget;

    public class AbstractTimerElementHandler implements IElementHandler, IDisposable, IFloatingElement, ILayoutNameProvider 
    {

        private var _landingView:HabboLandingView;
        private var _window:IWindowContainer;
        private var _SafeStr_2333:Boolean;
        private var _timeRemainingKey:String;
        private var _expiredKey:String;


        public function get layoutName():String
        {
            return ("element_timer");
        }

        public function isFloating(_arg_1:Boolean):Boolean
        {
            return (_SafeStr_2333);
        }

        public function dispose():void
        {
            _landingView = null;
            _window = null;
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function refresh():void
        {
        }

        public function initialize(_arg_1:HabboLandingView, _arg_2:IWindow, _arg_3:Array, _arg_4:GenericWidget):void
        {
            _landingView = _arg_1;
            _window = IWindowContainer(_arg_2);
            _SafeStr_2333 = (_arg_3[1] == "true");
            _timeRemainingKey = _arg_3[4];
            _expiredKey = _arg_3[5];
            setCaption(null);
            if (_SafeStr_2333)
            {
                _window.x = _arg_3[2];
                _window.y = _arg_3[3];
            };
        }

        protected function setTimer(_arg_1:int):void
        {
            var _local_2:IWidgetWindow = IWidgetWindow(_window.findChildByName("countdown_widget"));
            _local_2.visible = (_arg_1 > 0);
            var _local_3:ICountdownWidget = ICountdownWidget(_local_2.widget);
            _local_3.seconds = _arg_1;
            setCaption(((_arg_1 > 0) ? _timeRemainingKey : _expiredKey));
        }

        private function setCaption(_arg_1:String):void
        {
            var _local_3:IWindow = _window.findChildByName("timer_caption_txt");
            var _local_2:Boolean = ((!(_arg_1 == null)) && (!(_arg_1 == "")));
            _local_3.visible = _local_2;
            if (_local_2)
            {
                _local_3.caption = (("${" + _arg_1) + "}");
            };
        }

        public function get landingView():HabboLandingView
        {
            return (_landingView);
        }


    }
}


package com.sulake.habbo.friendbar.landingview.layout
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.IResizeAwareWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.IDisableAwareWidget;

    public class WidgetContainer implements IDisposable 
    {

        private var _SafeStr_1324:ILandingViewWidget;
        private var _placeholderName:String;
        private var _SafeStr_2322:IWindowContainer;
        private var _SafeStr_527:Boolean;
        private var _SafeStr_2309:CommonWidgetSettings;

        public function WidgetContainer(_arg_1:ILandingViewWidget, _arg_2:String, _arg_3:CommonWidgetSettings, _arg_4:IWindowContainer=null)
        {
            _SafeStr_1324 = _arg_1;
            _placeholderName = _arg_2;
            _SafeStr_2309 = _arg_3;
            _SafeStr_2322 = _arg_4;
        }

        public function dispose():void
        {
            if (_SafeStr_1324)
            {
                _SafeStr_1324.dispose();
                _SafeStr_1324 = null;
            };
            if (_SafeStr_2309)
            {
                _SafeStr_2309 = null;
            };
        }

        public function get disposed():Boolean
        {
            return ((_SafeStr_1324 == null) && (_SafeStr_2309 == null));
        }

        public function refresh(_arg_1:IWindowContainer):void
        {
            var _local_3:IWindow;
            var _local_2:IWindowContainer = IWindowContainer(_arg_1.findChildByName("content_background"));
            if (!_SafeStr_527)
            {
                _SafeStr_527 = true;
                if (_placeholderName != null)
                {
                    _local_3 = _local_2.getChildByName(_placeholderName);
                    if (_local_3 == null)
                    {
                        return;
                    };
                    _SafeStr_1324.initialize();
                    _local_2.addChildAt(_SafeStr_1324.container, _local_2.getChildIndex(_local_3));
                    _SafeStr_1324.container.x = _local_3.x;
                    _SafeStr_1324.container.y = _local_3.y;
                    _local_2.removeChild(_local_3);
                    _local_3.dispose();
                }
                else
                {
                    if (((!(_SafeStr_2322 == null)) && (!(_SafeStr_1324 == null))))
                    {
                        _SafeStr_1324.initialize();
                        _SafeStr_2322.addChild(_SafeStr_1324.container);
                    }
                    else
                    {
                        return;
                    };
                };
            };
            if (_SafeStr_1324.container != null)
            {
                if (((_SafeStr_1324 is ISettingsAwareWidget) && (!(_SafeStr_2309 == null))))
                {
                    ISettingsAwareWidget(_SafeStr_1324).settings = _SafeStr_2309;
                };
                _SafeStr_1324.refresh();
            };
        }

        public function get container():IWindow
        {
            return (_SafeStr_1324.container);
        }

        public function windowResized():void
        {
            if ((((!(_SafeStr_1324 == null)) && (!(_SafeStr_1324.container == null))) && (_SafeStr_1324 is IResizeAwareWidget)))
            {
                IResizeAwareWidget(_SafeStr_1324).windowResized();
            };
        }

        public function disable():void
        {
            if ((((!(_SafeStr_1324 == null)) && (!(_SafeStr_1324.container == null))) && (_SafeStr_1324 is IDisableAwareWidget)))
            {
                IDisableAwareWidget(_SafeStr_1324).disable();
            };
        }


    }
}


package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.IConfigurationCodeAwareWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.IDisableAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.landingview.widget.elements._SafeStr_229;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IFloatingElement;
    import com.sulake.habbo.friendbar.landingview.widget.elements.TitleElementHandler;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IDisableAwareElement;
    import com.sulake.habbo.friendbar.landingview.*;

    public class GenericWidget implements ILandingViewWidget, ISlotAwareWidget, ISettingsAwareWidget, IConfigurationCodeAwareWidget, IDisableAwareWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _SafeStr_2365:int;
        private var _configurationCode:String;
        private var _SafeStr_2368:Map;

        public function GenericWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
            _SafeStr_2368 = new Map();
        }

        public static function configureLayout(_arg_1:HabboLandingView, _arg_2:int, _arg_3:String, _arg_4:IWindowContainer):void
        {
            var _local_9:Array;
            var _local_12:String;
            var _local_11:String;
            var _local_5:String = getConf(_arg_1, _arg_2, _arg_3, "layout");
            var _local_10:Array = _local_5.split(";");
            var _local_8:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_arg_4.findChildByName("bitmap"));
            var _local_6:IWindow = _arg_4.findChildByName("content_container");
            _local_6.x = ((isWideSlot(_arg_2)) ? 230 : 0);
            _arg_4.width = ((isWideSlot(_arg_2)) ? _arg_1.dynamicLayoutLeftPaneWidth : _arg_1.dynamicLayoutRightPaneWidth);
            for each (var _local_7:String in _local_10)
            {
                _local_9 = _local_7.split(",");
                _local_12 = _local_9[0];
                _local_11 = _local_9[1];
                switch (_local_12)
                {
                    case "bitmap.uri":
                        _local_8.assetUri = _local_11;
                        break;
                    case "bitmap.width":
                        _local_8.width = parseInt(_local_11);
                        break;
                    case "bitmap.height":
                        _local_8.height = parseInt(_local_11);
                        break;
                    case "bitmap.x":
                        _local_8.x = parseInt(_local_11);
                        break;
                    case "bitmap.y":
                        _local_8.y = parseInt(_local_11);
                        break;
                    case "content.x":
                        _local_6.x = parseInt(_local_11);
                        break;
                    case "content.y":
                        _local_6.y = parseInt(_local_11);
                        break;
                    case "content.width":
                        _local_6.width = parseInt(_local_11);
                        break;
                    case "container.height":
                        _arg_4.height = Math.max(parseInt(_local_11), _arg_4.height);
                };
            };
        }

        private static function getConf(_arg_1:HabboLandingView, _arg_2:int, _arg_3:String, _arg_4:String):String
        {
            var _local_5:String = ((_arg_3 != null) ? ((("landing.view." + _arg_3) + ".") + _arg_4) : ((("landing.view.dynamic.slot." + _arg_2) + ".") + _arg_4));
            return (_arg_1.getProperty(_local_5));
        }

        private static function isWideSlot(_arg_1:int):Boolean
        {
            return ((!(_arg_1 == 3)) && (!(_arg_1 == 5)));
        }


        public function set slot(_arg_1:int):void
        {
            _SafeStr_2365 = _arg_1;
        }

        public function get configurationCode():String
        {
            return (_configurationCode);
        }

        public function set configurationCode(_arg_1:String):void
        {
            _configurationCode = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
            for each (var _local_1:IElementHandler in _SafeStr_2368)
            {
                if ((_local_1 is IDisposable))
                {
                    IDisposable(_local_1).dispose();
                };
            };
            _SafeStr_2368 = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("generic_widget"));
            configureContentColumn();
            configureLayout(_landingView, _SafeStr_2365, _configurationCode, _container);
        }

        public function getElementByName(_arg_1:String):IElementHandler
        {
            return (_SafeStr_2368.getValue(_arg_1) as IElementHandler);
        }

        private function configureContentColumn():void
        {
            var _local_6:Array;
            var _local_8:String;
            var _local_1:IElementHandler;
            var _local_9:String;
            var _local_5:IWindow;
            var _local_2:String = getConf(_landingView, _SafeStr_2365, _configurationCode, "conf");
            var _local_7:Array = _local_2.split(";");
            if (((_local_2 == null) || (_local_2 == "")))
            {
                return;
            };
            var _local_4:IItemListWindow = IItemListWindow(_container.findChildByName("content_container"));
            for each (var _local_3:String in _local_7)
            {
                _local_6 = _local_3.split(",");
                _local_8 = _local_6[0];
                _local_1 = _SafeStr_229.createHandler(_local_8);
                _local_9 = ((_local_1 is ILayoutNameProvider) ? ILayoutNameProvider(_local_1).layoutName : ("element_" + _local_8));
                try
                {
                    _local_5 = _landingView.getXmlWindow(_local_9);
                }
                catch(e:Error)
                {
                    return;
                };
                if (_local_5 == null)
                {
                    return;
                };
                if (_local_1 != null)
                {
                    _local_1.initialize(_landingView, _local_5, _local_6, this);
                    _SafeStr_2368.add(_local_8, _local_1);
                };
                if (((_local_1 is IFloatingElement) && (IFloatingElement(_local_1).isFloating(isWideSlot(_SafeStr_2365)))))
                {
                    if ((_local_1 is TitleElementHandler))
                    {
                        _local_5.width = ((isWideSlot(_SafeStr_2365)) ? _landingView.dynamicLayoutLeftPaneWidth : _landingView.dynamicLayoutRightPaneWidth);
                    };
                    _container.addChild(_local_5);
                }
                else
                {
                    _local_4.addListItem(_local_5);
                };
            };
        }

        public function refresh():void
        {
            for each (var _local_1:IElementHandler in _SafeStr_2368)
            {
                _local_1.refresh();
            };
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function set settings(_arg_1:CommonWidgetSettings):void
        {
            WidgetContainerLayout.applyCommonWidgetSettings(_container, _arg_1);
        }

        public function disable():void
        {
            for each (var _local_1:IElementHandler in _SafeStr_2368)
            {
                if ((_local_1 is IDisableAwareElement))
                {
                    IDisableAwareElement(_local_1).disable();
                };
            };
        }


    }
}


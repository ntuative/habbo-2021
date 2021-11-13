package com.sulake.habbo.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextLinkWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class SimpleAlertDialog implements IDisposable 
    {

        private static const WINDOW_MARGIN:int = 10;

        private var _disposed:Boolean;
        private var _SafeStr_1665:IModalDialog;
        private var _SafeStr_780:String;
        private var _window:IWindowContainer;
        private var _SafeStr_853:IItemListWindow;
        private var _SafeStr_4402:IItemListWindow;
        private var _SafeStr_4403:IItemListWindow;
        private var _SafeStr_4399:IWindow;
        private var _SafeStr_4400:IWindow;
        private var _SafeStr_2344:ITextLinkWindow;
        private var _SafeStr_4401:IStaticBitmapWrapperWindow;
        private var _SafeStr_4404:Function;
        private var _SafeStr_4405:Function;
        private var _windowManager:HabboWindowManagerComponent;

        public function SimpleAlertDialog(_arg_1:HabboWindowManagerComponent, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:Map, _arg_8:String, _arg_9:Function, _arg_10:Function)
        {
            super();
            var _local_12:String = null;
            _SafeStr_4404 = _arg_9;
            _SafeStr_4405 = _arg_10;
            _windowManager = _arg_1;
            var _local_14:IAsset = _arg_1.assets.getAssetByName("simple_alert_xml");
            _SafeStr_1665 = _arg_1.buildModalDialogFromXML((_local_14.content as XML));
            _window = IWindowContainer(_SafeStr_1665.rootWindow);
            _SafeStr_853 = IItemListWindow(_window.findChildByName("list"));
            _SafeStr_4402 = IItemListWindow(_window.findChildByName("list_top"));
            _SafeStr_4403 = IItemListWindow(_window.findChildByName("list_bottom"));
            _SafeStr_4399 = _window.findChildByName("message");
            _SafeStr_4400 = _window.findChildByName("subtitle");
            _SafeStr_2344 = ITextLinkWindow(_window.findChildByName("link"));
            _SafeStr_4401 = IStaticBitmapWrapperWindow(_window.findChildByName("illustration"));
            _window.findChildByName("header_button_close").dispose();
            _window.procedure = windowProcedure;
            _window.caption = _arg_2;
            _SafeStr_4399.caption = _arg_4;
            if (_arg_7 != null)
            {
                for each (var _local_13:String in [_arg_2, _arg_3, _arg_4, _arg_5])
                {
                    if ((((!(_local_13 == null)) && (_local_13.substr(0, 2) == "${")) && (_local_13.indexOf("}") > 0)))
                    {
                        _local_12 = _local_13.substring(2, _local_13.indexOf("}"));
                        for (var _local_11:String in _arg_7)
                        {
                            _arg_1.localization.registerParameter(_local_12, _local_11, _arg_7.getValue(_local_11));
                        };
                    };
                };
            };
            if (((!(_arg_3 == null)) && (!(_arg_3 == ""))))
            {
                _SafeStr_4400.caption = _arg_3;
            }
            else
            {
                _SafeStr_4400.dispose();
                _SafeStr_4400 = null;
            };
            _arg_6 = _arg_1.interpolate(_arg_6);
            if ((((!(_arg_5 == null)) && (!(_arg_5 == ""))) && (((!(_arg_6 == null)) && (!(_arg_6 == ""))) || (!(_arg_9 == null)))))
            {
                _SafeStr_2344.caption = _arg_5;
                _SafeStr_2344.addEventListener("WME_CLICK", onSimpleAlertClick);
                _SafeStr_2344.immediateClickMode = true;
                _SafeStr_780 = _arg_6;
            }
            else
            {
                _SafeStr_2344.dispose();
                _SafeStr_2344 = null;
            };
            if (((!(_arg_8 == null)) && (!(_arg_8 == ""))))
            {
                _SafeStr_4401.addEventListener("WE_RESIZED", onIllustrationResized);
                _SafeStr_4401.assetUri = _arg_8;
            }
            else
            {
                _SafeStr_4401.dispose();
                _SafeStr_4401 = null;
            };
            resizeWindow();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                close();
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function close():void
        {
            if (_SafeStr_4405 != null)
            {
                (_SafeStr_4405());
            };
            if (_SafeStr_1665 != null)
            {
                if (_SafeStr_2344 != null)
                {
                    _SafeStr_2344.removeEventListener("WME_CLICK", onSimpleAlertClick);
                    _SafeStr_2344 = null;
                };
                if (_SafeStr_4401)
                {
                    _SafeStr_4401.removeEventListener("WE_RESIZED", onIllustrationResized);
                    _SafeStr_4401 = null;
                };
                _window = null;
                _SafeStr_853 = null;
                _SafeStr_4402 = null;
                _SafeStr_4403 = null;
                _SafeStr_4399 = null;
                _SafeStr_4400 = null;
                _SafeStr_4404 = null;
                _SafeStr_4405 = null;
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WME_CLICK") && (_arg_2.name == "close_button")))
            {
                dispose();
            };
        }

        private function onSimpleAlertClick(_arg_1:WindowMouseEvent):void
        {
            if (((!(_SafeStr_780 == null)) && (_SafeStr_780.length > 0)))
            {
                if (_SafeStr_780.substr(0, 6) == "event:")
                {
                    _windowManager.context.createLinkEvent(_SafeStr_780.substr(6));
                    dispose();
                }
                else
                {
                    HabboWebTools.openWebPage(_SafeStr_780, "habboMain");
                };
            }
            else
            {
                if (_SafeStr_4404 != null)
                {
                    (_SafeStr_4404());
                    dispose();
                };
            };
        }

        private function onIllustrationResized(_arg_1:WindowEvent):void
        {
            _SafeStr_4402.x = (_SafeStr_4401.width + 10);
            _SafeStr_4403.width = _SafeStr_4402.right;
            _window.width = (_SafeStr_4402.right + (2 * 10));
            _SafeStr_4402.limits.minHeight = (_SafeStr_4401.height + 10);
            resizeWindow();
        }

        private function resizeWindow():void
        {
            _SafeStr_4402.arrangeListItems();
            _SafeStr_4403.arrangeListItems();
            _SafeStr_853.arrangeListItems();
            _window.height = (_SafeStr_853.height + 40);
            _window.center();
        }


    }
}


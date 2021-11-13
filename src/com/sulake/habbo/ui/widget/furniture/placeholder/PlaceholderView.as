package com.sulake.habbo.ui.widget.furniture.placeholder
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class PlaceholderView 
    {

        private var _SafeStr_1354:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;

        public function PlaceholderView(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager)
        {
            _SafeStr_1354 = _arg_1;
            _windowManager = _arg_2;
        }

        public function dispose():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function toggleWindow():void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                hideWindow();
            }
            else
            {
                showWindow();
            };
        }

        public function showWindow():void
        {
            if (_window == null)
            {
                createWindow();
            };
            if (_window == null)
            {
                return;
            };
            _window.visible = true;
            _window.x = 200;
        }

        private function createWindow():void
        {
            var _local_2:XmlAsset = (_SafeStr_1354.getAssetByName("placeholder") as XmlAsset);
            if (((_local_2 == null) || (_local_2.content == null)))
            {
                return;
            };
            _window = (_windowManager.createWindow("habbohelp_window", "", 4, 0, (0x020000 | 0x01), new Rectangle(-300, 300, 10, 10), null) as IWindowContainer);
            _window.buildFromXML((_local_2.content as XML));
            _window.tags.push("habbo_help_window");
            _window.background = true;
            _window.color = 0x1FFFFFF;
            var _local_1:IWindow = _window.findChildByTag("close");
            if (_local_1 != null)
            {
                _local_1.procedure = onWindowClose;
            };
        }

        public function hideWindow():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            hideWindow();
        }


    }
}


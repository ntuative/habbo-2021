package com.sulake.habbo.phonenumber
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class VerificationCodeInputMinimizedView 
    {

        private static const BG_COLOR_LIGHT:uint = 4286084205;
        private static const BG_COLOR_DARK:uint = 4283781966;

        private var _SafeStr_659:HabboPhoneNumber;
        private var _window:IWindow;

        public function VerificationCodeInputMinimizedView(_arg_1:HabboPhoneNumber)
        {
            _SafeStr_659 = _arg_1;
            createWindow();
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.removeEventListener("WME_CLICK", onClicked);
                _window.dispose();
                _window = null;
            };
            _SafeStr_659 = null;
        }

        public function get window():IWindow
        {
            return (_window);
        }

        private function createWindow():void
        {
            if (_window)
            {
                return;
            };
            _window = _SafeStr_659.windowManager.buildFromXML(XML(_SafeStr_659.assets.getAssetByName("phonenumber_verify_minimized_xml").content));
            _window.addEventListener("WME_CLICK", onClicked);
            _window.addEventListener("WME_OVER", onContainerMouseOver);
            _window.addEventListener("WME_OUT", onContainerMouseOut);
            IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
        }

        private function onClicked(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_659.setVerifyViewMinimized(false);
        }

        private function onContainerMouseOver(_arg_1:WindowMouseEvent):void
        {
            IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4286084205;
        }

        private function onContainerMouseOut(_arg_1:WindowMouseEvent):void
        {
            IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
        }


    }
}


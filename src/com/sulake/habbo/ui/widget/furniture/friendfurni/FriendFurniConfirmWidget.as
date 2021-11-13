package com.sulake.habbo.ui.widget.furniture.friendfurni
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.ui.handler.FriendFurniConfirmWidgetHandler;
    import com.sulake.core.window.events.WindowEvent;

    public class FriendFurniConfirmWidget extends RoomWidgetBase 
    {

        private var _stuffId:int = -1;
        private var _mainWindow:IFrameWindow;
        private var _SafeStr_4102:int = -1;

        public function FriendFurniConfirmWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            confirmWidgetHandler.widget = this;
        }

        override public function dispose():void
        {
            _stuffId = -1;
            destroyWindow();
            super.dispose();
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        public function open(_arg_1:int, _arg_2:Boolean):void
        {
            if ((((_mainWindow) && (_mainWindow.visible)) && (!(_stuffId == -1))))
            {
                confirmWidgetHandler.sendLockConfirm(_stuffId, false);
                destroyWindow();
            };
            _stuffId = _arg_1;
            createWindow();
            if (!_arg_2)
            {
                _mainWindow.findChildByName("other_locked_container").height = 0;
            }
            else
            {
                _mainWindow.findChildByName("other_locked_container").height = _SafeStr_4102;
                _mainWindow.findChildByName("message").visible = false;
            };
            mainWindow.visible = true;
        }

        public function close(_arg_1:int):void
        {
            if (_arg_1 == _stuffId)
            {
                destroyWindow();
            };
        }

        public function otherConfirmed(_arg_1:int):void
        {
            if (((!(_mainWindow == null)) && (_arg_1 == _stuffId)))
            {
                IStaticBitmapWrapperWindow(_mainWindow.findChildByName("lock")).assetUri = "${image.library.url}furniextras/locked_image.png";
                _mainWindow.findChildByName("message").visible = true;
            };
        }

        private function createWindow():void
        {
            if (_mainWindow != null)
            {
                return;
            };
            _mainWindow = IFrameWindow(windowManager.buildFromXML(XML(assets.getAssetByName("lock_confirm_xml").content)));
            _mainWindow.procedure = windowProcedure;
            _SafeStr_4102 = _mainWindow.findChildByName("other_locked_container").height;
            _mainWindow.center();
        }

        private function destroyWindow():void
        {
            if (_mainWindow != null)
            {
                _mainWindow.dispose();
                _mainWindow = null;
            };
        }

        private function get confirmWidgetHandler():FriendFurniConfirmWidgetHandler
        {
            return (FriendFurniConfirmWidgetHandler(_SafeStr_3915));
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                    case "cancel_button":
                        confirmWidgetHandler.sendLockConfirm(_stuffId, false);
                        destroyWindow();
                        return;
                    case "confirm_button":
                        confirmWidgetHandler.sendLockConfirm(_stuffId, true);
                        destroyWindow();
                        return;
                };
            };
        }


    }
}


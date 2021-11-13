package com.sulake.habbo.toolbar.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.ToolbarView;
    import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsView;
    import com.sulake.habbo.toolbar.memenu.chatsettings.MeMenuChatSettingsView;
    import com.sulake.core.assets.XmlAsset;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MeMenuSettingsMenuView 
    {

        private var _widget:MeMenuController;
        private var _window:IWindowContainer;
        private var _SafeStr_3795:ToolbarView;
        private var _SafeStr_3804:MeMenuSoundSettingsView;
        private var _SafeStr_3805:MeMenuChatSettingsView;


        public function init(_arg_1:MeMenuController, _arg_2:ToolbarView):void
        {
            _SafeStr_3795 = _arg_2;
            _widget = _arg_1;
            createWindow();
        }

        public function dispose():void
        {
            if (_SafeStr_3804 != null)
            {
                _SafeStr_3804.dispose();
                _SafeStr_3804 = null;
            };
            if (_SafeStr_3805 != null)
            {
                _SafeStr_3805.dispose();
                _SafeStr_3805 = null;
            };
            _widget = null;
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        private function createWindow():void
        {
            var _local_1:XmlAsset = (_widget.toolbar.assets.getAssetByName("me_menu_settings_menu_xml") as XmlAsset);
            if (_local_1)
            {
                _window = (_widget.toolbar.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            };
            if (_window == null)
            {
                throw (new Error("Failed to construct settings window from XML!"));
            };
            _window.procedure = eventHandler;
            _window.x = (_SafeStr_3795.window.width + 10);
            _window.y = (_SafeStr_3795.window.bottom - _window.height);
            if (((!(ExternalInterface.available)) || (!(_widget.toolbar.getProperty("has.identity") == "1"))))
            {
                _window.findChildByName("character_settings").disable();
            }
            else
            {
                _window.findChildByName("identity_text").visible = false;
            };
            _window.findChildByName("chat_settings").visible = true;
        }

        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "character_settings":
                    HabboWebTools.openAvatars();
                    return;
                case "sound_settings":
                    _SafeStr_3804 = new MeMenuSoundSettingsView();
                    _SafeStr_3804.init(this, _SafeStr_3795);
                    _window.visible = false;
                    return;
                case "chat_settings":
                    _SafeStr_3805 = new MeMenuChatSettingsView();
                    _SafeStr_3805.init(this, _SafeStr_3795);
                    return;
                case "back":
                    _widget.window.visible = true;
                    dispose();
                    return;
            };
        }

        public function updateUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
        }

        public function get widget():MeMenuController
        {
            return (_widget);
        }


    }
}


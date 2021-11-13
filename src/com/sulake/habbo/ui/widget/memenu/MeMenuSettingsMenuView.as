package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MeMenuSettingsMenuView implements IMeMenuView 
    {

        private var _SafeStr_1324:MeMenuWidget;
        private var _window:IWindowContainer;


        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            _SafeStr_1324 = _arg_1;
            createWindow(_arg_2);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        private function createWindow(_arg_1:String):void
        {
            var _local_2:XmlAsset = (_SafeStr_1324.assets.getAssetByName("memenu_settings_menu") as XmlAsset);
            if (_local_2)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            };
            if (_window == null)
            {
                throw (new Error("Failed to construct settings window from XML!"));
            };
            _window.name = _arg_1;
            _window.procedure = eventHandler;
            if (((!(ExternalInterface.available)) || (!(_SafeStr_1324.config.getProperty("has.identity") == "1"))))
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
                    _SafeStr_1324.hide();
                    return;
                case "sound_settings":
                    _SafeStr_1324.changeView("me_menu_sound_settings");
                    return;
                case "chat_settings":
                    _SafeStr_1324.changeView("me_menu_chat_settings");
                    return;
                case "back":
                    _SafeStr_1324.changeView("me_menu_top_view");
                    return;
            };
        }

        public function updateUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
        }


    }
}


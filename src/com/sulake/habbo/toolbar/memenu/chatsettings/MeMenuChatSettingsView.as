package com.sulake.habbo.toolbar.memenu.chatsettings
{
    import com.sulake.habbo.toolbar.memenu.MeMenuSettingsMenuView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.ToolbarView;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MeMenuChatSettingsView 
    {

        private var _SafeStr_1324:MeMenuSettingsMenuView;
        private var _window:IWindowContainer;
        private var _SafeStr_3795:ToolbarView;


        public function init(_arg_1:MeMenuSettingsMenuView, _arg_2:ToolbarView):void
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_3795 = _arg_2;
            createWindow();
        }

        public function dispose():void
        {
            if (_window == null)
            {
                return;
            };
            var _local_1:_SafeStr_108 = (_window.findChildByName("prefer_old_chat_checkbox") as _SafeStr_108);
            _SafeStr_1324.window.visible = true;
            _SafeStr_1324.widget.toolbar.freeFlowChat.isDisabledInPreferences = ((!(_local_1 == null)) && (_local_1.isSelected));
            _window.dispose();
            _window = null;
            _SafeStr_1324 = null;
        }

        private function createWindow():void
        {
            var _local_3:int;
            var _local_1:IWindow;
            var _local_2:XmlAsset = (_SafeStr_1324.widget.toolbar.assets.getAssetByName("me_menu_chat_settings_xml") as XmlAsset);
            _window = (_SafeStr_1324.widget.toolbar.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            _window.x = (_SafeStr_3795.window.width + 10);
            _window.y = (_SafeStr_3795.window.bottom - _window.height);
            _SafeStr_1324.window.visible = false;
            _local_3 = 0;
            _local_1 = null;
            while (_local_3 < _window.numChildren)
            {
                _local_1 = _window.getChildAt(_local_3);
                _local_1.addEventListener("WME_CLICK", onButtonClicked);
                _local_3++;
            };
            _SafeStr_108(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = _SafeStr_1324.widget.toolbar.freeFlowChat.isDisabledInPreferences;
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "back_btn":
                    dispose();
                    return;
                case "prefer_old_chat_checkbox":
                    _SafeStr_1324.widget.toolbar.freeFlowChat.isDisabledInPreferences = _SafeStr_108(_window.findChildByName("prefer_old_chat_checkbox")).isSelected;
                    if (!_SafeStr_1324.widget.toolbar.freeFlowChat.isDisabledInPreferences)
                    {
                        if (_SafeStr_1324.widget.toolbar.roomUI.chatContainer != null)
                        {
                            _SafeStr_1324.widget.toolbar.roomUI.chatContainer.setDisplayObject(_SafeStr_1324.widget.toolbar.freeFlowChat.displayObject);
                        };
                    }
                    else
                    {
                        _SafeStr_1324.widget.toolbar.freeFlowChat.clear();
                    };
                    return;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }


    }
}


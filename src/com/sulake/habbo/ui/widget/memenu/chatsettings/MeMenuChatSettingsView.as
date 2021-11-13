package com.sulake.habbo.ui.widget.memenu.chatsettings
{
    import com.sulake.habbo.ui.widget.memenu.IMeMenuView;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MeMenuChatSettingsView implements IMeMenuView 
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
            var _local_2:RoomWidgetStoreSettingsMessage = new RoomWidgetStoreSettingsMessage("RWSSM_STORE_CHAT");
            var _local_1:_SafeStr_108 = (_window.findChildByName("prefer_old_chat_checkbox") as _SafeStr_108);
            _local_2.forceOldChat = ((!(_local_1 == null)) && (_local_1.isSelected));
            _SafeStr_1324.messageListener.processWidgetMessage(_local_2);
            _window.dispose();
            _window = null;
            _SafeStr_1324 = null;
        }

        private function createWindow(_arg_1:String):void
        {
            var _local_4:int;
            var _local_2:IWindow;
            var _local_3:XmlAsset = (_SafeStr_1324.assets.getAssetByName("memenu_chat_settings") as XmlAsset);
            if (_local_3)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            };
            if (_window == null)
            {
                throw (new Error("Failed to construct sound settings window from XML!"));
            };
            _window.name = _arg_1;
            _local_4 = 0;
            _local_2 = null;
            while (_local_4 < _window.numChildren)
            {
                _local_2 = _window.getChildAt(_local_4);
                _local_2.addEventListener("WME_CLICK", onButtonClicked);
                _local_4++;
            };
            _SafeStr_108(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = _SafeStr_1324.handler.container.freeFlowChat.isDisabledInPreferences;
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "back_btn":
                    _SafeStr_1324.changeView("me_menu_settings_view");
                    return;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function updateUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
        }


    }
}


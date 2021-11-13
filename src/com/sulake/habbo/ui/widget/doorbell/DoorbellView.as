package com.sulake.habbo.ui.widget.doorbell
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class DoorbellView 
    {

        private var _SafeStr_4016:DoorbellWidget;
        private var _mainWindow:IFrameWindow;
        private var _SafeStr_853:IItemListWindow;

        public function DoorbellView(_arg_1:DoorbellWidget)
        {
            _SafeStr_4016 = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_853 = null;
            _SafeStr_4016 = null;
            if (_mainWindow)
            {
                _mainWindow.dispose();
                _mainWindow = null;
            };
        }

        public function update():void
        {
            var _local_1:int;
            if (_SafeStr_4016.users.length == 0)
            {
                hide();
                return;
            };
            if (_mainWindow == null)
            {
                createMainWindow();
            };
            _mainWindow.visible = true;
            if (_SafeStr_853 != null)
            {
                _SafeStr_853.destroyListItems();
                _local_1 = 0;
                while (_local_1 < _SafeStr_4016.users.length)
                {
                    _SafeStr_853.addListItem(createListItem((_SafeStr_4016.users[_local_1] as String), _local_1));
                    _local_1++;
                };
            };
        }

        public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        private function createListItem(_arg_1:String, _arg_2:int):IWindow
        {
            var _local_5:IWindow;
            var _local_4:XmlAsset = (_SafeStr_4016.assets.getAssetByName("doorbell_list_entry") as XmlAsset);
            var _local_3:IWindowContainer = (_SafeStr_4016.windowManager.buildFromXML((_local_4.content as XML)) as IWindowContainer);
            if (_local_3 == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_6:ITextWindow = (_local_3.findChildByName("user_name") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _arg_1;
            };
            _local_3.name = _arg_1;
            if ((_arg_2 % 2) == 0)
            {
                _local_3.color = 0xFFFFFFFF;
            };
            _local_5 = _local_3.findChildByName("accept");
            if (_local_5 != null)
            {
                _local_5.addEventListener("WME_CLICK", onButtonClicked);
            };
            _local_5 = _local_3.findChildByName("deny");
            if (_local_5 != null)
            {
                _local_5.addEventListener("WME_CLICK", onButtonClicked);
            };
            return (_local_3);
        }

        private function hide():void
        {
            if (_mainWindow)
            {
                _mainWindow.dispose();
                _mainWindow = null;
            };
        }

        private function createMainWindow():void
        {
            if (_mainWindow != null)
            {
                return;
            };
            var _local_2:XmlAsset = (_SafeStr_4016.assets.getAssetByName("doorbell") as XmlAsset);
            _mainWindow = (_SafeStr_4016.windowManager.buildFromXML((_local_2.content as XML)) as IFrameWindow);
            if (_mainWindow == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _SafeStr_853 = (_mainWindow.findChildByName("user_list") as IItemListWindow);
            _mainWindow.visible = false;
            var _local_1:IWindow = _mainWindow.findChildByTag("close");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", onClose);
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_4016.denyAll();
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String = _arg_1.window.parent.name;
            switch (_arg_1.window.name)
            {
                case "accept":
                    _SafeStr_4016.accept(_local_2);
                    return;
                case "deny":
                    _SafeStr_4016.deny(_local_2);
                    return;
            };
        }


    }
}


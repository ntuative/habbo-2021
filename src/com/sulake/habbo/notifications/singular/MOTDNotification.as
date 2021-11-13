package com.sulake.habbo.notifications.singular
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MOTDNotification 
    {

        private const LIST_ITEM_HEIGHT_MARGIN:int = 20;

        private var _window:IFrameWindow;
        private var _SafeStr_819:IHabboLocalizationManager;
        private var _SafeStr_2122:Array;

        public function MOTDNotification(_arg_1:Array, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager)
        {
            super();
            var _local_9:String = null;
            var _local_8:IWindowContainer = null;
            var _local_7:ITextWindow = null;
            if (((!(_arg_3)) || (!(_arg_2))))
            {
                return;
            };
            _SafeStr_2122 = _arg_1;
            var _local_6:XmlAsset = (_arg_2.getAssetByName("motd_notification_xml") as XmlAsset);
            if (_local_6 == null)
            {
                return;
            };
            _window = (_arg_3.buildFromXML((_local_6.content as XML)) as IFrameWindow);
            if (_window == null)
            {
                return;
            };
            _window.procedure = eventHandler;
            _window.center();
            var _local_5:XmlAsset = (_arg_2.getAssetByName("motd_notification_item_xml") as XmlAsset);
            if (_local_5 == null)
            {
                return;
            };
            var _local_4:IWindowContainer = (_arg_3.buildFromXML((_local_5.content as XML)) as IWindowContainer);
            var _local_10:IItemListWindow = (_window.findChildByName("message_list") as IItemListWindow);
            for each (_local_9 in _SafeStr_2122)
            {
                _local_8 = (_local_4.clone() as IWindowContainer);
                _local_7 = (_local_8.findChildByName("message_text") as ITextWindow);
                _local_7.text = _local_9;
                _local_8.height = (_local_7.textHeight + 20);
                _local_10.addListItem(_local_8);
            };
        }

        public function dispose():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_819 = null;
        }

        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "close":
                case "header_button_close":
                    dispose();
                    return;
            };
        }


    }
}


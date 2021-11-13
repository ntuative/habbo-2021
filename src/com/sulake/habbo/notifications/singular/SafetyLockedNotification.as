package com.sulake.habbo.notifications.singular
{
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class SafetyLockedNotification 
    {

        private static const TOOLBAR_EXTENSION_ID:String = "safety_locked_notification";
        private static const LINK_COLOR_NORMAL:uint = 0xFFFFFF;
        private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;

        private var _window:_SafeStr_124;
        private var _catalog:IHabboCatalog;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_3031:ITextWindow;
        private var _SafeStr_1887:int;

        public function SafetyLockedNotification(_arg_1:int, _arg_2:IAssetLibrary, _arg_3:IHabboWindowManager, _arg_4:IHabboCatalog, _arg_5:IHabboToolbar)
        {
            if ((((!(_arg_2)) || (!(_arg_3))) || (!(_arg_4))))
            {
                return;
            };
            _catalog = _arg_4;
            _toolbar = _arg_5;
            _SafeStr_1887 = _arg_1;
            var _local_6:XmlAsset = (_arg_2.getAssetByName("safety_locked_notification_xml") as XmlAsset);
            if (_local_6 == null)
            {
                return;
            };
            _window = (_arg_3.buildFromXML((_local_6.content as XML)) as _SafeStr_124);
            if (_window == null)
            {
                return;
            };
            _window.procedure = eventHandler;
            _toolbar.extensionView.attachExtension("safety_locked_notification", _window);
            _SafeStr_3031 = (_window.findChildByName("unlock_link") as ITextWindow);
            var _local_7:IRegionWindow = (_window.findChildByName("unlock_link_region") as IRegionWindow);
            if (_local_7)
            {
                _local_7.addEventListener("WME_OVER", onMouseOver);
                _local_7.addEventListener("WME_OUT", onMouseOut);
            };
        }

        public function get visible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        public function dispose():void
        {
            if (_toolbar)
            {
                _toolbar.extensionView.detachExtension("safety_locked_notification");
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _catalog = null;
        }

        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "unlock_link_region":
                case "unlock_link":
                    _local_3 = (_toolbar as Component).getProperty("link.format.safetylock_unlock");
                    HabboWebTools.openWebPage(_local_3, "habboMain");
                    return;
            };
        }

        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_3031.textColor = 12247545;
        }

        private function onMouseOut(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_3031.textColor = 0xFFFFFF;
        }


    }
}


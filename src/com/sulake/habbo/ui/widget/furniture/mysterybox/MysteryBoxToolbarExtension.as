package com.sulake.habbo.ui.widget.furniture.mysterybox
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.session.events.MysteryBoxKeysUpdateEvent;

    public class MysteryBoxToolbarExtension implements IDisposable 
    {

        private static const _SafeStr_4119:String = "mystery_box_toolbar_extension_minimised";
        public static const KEY_COLORS:Dictionary = new Dictionary();

        private var _disposed:Boolean;
        private var _window:IWindowContainer;
        private var _SafeStr_3915:FurnitureContextMenuWidgetHandler;

        {
            KEY_COLORS["purple"] = 9452386;
            KEY_COLORS["blue"] = 3891856;
            KEY_COLORS["green"] = 6459451;
            KEY_COLORS["yellow"] = 10658089;
            KEY_COLORS["lilac"] = 6897548;
            KEY_COLORS["orange"] = 10841125;
            KEY_COLORS["turquoise"] = 2661026;
            KEY_COLORS["red"] = 10104881;
        }

        public function MysteryBoxToolbarExtension(_arg_1:FurnitureContextMenuWidgetHandler)
        {
            _SafeStr_3915 = _arg_1;
        }

        public function createWindow():void
        {
            var _local_1:XML = (_SafeStr_3915.widget.assets.getAssetByName("mystery_box_toolbar_extension").content as XML);
            _window = (_SafeStr_3915.container.windowManager.buildFromXML(_local_1) as IWindowContainer);
            _window.findChildByName("faq_link").visible = (!(_SafeStr_3915.container.config.getProperty("mysterybox.faq.url") == ""));
            _window.procedure = windowProcedure;
            _SafeStr_3915.container.toolbar.extensionView.attachExtension("mystery_box", _window);
            var _local_2:ISessionDataManager = _SafeStr_3915.container.sessionDataManager;
            _local_2.events.addEventListener("mbke_update", onKeysUpdated);
            setMinimised(minimised);
            setKeyColors(_local_2.mysteryBoxColor, _local_2.mysteryKeyColor);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_1.target.name)
            {
                case "minimize_region":
                    setMinimised(true);
                    return;
                case "maximize_region":
                    setMinimised(false);
                    return;
                case "faq_link":
                    HabboWebTools.openWebPage(_SafeStr_3915.container.config.getProperty("mysterybox.faq.url"), "habboMain");
                    return;
            };
        }

        private function setKeyColors(_arg_1:String, _arg_2:String):void
        {
            var _local_3:uint;
            var _local_6:uint;
            if (_window == null)
            {
                return;
            };
            var _local_5:Boolean = ((!(_arg_1 == null)) && (!(_arg_1 == "")));
            _window.findChildByName("box_colour").visible = _local_5;
            _window.findChildByName("box_overlay").visible = _local_5;
            _window.findChildByName("small_box").visible = ((_local_5) && (minimised));
            IRegionWindow(_window.findChildByName("box_region")).toolTipCaption = ((_local_5) ? (("${mysterybox.tracker.box." + _arg_1.toLowerCase()) + "}") : "");
            if (_local_5)
            {
                _local_3 = KEY_COLORS[_arg_1.toLowerCase()];
                _window.findChildByName("box_colour").color = _local_3;
                _window.findChildByName("small_box").color = _local_3;
            };
            var _local_4:Boolean = ((!(_arg_2 == null)) && (!(_arg_2 == "")));
            _window.findChildByName("key_colour").visible = _local_4;
            _window.findChildByName("key_overlay").visible = _local_4;
            _window.findChildByName("small_key").visible = ((_local_4) && (minimised));
            IRegionWindow(_window.findChildByName("key_region")).toolTipCaption = ((_local_4) ? (("${mysterybox.tracker.key." + _arg_2.toLowerCase()) + "}") : "");
            if (_local_4)
            {
                _local_6 = KEY_COLORS[_arg_2.toLowerCase()];
                _window.findChildByName("key_colour").color = _local_6;
                _window.findChildByName("small_key").color = _local_6;
            };
        }

        private function onKeysUpdated(_arg_1:MysteryBoxKeysUpdateEvent):void
        {
            setKeyColors(_arg_1.boxColor, _arg_1.keyColor);
        }

        private function get minimised():Boolean
        {
            return ((!(_SafeStr_3915 == null)) && (_SafeStr_3915.container.config.getBoolean("mystery_box_toolbar_extension_minimised")));
        }

        private function setMinimised(_arg_1:Boolean):void
        {
            if (((!(_SafeStr_3915 == null)) && (!(_window == null))))
            {
                if (_arg_1)
                {
                    _window.findChildByName("minimize_region").visible = false;
                    _window.findChildByName("maximize_region").visible = true;
                    _window.findChildByName("small_box").visible = _window.findChildByName("box_colour").visible;
                    _window.findChildByName("small_key").visible = _window.findChildByName("key_colour").visible;
                    _window.height = 25;
                }
                else
                {
                    _window.findChildByName("minimize_region").visible = true;
                    _window.findChildByName("maximize_region").visible = false;
                    _window.findChildByName("small_box").visible = false;
                    _window.findChildByName("small_key").visible = false;
                    _window.height = 137;
                };
                _SafeStr_3915.container.config.setProperty("mystery_box_toolbar_extension_minimised", _arg_1.toString());
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_3915 != null)
            {
                _SafeStr_3915.container.toolbar.extensionView.detachExtension("mystery_box");
                _SafeStr_3915.container.sessionDataManager.events.removeEventListener("mbke_update", onKeysUpdated);
                _SafeStr_3915 = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}


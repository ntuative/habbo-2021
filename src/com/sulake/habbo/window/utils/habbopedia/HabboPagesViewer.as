package com.sulake.habbo.window.utils.habbopedia
{
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import flash.text.StyleSheet;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.ByteArray;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.net.URLRequest;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.events.Event;

    public class HabboPagesViewer implements ILinkEventTracker 
    {

        public static var habbopedia_window_layout:Class = HabboHabboPagesViewer_Habbohabbopedia_window_layout_xml;
        public static var habbopedia_edit_layout:Class = HabboHabboPagesViewer_Habbohabbopedia_edit_layout_xml;
        public static var habbopedia_css:Class = HabboHabboPagesViewer_habbopedia_css;
        public static var styleSheet:StyleSheet = createStyleSheet();

        private var _windowManager:HabboWindowManagerComponent;
        private var _window:IWindowContainer;

        public function HabboPagesViewer(_arg_1:HabboWindowManagerComponent)
        {
            _windowManager = _arg_1;
            _windowManager.context.addLinkEventTracker(this);
            createStyleSheet();
        }

        private static function createStyleSheet():StyleSheet
        {
            var _local_2:StyleSheet = new StyleSheet();
            var _local_3:ByteArray = (new habbopedia_css() as ByteArray);
            var _local_1:String = _local_3.readUTFBytes(_local_3.length);
            _local_2.parseCSS(_local_1);
            return (_local_2);
        }


        private function set visible(_arg_1:Boolean):void
        {
            if (((_window == null) || (_window.disposed)))
            {
                _window = createWindow(habbopedia_window_layout, windowProcedure);
                (_window.findChildByName("content") as ITextWindow).styleSheet = styleSheet;
                (_window.findChildByName("content") as ITextWindow).addEventListener("WE_CHANGE", onChanged);
            };
            _window.visible = _arg_1;
        }

        private function onChanged(_arg_1:WindowEvent):void
        {
            (_window.findChildByName("scroller") as IScrollbarWindow).scrollV = 0;
        }

        private function get visible():Boolean
        {
            return ((!(_window == null)) && (_window.visible));
        }

        private function createWindow(_arg_1:Class, _arg_2:Function):IWindowContainer
        {
            var _local_3:ByteArray = (new _arg_1() as ByteArray);
            var _local_4:XML = new XML(_local_3.readUTFBytes(_local_3.length));
            var _local_5:IWindowContainer = (_windowManager.buildFromXML(_local_4) as IWindowContainer);
            _local_5.procedure = _arg_2;
            return (_local_5);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    visible = false;
                    return;
                case "close":
                    _window.visible = false;
                    return;
            };
        }

        private function parseAndSetHtml(_arg_1:String, _arg_2:String):void
        {
            _window.caption = _arg_2;
            (_window.findChildByName("content") as HTMLTextController).htmlText = _arg_1;
            (_window.findChildByName("content") as ITextWindow).styleSheet = styleSheet;
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _windowManager = null;
        }

        public function get disposed():Boolean
        {
            return (_windowManager == null);
        }

        public function get linkPattern():String
        {
            return ("habbopages/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            _local_2.shift();
            var _local_3:String = _local_2.join("/");
            openPage(_local_3);
        }

        public function openPage(_arg_1:String):void
        {
            var _local_4:AssetLoaderStruct;
            var _local_2:String = _windowManager.getProperty("habbopages.url");
            var _local_5:String = (_local_2 + _arg_1);
            if (_windowManager.assets.hasAsset(_local_5))
            {
                Logger.log(("[HabboPagesViewer] reload page: " + _local_5));
                _windowManager.assets.removeAsset(_windowManager.assets.getAssetByName(_local_5));
            };
            var _local_3:URLRequest = new URLRequest((_local_2 + _arg_1));
            _local_4 = _windowManager.assets.loadAssetFromFile(_local_5, _local_3, "text/plain");
            _local_4.addEventListener("AssetLoaderEventComplete", onDownloadComplete);
            _local_4.addEventListener("AssetLoaderEventError", onDownloadError);
        }

        private function onDownloadError(_arg_1:Event=null):void
        {
            var _local_3:AssetLoaderEvent = (_arg_1 as AssetLoaderEvent);
            var _local_2:int;
            if (_local_3 != null)
            {
                _local_2 = _local_3.status;
            };
            HabboWebTools.logEventLog(("habbopages download error " + _local_2));
        }

        private function onDownloadComplete(_arg_1:Event=null):void
        {
            var _local_6:Array;
            var _local_7:String;
            var _local_5:String;
            var _local_4:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:RegExp = /\n\r|\n|\r/gm;
            var _local_3:String = (_local_4.assetLoader.content as String);
            if (_local_3 != null)
            {
                _local_6 = _local_3.split(_local_2);
                _local_7 = _local_6.shift();
                _local_5 = _local_6.join("");
                visible = true;
                parseAndSetHtml(_local_5, _local_7);
                _window.activate();
            };
        }


    }
}


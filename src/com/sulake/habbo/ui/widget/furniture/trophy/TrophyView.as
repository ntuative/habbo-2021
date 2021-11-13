package com.sulake.habbo.ui.widget.furniture.trophy
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class TrophyView implements ITrophyView 
    {

        private static const BG_IMAGE_LIST:Array = new Array("trophy_bg_gold", "trophy_bg_silver", "trophy_bg_bronze");
        private static const BG_COLOR_LIST:Array = new Array(4293707079, 4291411404, 4290279476);

        private var _SafeStr_1324:ITrophyFurniWidget;
        private var _window:IWindowContainer;

        public function TrophyView(_arg_1:ITrophyFurniWidget)
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1324 = null;
        }

        public function showInterface():Boolean
        {
            var _local_2:IWindow;
            var _local_9:IWindowContainer;
            var _local_6:ITextWindow;
            var _local_3:ITextWindow;
            var _local_7:ITextWindow;
            var _local_5:BitmapDataAsset;
            var _local_4:BitmapData;
            var _local_8:IBitmapWrapperWindow;
            var _local_10:IAsset = _SafeStr_1324.assets.getAssetByName("trophy");
            var _local_1:XmlAsset = XmlAsset(_local_10);
            if (_local_1 == null)
            {
                return (false);
            };
            if (_window == null)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            };
            _window.center();
            _local_2 = _window.findChildByName("close");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _local_9 = (_window.findChildByName("title_bg") as IWindowContainer);
            if (_local_9 != null)
            {
                _local_9.color = BG_COLOR_LIST[_SafeStr_1324.color];
            };
            _local_6 = (_window.findChildByName("greeting") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.text = _SafeStr_1324.message.replace(/\\r/g, "\n");
            };
            _local_3 = (_window.findChildByName("date") as ITextWindow);
            if (_local_3 != null)
            {
                _local_3.text = _SafeStr_1324.date;
            };
            _local_7 = (_window.findChildByName("name") as ITextWindow);
            if (_local_7 != null)
            {
                _local_7.text = _SafeStr_1324.name;
            };
            _local_5 = (_SafeStr_1324.assets.getAssetByName(BG_IMAGE_LIST[_SafeStr_1324.color]) as BitmapDataAsset);
            _local_8 = (_window.findChildByName("trophy_bg") as IBitmapWrapperWindow);
            if (_local_5 != null)
            {
                _local_4 = (_local_5.content as BitmapData);
                _local_8.bitmap = _local_4;
            };
            return (true);
        }

        public function disposeInterface():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            disposeInterface();
        }


    }
}


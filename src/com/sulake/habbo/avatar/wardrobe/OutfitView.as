package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OutfitView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_1354:IAssetLibrary;
        private var _window:IWindowContainer;
        private var _SafeStr_1355:IBitmapWrapperWindow;

        public function OutfitView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:Boolean)
        {
            _windowManager = _arg_1;
            _SafeStr_1354 = _arg_2;
            var _local_4:XmlAsset = (_SafeStr_1354.getAssetByName("Outfit") as XmlAsset);
            _window = IWindowContainer(_windowManager.buildFromXML((_local_4.content as XML)));
            if (_window != null)
            {
                _SafeStr_1355 = (_window.findChildByName("bitmap") as IBitmapWrapperWindow);
            };
            if (!_arg_3)
            {
                _window.findChildByName("button").disable();
            };
        }

        public function dispose():void
        {
            _windowManager = null;
            _SafeStr_1354 = null;
            if (_window)
            {
                _window.dispose();
            };
            _window = null;
            if (_SafeStr_1355)
            {
                _SafeStr_1355.dispose();
            };
            _SafeStr_1355 = null;
        }

        public function update(_arg_1:BitmapData):void
        {
            _SafeStr_1355.bitmap = new BitmapData(_SafeStr_1355.width, _SafeStr_1355.height, true, 0xFFFFFF);
            var _local_2:int = int(((_SafeStr_1355.width - _arg_1.width) / 2));
            var _local_3:int = (_SafeStr_1355.height - _arg_1.height);
            _SafeStr_1355.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_2, _local_3));
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                if (_arg_1.type == "WME_OVER")
                {
                    _window.color = 0xCCCCCC;
                }
                else
                {
                    if (_arg_1.type == "WME_OUT")
                    {
                        _window.color = 0x666666;
                    };
                };
            };
        }


    }
}


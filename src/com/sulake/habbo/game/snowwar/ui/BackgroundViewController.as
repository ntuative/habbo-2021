package com.sulake.habbo.game.snowwar.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class BackgroundViewController implements IDisposable 
    {

        private var _disposed:Boolean;
        private var _SafeStr_2499:SnowWarEngine;
        private var _background:IWindowContainer;

        public function BackgroundViewController(_arg_1:SnowWarEngine)
        {
            _SafeStr_2499 = _arg_1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            _SafeStr_2499 = null;
            if (_background)
            {
                _background.dispose();
                _background = null;
            };
            _disposed = true;
        }

        public function get background():IWindow
        {
            if (!_background)
            {
                createView();
            };
            return (_background);
        }

        private function createView():void
        {
            var _local_1:IDesktopWindow = _SafeStr_2499.windowManager.getDesktop(0);
            _background = (WindowUtils.createWindow("snowwar_loading_background_xml", 1) as IWindowContainer);
            _background.width = _local_1.width;
            _background.height = _local_1.height;
            _local_1.addChildAt(_background, 0);
            setBitmap("bg_sky", "sky", _background);
            setBitmap("bg_sunshine", "sunshine", _background);
            setBitmap("bg_vista_1", "vista_1", _background, true);
            setBitmap("bg_vista_2", "vista_2", _background, true);
            setBitmap("bg_vista_3", "vista_3", _background, true);
        }

        private function setBitmap(_arg_1:String, _arg_2:String, _arg_3:IWindowContainer, _arg_4:Boolean=false):void
        {
            var _local_8:BitmapData;
            var _local_6:int;
            var _local_9:BitmapDataAsset = (_SafeStr_2499.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            var _local_7:IBitmapWrapperWindow = (_arg_3.findChildByName(_arg_2) as IBitmapWrapperWindow);
            var _local_5:BitmapData = (_local_9.content as BitmapData);
            if (_arg_4)
            {
                _local_8 = new BitmapData(_arg_3.width, _local_5.height, true, 0);
                _local_6 = 0;
                while (_local_6 < ((_arg_3.width / _local_5.width) + 1))
                {
                    _local_8.copyPixels(_local_5, _local_5.rect, new Point((_local_6 * _local_5.width), 0));
                    _local_6++;
                };
                _local_7.bitmap = _local_8;
            }
            else
            {
                _local_7.bitmap = _local_5;
                _local_7.disposesBitmap = false;
            };
        }


    }
}


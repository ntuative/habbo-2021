package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.display.BitmapData;

    public class OfficialRoomImageLoader implements IDisposable 
    {

        private var _navigator:IHabboTransitionalNavigator;
        private var _SafeStr_2930:String;
        private var _SafeStr_780:String;
        private var _SafeStr_2931:IBitmapWrapperWindow;
        private var _disposed:Boolean;

        public function OfficialRoomImageLoader(_arg_1:IHabboTransitionalNavigator, _arg_2:String, _arg_3:IBitmapWrapperWindow)
        {
            _navigator = _arg_1;
            _SafeStr_2930 = _arg_2;
            _SafeStr_2931 = _arg_3;
            var _local_4:String = _navigator.getProperty("image.library.url");
            _SafeStr_780 = (_local_4 + _SafeStr_2930);
            Logger.log(("[OFFICIAL ROOM ICON IMAGE DOWNLOADER] : " + _SafeStr_780));
        }

        public function startLoad():void
        {
            var _local_1:URLRequest;
            var _local_2:AssetLoaderStruct;
            if (_navigator.assets.hasAsset(_SafeStr_2930))
            {
                setImage();
            }
            else
            {
                _local_1 = new URLRequest(_SafeStr_780);
                _local_2 = _navigator.assets.loadAssetFromFile(_SafeStr_2930, _local_1, "image/gif");
                _local_2.addEventListener("AssetLoaderEventComplete", onImageReady);
                _local_2.addEventListener("AssetLoaderEventError", onLoadError);
            };
        }

        private function onImageReady(_arg_1:AssetLoaderEvent):void
        {
            if (_disposed)
            {
                return;
            };
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null)
            {
                Logger.log((("Loading pic from url: " + _SafeStr_780) + " failed. loaderStruct == null"));
                return;
            };
            setImage();
        }

        private function setImage():void
        {
            var _local_1:BitmapData;
            if (((((_navigator) && (!(_navigator.disposed))) && (_SafeStr_2931)) && (!(_SafeStr_2931.disposed))))
            {
                _local_1 = _navigator.getButtonImage(_SafeStr_2930, "");
                if (_local_1)
                {
                    _SafeStr_2931.disposesBitmap = false;
                    _SafeStr_2931.bitmap = _local_1;
                    _SafeStr_2931.width = _local_1.width;
                    _SafeStr_2931.height = _local_1.height;
                    _SafeStr_2931.visible = true;
                }
                else
                {
                    Logger.log(("OfficialRoomImageLoader - Image not found: " + _SafeStr_2930));
                };
            };
            dispose();
        }

        private function onLoadError(_arg_1:AssetLoaderEvent):void
        {
            Logger.log(((("Error loading image: " + _SafeStr_780) + ", ") + _arg_1));
            dispose();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _SafeStr_2931 = null;
            _navigator = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}


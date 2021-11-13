package com.sulake.habbo.ui.widget.camera
{
    import flash.utils.Dictionary;
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import flash.display.Bitmap;
    import flash.events.Event;

    public class CameraFxPreloader 
    {

        private static var ASSETS:Dictionary;
        private static var instance:CameraFxPreloader;
        private static var _urls:Array;
        private static var _SafeStr_3305:String;

        private var _SafeStr_779:Loader;
        private var _SafeStr_3940:Boolean = false;

        public function CameraFxPreloader()
        {
            _SafeStr_779 = new Loader();
            _SafeStr_779.contentLoaderInfo.addEventListener("complete", assetLoaded);
            _SafeStr_779.contentLoaderInfo.addEventListener("ioError", loadFailed);
            loadNextImage();
        }

        public static function init(_arg_1:String, _arg_2:Array):void
        {
            if (!instance)
            {
                ASSETS = new Dictionary();
                _SafeStr_3305 = _arg_1;
                _urls = _arg_2;
                instance = new CameraFxPreloader();
            };
        }

        public static function preloadFinished():Boolean
        {
            return ((instance != null) ? instance._SafeStr_3940 : false);
        }

        public static function getImage(_arg_1:String):BitmapData
        {
            return ((ASSETS != null) ? ASSETS[_arg_1] : null);
        }


        private function loadNextImage():void
        {
            var _local_1:String;
            if (_urls.length > 0)
            {
                _local_1 = (((_SafeStr_3305 + "Habbo-Stories/") + _urls[0]) + ".png");
                _SafeStr_779.load(new URLRequest(_local_1));
            }
            else
            {
                _SafeStr_3940 = true;
            };
        }

        private function assetLoaded(_arg_1:Event):void
        {
            ASSETS[_urls.shift()] = Bitmap(_SafeStr_779.content).bitmapData.clone();
            loadNextImage();
        }

        private function loadFailed(_arg_1:Event):void
        {
            Logger.log(("Camera Fx preloading failed for " + _SafeStr_779.contentLoaderInfo.loaderURL));
            _urls.shift();
            loadNextImage();
        }


    }
}


package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.Core;
    import flash.events.Event;
    import com.sulake.core.utils.LibraryLoaderEvent;

    public class AvatarAssetDownloadLibrary extends EventDispatcherWrapper 
    {

        private static const CACHE_KEY_PREFIX:String = "avatar/";

        private static var STATE_IDLE:int = 0;
        private static var STATE_DOWNLOADING:int = 1;
        private static var STATE_READY:int = 2;

        private var _SafeStr_448:int;
        private var _libraryName:String;
        private var _revision:String;
        private var _downloadUrl:String;
        private var _cacheKey:String;
        private var _assets:IAssetLibrary;

        public function AvatarAssetDownloadLibrary(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:IAssetLibrary, _arg_5:String)
        {
            _SafeStr_448 = STATE_IDLE;
            _assets = _arg_4;
            _libraryName = _arg_1;
            _cacheKey = ("avatar/" + _libraryName);
            _revision = _arg_2;
            _downloadUrl = (_arg_3 + _arg_5);
            _downloadUrl = _downloadUrl.replace("%libname%", _libraryName);
            _downloadUrl = _downloadUrl.replace("%revision%", _revision);
            var _local_6:AssetLibraryCollection = (_assets as AssetLibraryCollection);
            var _local_7:IAssetLibrary = _local_6.getAssetLibraryByUrl((_libraryName + ".swf"));
            if (_local_7 != null)
            {
                _SafeStr_448 = STATE_READY;
            };
        }

        override public function dispose():void
        {
            super.dispose();
        }

        public function startDownloading():void
        {
            _SafeStr_448 = STATE_DOWNLOADING;
            var _local_1:URLRequest = new URLRequest(_downloadUrl);
            var _local_2:LibraryLoader = new LibraryLoader();
            _assets.loadFromFile(_local_2, true);
            _local_2.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", onLoaderComplete);
            _local_2.addEventListener("LIBRARY_LOADER_EVENT_ERROR", onLoaderError);
            _local_2.load(_local_1, _cacheKey, _revision);
        }

        private function onLoaderError(_arg_1:LibraryLoaderEvent):void
        {
            _SafeStr_448 = STATE_READY;
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            _local_2.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", onLoaderComplete);
            _local_2.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", onLoaderError);
            Core.error(((((((((("Could not load avatar asset library " + _libraryName) + " from URL ") + _downloadUrl) + " HTTP status ") + _arg_1.status) + " bytes loaded ") + _arg_1.bytesLoaded) + "/") + _arg_1.bytesTotal), false, 2);
            dispatchEvent(new Event("complete"));
        }

        private function onLoaderComplete(_arg_1:Event):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            _local_2.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", onLoaderComplete);
            _local_2.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", onLoaderError);
            _SafeStr_448 = STATE_READY;
            dispatchEvent(new Event("complete"));
        }

        public function get libraryName():String
        {
            return (_libraryName);
        }

        public function get isReady():Boolean
        {
            return (_SafeStr_448 == STATE_READY);
        }

        public function toString():String
        {
            var _local_1:String = _libraryName;
            return (_local_1 + ((isReady) ? "[x]" : "[ ]"));
        }


    }
}


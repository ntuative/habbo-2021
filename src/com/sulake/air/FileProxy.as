package com.sulake.air
{
    import com.sulake.core.utils.IFileProxy;
    import flash.utils.Dictionary;
//    import flash.filesystem.File;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
//    import flash.filesystem.FileStream;
    import flash.events.Event;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.IOErrorEvent;
    import flash.events.ErrorEvent;

    public class FileProxy implements IFileProxy
    {

        private static const LOCAL_FILE_PATH:String = "local_include/";
        private static const CACHE_PATH:String = "com.sulake.habbo/";
        private static const SWAP_FILE_PATH:String = "com.sulake.habbo/swap/swap_";

        private static var _SafeStr_417:int = 0;

        private var _SafeStr_416:Dictionary;


        private static function resolveFileFromLocalPath(_arg_1:String):String
        {
            return (null);
        }


        public function dispose():void
        {
            _SafeStr_416 = null;
        }

        public function clearCache():void
        {
            deleteCacheDirectory("");
        }

        public function localFilePath(_arg_1:String):String
        {
            return null;
        }

        public function cacheFilePath(_arg_1:String):String
        {
            return null;
        }

        public function loadLocalBitmapData(_arg_1:String, _arg_2:Function):void
        {
        }

        public function cacheFileExists(_arg_1:String):Boolean
        {
            return (false);
        }

        public function localFileExists(_arg_1:String):Boolean
        {
            return (false);
        }

        public function readCache(_arg_1:String):ByteArray
        {
            return null;
        }

        public function readCacheAsync(_arg_1:String, _arg_2:Function):void
        {
            _arg_2(null);
        }

        public function writeCache(_arg_1:String, _arg_2:ByteArray, _arg_3:Boolean=false):void
        {

        }

        public function deleteCacheDirectory(_arg_1:String):void
        {
        }

        private function onLocalFileComplete(_arg_1:Event):void
        {
        }

        private function onLocalFileError(_arg_1:Event):void
        {
        }

        private function addCallback(_arg_1:String, _arg_2:Function):void
        {
        }

        private function doCallbacks(_arg_1:String, _arg_2:BitmapData):void
        {
        }

        public function swapObjectToDisk(_arg_1:Object):int
        {
            return (-1);
        }

        public function swapObjectFromDisk(_arg_1:int):Object
        {
            return null;
        }


    }
}
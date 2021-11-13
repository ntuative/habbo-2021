package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.Core;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.utils.ByteArray;
    import flash.events.Event;

    public class EffectAssetDownloadLibrary extends EventDispatcherWrapper implements INamed 
    {

        private static var STATE_IDLE:int = 0;
        private static var STATE_DOWNLOADING:int = 1;
        private static var STATE_READY:int = 2;

        private var _SafeStr_448:int;
        private var _name:String;
        private var _revision:String;
        private var _downloadUrl:String;
        private var _assets:IAssetLibrary;
        private var _animation:XML;

        public function EffectAssetDownloadLibrary(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:IAssetLibrary, _arg_5:String)
        {
            _SafeStr_448 = STATE_IDLE;
            _assets = _arg_4;
            _name = _arg_1;
            _revision = _arg_2;
            _downloadUrl = (_arg_3 + _arg_5);
            _downloadUrl = _downloadUrl.replace("%libname%", _name);
            _downloadUrl = _downloadUrl.replace("%revision%", _revision);
            var _local_6:AssetLibraryCollection = (_assets as AssetLibraryCollection);
            var _local_7:IAssetLibrary = _local_6.getAssetLibraryByUrl((_name + ".swf"));
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
            _local_2.load(_local_1);
        }

        private function onLoaderError(_arg_1:LibraryLoaderEvent):void
        {
            Core.error(((((((((("Could not load effect asset library " + _name) + " from URL ") + _downloadUrl) + " HTTP status ") + _arg_1.status) + " bytes loaded ") + _arg_1.bytesLoaded) + "/") + _arg_1.bytesTotal), false, 2);
        }

        private function onLoaderComplete(_arg_1:Event):void
        {
            var _local_5:ByteArray;
            var _local_3:ByteArray;
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            _local_2.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", onLoaderComplete);
            _local_2.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", onLoaderError);
            var _local_4:Object = (_local_2.resource as Object).animation;
            if ((_local_4 is XML))
            {
                _animation = (_local_4 as XML);
            }
            else
            {
                if ((_local_4 is Class))
                {
                    var _local_5_cls:Class = _local_4 as Class;
                    _local_5 = new _local_5_cls() as ByteArray;
                    _animation = new XML(_local_5.readUTFBytes(_local_5.length));
                }
                else
                {
                    if ((_local_4 is ByteArray))
                    {
                        _local_3 = (_local_4 as ByteArray);
                        _animation = new XML(_local_3.readUTFBytes(_local_3.length));
                    };
                };
            };
            _SafeStr_448 = STATE_READY;
            dispatchEvent(new Event("complete"));
        }

        public function get name():String
        {
            return (_name);
        }

        public function get isReady():Boolean
        {
            return (_SafeStr_448 == STATE_READY);
        }

        public function toString():String
        {
            var _local_1:String = _name;
            return (_local_1 + ((isReady) ? "[x]" : "[ ]"));
        }

        public function get animation():XML
        {
            return (_animation);
        }


    }
}


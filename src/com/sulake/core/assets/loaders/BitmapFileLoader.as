package com.sulake.core.assets.loaders
{
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.PNGEncoderOptions;
    import flash.system.Security;
    import flash.events.TimerEvent;

    public class BitmapFileLoader extends _SafeStr_16 implements IAssetLoader
    {

        protected var _SafeStr_780:String;
        protected var _SafeStr_741:String;
        protected var _SafeStr_779:Loader;
        protected var _SafeStr_781:LoaderContext;
        private var _cacheKey:String = null;
        private var _cacheRevision:String = null;
        private var _fromCache:Boolean = false;
        private var _id:int = -1;
        private var _SafeStr_782:Timer;
        private var _SafeStr_783:Event;

        public function BitmapFileLoader(_arg_1:String, _arg_2:URLRequest=null, _arg_3:String=null, _arg_4:String=null, _arg_5:ByteArray=null, _arg_6:int=-1)
        {
            _SafeStr_780 = ((_arg_2 == null) ? "" : _arg_2.url);
            _SafeStr_741 = _arg_1;
            _SafeStr_779 = new Loader();
            _SafeStr_781 = new LoaderContext();
            _SafeStr_781.checkPolicyFile = true;
            _SafeStr_779.contentLoaderInfo.addEventListener("complete", completeEventHandler);
            _SafeStr_779.contentLoaderInfo.addEventListener("unload", loadEventHandler);
            _SafeStr_779.contentLoaderInfo.addEventListener("httpStatus", loadEventHandler);
            _SafeStr_779.contentLoaderInfo.addEventListener("progress", loadEventHandler);
            _SafeStr_779.contentLoaderInfo.addEventListener("ioError", loadEventHandler);
            _SafeStr_779.contentLoaderInfo.addEventListener("securityError", loadEventHandler);
            _cacheKey = _arg_3;
            _cacheRevision = _arg_4;
            _id = _arg_6;
            if (((!(_arg_5 == null)) && (_arg_5.length > 0)))
            {
                _fromCache = true;
                _SafeStr_779.loadBytes(_arg_5);
            }
            else
            {
                if (((!(_arg_2 == null)) && (!(_arg_2.url == null))))
                {
                    _SafeStr_779.load(_arg_2, _SafeStr_781);
                };
            };
        }

        public function get url():String
        {
            return (_SafeStr_780);
        }

        public function get content():Object
        {
            return ((_SafeStr_779) ? _SafeStr_779.content : null);
        }

        public function get bytes():ByteArray
        {
            var _local_2:Bitmap = (content as Bitmap);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_1:BitmapData = _local_2.bitmapData;
            return (_local_1.encode(_local_1.rect, new PNGEncoderOptions()));
        }

        public function get mimeType():String
        {
            return (_SafeStr_741);
        }

        public function get bytesLoaded():uint
        {
            return ((_SafeStr_779) ? _SafeStr_779.contentLoaderInfo.bytesLoaded : 0);
        }

        public function get bytesTotal():uint
        {
            return ((_SafeStr_779) ? _SafeStr_779.contentLoaderInfo.bytesTotal : 0);
        }

        public function get loaderContext():LoaderContext
        {
            return (_SafeStr_781);
        }

        public function get cacheKey():String
        {
            return (_cacheKey);
        }

        public function get cacheRevision():String
        {
            return (_cacheRevision);
        }

        public function get fromCache():Boolean
        {
            return (_fromCache);
        }

        public function get id():int
        {
            return (_id);
        }

        public function load(_arg_1:URLRequest):void
        {
            _SafeStr_780 = _arg_1.url;
            _SafeStr_777 = 0;
            _SafeStr_779.load(_arg_1, _SafeStr_781);
        }

        override protected function retry():Boolean
        {
            if (!_disposed)
            {
                if (++_SafeStr_777 <= _SafeStr_778)
                {
                    try
                    {
                        _SafeStr_779.close();
                        _SafeStr_779.unload();
                    }
                    catch(e:Error)
                    {
                    };
                    _SafeStr_779.load(new URLRequest((((_SafeStr_780 + ((_SafeStr_780.indexOf("?") == -1) ? "?" : "&")) + "retry=") + _SafeStr_777)), _SafeStr_781);
                    return (true);
                };
            };
            return (false);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                super.dispose();
                _SafeStr_779.contentLoaderInfo.removeEventListener("complete", completeEventHandler);
                _SafeStr_779.contentLoaderInfo.removeEventListener("unload", loadEventHandler);
                _SafeStr_779.contentLoaderInfo.removeEventListener("httpStatus", loadEventHandler);
                _SafeStr_779.contentLoaderInfo.removeEventListener("progress", loadEventHandler);
                _SafeStr_779.contentLoaderInfo.removeEventListener("ioError", loadEventHandler);
                _SafeStr_779.contentLoaderInfo.removeEventListener("securityError", loadEventHandler);
                if (_SafeStr_782)
                {
                    _SafeStr_782.stop();
                    _SafeStr_782.removeEventListener("timerComplete", securityPollTimerEvent);
                    _SafeStr_782 = null;
                };
                try
                {
                    _SafeStr_779.close();
                }
                catch(e:Error)
                {
                };
                _SafeStr_779.unload();
                _SafeStr_779 = null;
                _SafeStr_741 = null;
                _SafeStr_780 = null;
            };
        }

        private function completeEventHandler(_arg_1:Event):void
        {
            if (_SafeStr_780 == _SafeStr_779.contentLoaderInfo.url)
            {
                loadEventHandler(_arg_1);
                return;
            };
            _SafeStr_783 = _arg_1;
            var _local_3:int = _SafeStr_779.contentLoaderInfo.url.indexOf("//");
            var _local_2:String = (_SafeStr_779.contentLoaderInfo.url.slice(0, (_SafeStr_779.contentLoaderInfo.url.indexOf("/", (_local_3 + 3)) + 1)) + "crossdomain.xml");
            Security.loadPolicyFile(_local_2);
            startSecurityPolling();
        }

        private function securityPollTimerEvent(_arg_1:TimerEvent):void
        {
            if (_SafeStr_779.contentLoaderInfo.childAllowsParent)
            {
                loadEventHandler(_SafeStr_783);
            }
            else
            {
                startSecurityPolling();
            };
        }

        private function startSecurityPolling():void
        {
            _SafeStr_782 = new Timer(250, 1);
            _SafeStr_782.addEventListener("timerComplete", securityPollTimerEvent);
            _SafeStr_782.start();
        }


    }
}
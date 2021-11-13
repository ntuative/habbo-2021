package com.sulake.core.utils
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.runtime.IDisposable;
    import flash.net.URLLoader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import com.sulake.core.Core;
    import com.codeazur.as3swf.tags.TagDefineBinaryData;
    import com.codeazur.as3swf.tags.TagDefineBitsLossless2;
    import com.codeazur.as3swf.SWF;
    import flash.utils.Dictionary;
    import com.codeazur.as3swf.tags.ITag;
    import com.codeazur.as3swf.tags.TagSymbolClass;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFSymbol;
    import flash.utils.getTimer;
    import flash.display.DisplayObject;
    import flash.system.System;
    import flash.events.Event;
    import flash.utils.Timer;
    import flash.events.HTTPStatusEvent;
    import flash.events.TimerEvent;
    import flash.display.MovieClip;
    import flash.display.FrameLabel;

        public class LibraryLoader extends EventDispatcherWrapper implements IDisposable
    {

        protected static const STATE_EVENT_COMPLETE:uint = 1;
        protected static const STATE_EVENT_INIT:uint = 2;
        protected static const STATE_ANALYZE:uint = 3;
        protected static const STATE_EVENT_FRAME:uint = 4;
        protected static const STATE_EVENT_OPEN:uint = 2;
        protected static const STATE_READY:uint = 7;
        public static const DEFAULT_MAX_RETRIES:int = 5;
        public static const LIBRARY_LOADER_FINALIZE:String = "LIBRARY_LOADER_FINALIZE";
        private static const CACHE_FILE_NAME:String = "asset.swf";
        public static const USE_DOWNLOAD_THROTTLING:Boolean = true;
        public static const MAX_SIMULTANEOUS_DOWNLOADS:int = 6;

        private static var _SafeStr_870:Array = [];
        private static var _SafeStr_871:Array = [];

        protected var _SafeStr_869:URLLoader;
        protected var _context:LoaderContext;
        protected var _status:int = 0;
        protected var _SafeStr_872:URLRequest;
        protected var _manifest:XML;
        protected var _SafeStr_787:Class;
        protected var _process:uint = 0;
        protected var _name:String;
        protected var _SafeStr_873:Boolean = false;
        protected var _SafeStr_845:Boolean = false;
        protected var _paused:Boolean = false;
        protected var _errorMsg:String = "";
        protected var _debugMsg:String = "";
        protected var _cachedBytes:ByteArray;
        protected var _downloadStartTime:int;
        protected var _downloadEndTime:int;
        protected var _downloadRetriesLeft:int;
        protected var _SafeStr_874:uint = 0;
        protected var _cacheKey:String;
        protected var _cacheRevision:String;

        public function LibraryLoader(_arg_1:LoaderContext=null, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            if (_arg_1 == null)
            {
                _context = new LoaderContext();
                _context.applicationDomain = ApplicationDomain.currentDomain;
            }
            else
            {
                _context = _arg_1;
            };
            _paused = _arg_2;
            _SafeStr_845 = _arg_3;
            _status = 0;
            _SafeStr_869 = new URLLoader();
            _SafeStr_869.dataFormat = "binary";
            _SafeStr_869.addEventListener("open", loadEventHandler);
            _SafeStr_869.addEventListener("complete", loadEventHandler);
            _SafeStr_869.addEventListener("progress", loadEventHandler);
            _SafeStr_869.addEventListener("unload", loadEventHandler);
            _SafeStr_869.addEventListener("httpStatus", loadEventHandler);
            _SafeStr_869.addEventListener("ioError", loadEventHandler);
            _SafeStr_869.addEventListener("securityError", loadEventHandler);
        }

        private static function get fileProxy():IFileProxy
        {
            return (Core.instance.fileProxy);
        }

        public static function makeSWF(_arg_1:String, _arg_2:ByteArray, _arg_3:Class):ByteArray
        {
            var _local_6:int;
            var _local_8:TagDefineBinaryData;
            var _local_10:TagDefineBitsLossless2;
            var _local_5:SWF = new SWF();
            _local_5.loadBytes(_arg_2);
            var _local_11:Dictionary = getSymbolClassList(_local_5, _arg_1);
            var _local_12:Dictionary = getBinaryBlobs(_local_5);
            var _local_4:Dictionary = getLosslessImageBlobs(_local_5);
            _local_5.dispose();
            for (var _local_9:String in _local_11)
            {
                _local_6 = _local_11[_local_9];
                _local_8 = _local_12[_local_6];
                _local_10 = _local_4[_local_6];
                if (_local_8)
                {
                    _arg_3[_local_9] = _local_8.binaryData;
                }
                else
                {
                    if (_local_10)
                    {
                        _arg_3[_local_9] = _local_10;
                    };
                };
            };
            var _local_7:ByteArray = _arg_3["manifest"];
            if (((_local_7 == null) || (_local_7.length == 0)))
            {
                _local_7 = _arg_3[(_arg_1 + "_manifest")];
            };
            if (((_local_7 == null) || (_local_7.length == 0)))
            {
            };
            return (_local_7);
        }

        private static function getSymbolClassList(_arg_1:SWF, _arg_2:String):Dictionary
        {
            var _local_7:int;
            var _local_15:ITag;
            var _local_9:TagSymbolClass;
            var _local_10:Vector.<SWFSymbol> = undefined;
            var _local_13:int;
            var _local_8:int;
            var _local_4:SWFSymbol;
            var _local_14:String;
            var _local_3:Dictionary = new Dictionary();
            var _local_6:String = (_arg_2 + "_");
            var _local_11:String = "";
            var _local_12:Vector.<ITag> = _arg_1.tags;
            var _local_5:int = _local_12.length;
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                _local_15 = _local_12[_local_7];
                _local_9 = (_local_15 as TagSymbolClass);
                if (_local_9)
                {
                    _local_10 = _local_9.symbols;
                    _local_13 = _local_10.length;
                    _local_8 = 0;
                    while (_local_8 < _local_13)
                    {
                        _local_4 = _local_10[_local_8];
                        _local_14 = _local_4.name.replace(_local_6, _local_11);
                        if (_local_3[_local_14] != null)
                        {
                            Logger.log(((("Warning, downloaded swf (" + _arg_2) + ") contains duplicate symbol: ") + _local_14));
                        };
                        _local_3[_local_14] = _local_4._SafeStr_266;
                        _local_8++;
                    };
                    return (_local_3);
                };
                _local_7++;
            };
            return (_local_3);
        }

        private static function getBinaryBlobs(_arg_1:SWF):Dictionary
        {
            var _local_3:TagDefineBinaryData;
            var _local_5:int;
            var _local_6:ITag;
            var _local_2:Dictionary = new Dictionary();
            var _local_7:Vector.<ITag> = _arg_1.tags;
            var _local_4:int = _local_7.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = _local_7[_local_5];
                _local_3 = (_local_6 as TagDefineBinaryData);
                if (_local_3)
                {
                    _local_2[_local_3.characterId] = _local_3;
                };
                _local_5++;
            };
            return (_local_2);
        }

        private static function getLosslessImageBlobs(_arg_1:SWF):Dictionary
        {
            var _local_3:TagDefineBitsLossless2;
            var _local_5:int;
            var _local_6:ITag;
            var _local_2:Dictionary = new Dictionary();
            var _local_7:Vector.<ITag> = _arg_1.tags;
            var _local_4:int = _local_7.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = _local_7[_local_5];
                _local_3 = (_local_6 as TagDefineBitsLossless2);
                if (_local_3)
                {
                    _local_2[_local_3.characterId] = _local_3;
                };
                _local_5++;
            };
            return (_local_2);
        }

        protected static function addRequestCounterToUrlRequest(_arg_1:URLRequest, _arg_2:int):void
        {
            var _local_3:int;
            var _local_6:String;
            if (((_arg_1.url == null) || (_arg_1.url == "")))
            {
                return;
            };
            var _local_4:Array = _arg_1.url.split("?");
            var _local_5:String = _local_4[0];
            var _local_9:String = ((_local_4.length > 1) ? _local_4[1] : "");
            var _local_7:String = "counterparameter";
            var _local_10:Array = _local_9.split("&");
            var _local_8:Boolean;
            _local_3 = 0;
            while (_local_3 < _local_10.length)
            {
                _local_6 = _local_10[_local_3];
                if (_local_6.indexOf((_local_7 + "=")) >= 0)
                {
                    _local_6 = ((_local_7 + "=") + _arg_2.toString());
                    _local_10[_local_3] = _local_6;
                    _local_8 = true;
                    break;
                };
                _local_3++;
            };
            if (!_local_8)
            {
                _local_10.push(((_local_7 + "=") + _arg_2));
            };
            _local_3 = 0;
            while (_local_3 < _local_10.length)
            {
                _local_5 = (_local_5 + (((_local_3 == 0) ? "?" : "&") + _local_10[_local_3]));
                _local_3++;
            };
            _arg_1.url = _local_5;
        }

        protected static function parseNameFromUrl(_arg_1:String):String
        {
            var _local_2:int;
            _local_2 = _arg_1.indexOf("?", 0);
            if (_local_2 > -1)
            {
                _arg_1 = _arg_1.slice(0, _local_2);
            };
            _local_2 = _arg_1.lastIndexOf(".");
            if (_local_2 > -1)
            {
                _arg_1 = _arg_1.slice(0, _local_2);
            };
            _local_2 = _arg_1.lastIndexOf("/");
            if (_local_2 > -1)
            {
                _arg_1 = _arg_1.slice((_local_2 + 1), _arg_1.length);
            };
            return (_arg_1);
        }

        protected static function queue(_arg_1:LibraryLoader):void
        {
            if (_SafeStr_870.indexOf(_arg_1) == -1)
            {
                _SafeStr_870.push(_arg_1);
            };
            throttle();
        }

        protected static function throttle():void
        {
            var _local_1:LibraryLoader;
            var _local_2:int;
            _local_2 = (_SafeStr_871.length - 1);
            while (_local_2 > -1)
            {
                _local_1 = (_SafeStr_871[_local_2] as LibraryLoader);
                if (((_local_1) && ((_local_1.ready) || (_local_1.disposed))))
                {
                    _SafeStr_871.splice(_local_2, 1);
                };
                _local_2--;
            };
            while (((_SafeStr_871.length < 6) && (_SafeStr_870.length > 0)))
            {
                _local_1 = (_SafeStr_870.shift() as LibraryLoader);
                if (((!(_local_1.ready)) && (!(_local_1.disposed))))
                {
                    _SafeStr_871.push(_local_1);
                    _local_1._SafeStr_869.load(_local_1._SafeStr_872);
                };
            };
        }


        public function get url():String
        {
            return ((_SafeStr_872) ? _SafeStr_872.url : null);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get ready():Boolean
        {
            return (_SafeStr_873);
        }

        public function get status():int
        {
            return (_status);
        }

        public function get domain():ApplicationDomain
        {
            return (_context.applicationDomain);
        }

        public function get request():URLRequest
        {
            return (_SafeStr_872);
        }

        public function get resource():Class
        {
            return (_SafeStr_787);
        }

        public function get manifest():XML
        {
            return (_manifest);
        }

        public function get bytesTotal():uint
        {
            return (_SafeStr_869.bytesTotal);
        }

        public function get bytesLoaded():uint
        {
            return (_SafeStr_869.bytesLoaded);
        }

        public function get elapsedTime():uint
        {
            return ((_SafeStr_873) ? (_downloadEndTime - _downloadStartTime) : (getTimer() - _downloadStartTime));
        }

        public function get paused():Boolean
        {
            return (_paused);
        }

        protected function get content():DisplayObject
        {
            if (Resources.get(_name))
            {
                return (Resources.get(_name) as DisplayObject);
            };
            return (null);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_DISPOSE", _status, bytesTotal, bytesLoaded, elapsedTime));
                try
                {
                    _SafeStr_869.close();
                }
                catch(e:Error)
                {
                };
                if (((_SafeStr_869) && (_SafeStr_869.data is ByteArray)))
                {
                    (_SafeStr_869.data as ByteArray).clear();
                };
                _SafeStr_869 = null;
                _context = null;
                _SafeStr_787 = null;
                System.disposeXML(_manifest);
                _manifest = null;
                if (_cachedBytes)
                {
                    _cachedBytes.clear();
                    _cachedBytes = null;
                };
                super.dispose();
            };
        }

        public function load(_arg_1:URLRequest, _arg_2:String=null, _arg_3:String=null, _arg_4:int=5):void
        {
            var request:URLRequest = _arg_1;
            var cacheKey:String = _arg_2;
            var cacheRevision:String = _arg_3;
            var maxRetryCount:int = _arg_4;
            _SafeStr_872 = request;
            _name = parseNameFromUrl(_SafeStr_872.url);
            _SafeStr_873 = false;
            _downloadRetriesLeft = maxRetryCount;
            _cacheKey = cacheKey;
            _cacheRevision = cacheRevision;
            if (((((fileProxy) && (cacheKey)) && (cacheRevision)) && (!(cacheRevision == "-1"))))
            {
                var path:String = getCacheFilePath();
                ErrorReportStorage.addDebugData("Library cached", ("Library cached " + fileProxy.cacheFileExists(path)));
                fileProxy.readCacheAsync(path, function (_arg_1:ByteArray):void
                {
                    if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
                    {
                        _cachedBytes = _arg_1;
                        _process = 7;
                        loadEventHandler(new Event("complete"));
                        return;
                    };
                    if (_cachedBytes)
                    {
                        _cachedBytes.clear();
                        _cachedBytes = null;
                    };
                    if (!_paused)
                    {
                        _paused = true;
                        resume();
                    };
                });
                return;
            };
            ErrorReportStorage.addDebugData("Library url", ("Library url " + request.url));
            ErrorReportStorage.addDebugData("Library name", ("Library name " + _name));
            if (!_paused)
            {
                _paused = true;
                resume();
            };
        }

        private function getCacheFilePath():String
        {
            return ((((_cacheKey + "/") + _cacheRevision) + "/") + "asset.swf");
        }

        private function getCacheDirectoryPath():String
        {
            return (_cacheKey + "/");
        }

        public function resume():void
        {
            var _local_1:Timer;
            if (((_paused) && (!(_disposed))))
            {
                _paused = false;
                if (((!(_SafeStr_873)) && (_SafeStr_872)))
                {
                    _downloadEndTime = -1;
                    _downloadStartTime = getTimer();
                    if (hasDefinition(_name))
                    {
                        Logger.log(("[LibraryLoader] Found in AIR: " + _name));
                        _local_1 = new Timer(10, 1);
                        _local_1.addEventListener("timer", loadEventHandler);
                        _local_1.start();
                        return;
                    };
                    queue(this);
                };
            };
        }

        protected function retry():Boolean
        {
            if ((((!(_SafeStr_873)) && (!(_disposed))) && (_downloadRetriesLeft > 0)))
            {
                try
                {
                    _SafeStr_869.close();
                }
                catch(e:Error)
                {
                };
                addRequestCounterToUrlRequest(_SafeStr_872, (5 - _downloadRetriesLeft));
                _downloadRetriesLeft--;
                _process = 0;
                _SafeStr_869.load(_SafeStr_872);
                return (true);
            };
            return (false);
        }

        public function hasDefinition(_arg_1:String):Boolean
        {
            if (Resources.get(_arg_1))
            {
                Logger.log(("[LibraryLoader] Definition in resources: " + _arg_1));
                return (true);
            };
            var _local_2:Boolean;
            try
            {
            }
            catch(e:Error)
            {
            };
            return (_local_2);
        }

        public function getDefinition(_arg_1:String):Object
        {
            if (Resources.get(_arg_1))
            {
                return (Resources.get(_arg_1));
            };
            var _local_2:Object;
            try
            {
                _local_2 = _SafeStr_787[_arg_1];
            }
            catch(e:Error)
            {
            };
            return (_local_2);
        }

        protected function loadEventHandler(_arg_1:Event):void
        {
            var _local_3:Timer;
            var _local_2:Boolean;
            switch (_arg_1.type)
            {
                case "init":
                    debug((('Load event INIT for file "' + url) + '"'));
                    _process = (_process | 0x02);
                    break;
                case "open":
                    _process = (_process | 0x02);
                    debug((('Load event OPEN for file "' + url) + '"'));
                    break;
                case "complete":
                    debug((('Load event COMPLETE for file "' + url) + '"'));
                    if (((((!(_cachedBytes)) && (_cacheKey)) && (_cacheRevision)) && (!(_cacheRevision == "-1"))))
                    {
                        addToCache();
                    };
                    _process = (_process | 0x01);
                    break;
                case "enterFrame":
                    break;
                case "httpStatus":
                    _status = HTTPStatusEvent(_arg_1).status;
                    debug((((("Load event STATUS " + _status) + ' for file "') + url) + '"'));
                    break;
                case "unload":
                    debug((('Load event UNLOAD for file "' + url) + '"'));
                    dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_UNLOAD", _status, bytesTotal, bytesLoaded, elapsedTime));
                    break;
                case "progress":
                    debug(((((('Load event PROGRESS for file "' + url) + '"  bytes: ') + bytesLoaded) + "/") + bytesTotal));
                    dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_PROGRESS", _status, bytesTotal, bytesLoaded, elapsedTime));
                    break;
                case "ioError":
                    debug((('Load event IO ERROR for file "' + url) + '"'));
                    if (!handleHttpStatus(_status))
                    {
                        _downloadEndTime = getTimer();
                        failure((('IO Error, send or load operation failed for file "' + url) + '"'));
                        removeEventListeners();
                    };
                    break;
                case "securityError":
                    _downloadEndTime = getTimer();
                    failure((('Security Error, security violation with file "' + url) + '"'));
                    removeEventListeners();
                    break;
                case "timer":
                    _local_3 = (TimerEvent(_arg_1).target as Timer);
                    _local_3.removeEventListener("timer", loadEventHandler);
                    _local_3.stop();
                    if (!_disposed)
                    {
                        _process = 7;
                        loadEventHandler(new Event("complete"));
                    };
                    return;
                default:
            };
            if (_process == 3)
            {
                if (analyzeLibrary())
                {
                    _process = (_process | 0x04);
                };
            };
            if (_process == 7)
            {
                _local_2 = prepareLibrary();
                if (_local_2)
                {
                    _SafeStr_873 = true;
                    _downloadEndTime = getTimer();
                    removeEventListeners();
                    throttle();
                    dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_COMPLETE", _status, bytesTotal, bytesLoaded, elapsedTime));
                    dispatchEvent(new Event("LIBRARY_LOADER_FINALIZE"));
                };
            };
        }

        private function addToCache():void
        {
            var _local_2:ByteArray;
            var _local_3:String;
            var _local_1:String;
            if (((fileProxy) && (_SafeStr_869)))
            {
                _local_2 = (_SafeStr_869.data as ByteArray);
                if (((!(_local_2)) || (_local_2.length == 0)))
                {
                    return;
                };
                _local_3 = getCacheDirectoryPath();
                fileProxy.deleteCacheDirectory(_local_3);
                _local_1 = getCacheFilePath();
                fileProxy.writeCache(_local_1, _SafeStr_869.data);
            };
        }

        protected function analyzeLibrary():Boolean
        {
            var _local_1:MovieClip;
            var _local_3:FrameLabel;
            var _local_4:Array;
            var _local_2:uint;
            debug((((('Analyzing library "' + _name) + '", content ') + ((content is MovieClip) ? "is" : "is not")) + " a MovieClip"));
            if ((content is MovieClip))
            {
                _local_1 = (content as MovieClip);
                _local_4 = _local_1.currentLabels;
                debug((((((('\tLibrary "' + _name) + '" is in frame ') + _local_1.currentFrame) + "(") + _local_1.currentLabel) + ")"));
                if (_local_4.length > 1)
                {
                    _local_2 = 0;
                    while (_local_2 < _local_4.length)
                    {
                        _local_3 = (_local_4[_local_2] as FrameLabel);
                        if (_local_3.name == _name)
                        {
                            if (_local_3.frame != _local_1.currentFrame)
                            {
                                _local_1.addEventListener("enterFrame", loadEventHandler);
                                return (false);
                            };
                        };
                        _local_2++;
                    };
                };
            };
            return (true);
        }

                protected function prepareLibrary():Boolean
        {
            var _local_1:Boolean;
            var _local_6:ByteArray;
            var _local_2:String;
            var _local_4:ByteArray;
            var _local_3:Class;
            if (disposed)
            {
                return (false);
            };
            var _local_7:Boolean = true;
            if (Resources.get(_name))
            {
                _local_7 = false;
            };
            if (_local_7)
            {
                _local_2 = parseNameFromUrl(_SafeStr_872.url);
                _SafeStr_787 = Class;
                if (((_cachedBytes) && (_cachedBytes.length > 0)))
                {
                    try
                    {
                        _local_6 = makeSWF(_local_2, _cachedBytes, _SafeStr_787);
                        _cachedBytes.clear();
                        _cachedBytes = null;
                    }
                    catch(e:Error)
                    {
                        fileProxy.deleteCacheDirectory(getCacheDirectoryPath());
                        _cachedBytes.clear();
                        _cachedBytes = null;
                        if (!retry())
                        {
                            failure((((('Failed to load resource "' + _name) + '" from library ') + _SafeStr_872.url) + "!"));
                        };
                    };
                    if (!_local_6)
                    {
                        return (false);
                    };
                }
                else
                {
                    _local_4 = _SafeStr_869.data;
                    if (((_local_4) && (_local_4.length > 0)))
                    {
                        var _local_10:int = 0;
                        try
                        {
                            _local_6 = makeSWF(_local_2, _local_4, _SafeStr_787);
                        }
                        catch(e:Error)
                        {
                            if (!retry())
                            {
                                failure((((('Failed to load resource "' + _name) + '" from library ') + _SafeStr_872.url) + "!"));
                            };
                        }
                        finally
                        {
                            _local_4.clear();
                        };
                    };
                };
                _local_1 = ((!(_local_6 == null)) && (_local_6.length > 0));
            }
            else
            {
                _SafeStr_787 = (this.getDefinition(_name) as Class);
                if (_SafeStr_787 == null)
                {
                    if (!retry())
                    {
                        failure((((('Failed to find resource class "' + _name) + '" from library ') + _SafeStr_872.url) + "!"));
                    };
                    return (false);
                };
                _local_1 = true;
                try
                {
                    _local_3 = (_SafeStr_787.manifest as Class);
                    if (_local_3 == null)
                    {
                        var _local_13:Boolean = false;
                        return (_local_13);
                    };
                }
                catch(e:Error)
                {
                    if (!retry())
                    {
                        failure((("Failed to find embedded manifest.xml from library " + _SafeStr_872.url) + "!"));
                    };
                    _local_1 = false;
                };
                if (!_local_1)
                {
                    return (false);
                };
                _local_6 = (new _local_3() as ByteArray);
            };
            var _local_5:String = "";
            if (_local_1)
            {
                try
                {
                    _manifest = new XML(_local_6.readUTFBytes(_local_6.length));
                }
                catch(e:Error)
                {
                    _local_5 = e.message;
                    _local_1 = false;
                };
            };
            if (((!(_local_1)) && (!(retry()))))
            {
                failure(((((("Failed to extract manifest.xml from library " + _name) + " swf: ") + _local_2) + "!") + _local_5));
            };
            _local_6.clear();
            return (_local_1);
        }

        protected function handleHttpStatus(_arg_1:int):Boolean
        {
            if (((_arg_1 == 0) || (_arg_1 >= 400)))
            {
                if (retry())
                {
                    return (true);
                };
                failure((((("HTTP Error " + _arg_1) + ' "') + _SafeStr_869) + '"'));
                removeEventListeners();
            };
            return (false);
        }

        protected function removeEventListeners():void
        {
            if (_SafeStr_869)
            {
                _SafeStr_869.removeEventListener("open", loadEventHandler);
                _SafeStr_869.removeEventListener("complete", loadEventHandler);
                _SafeStr_869.removeEventListener("progress", loadEventHandler);
                _SafeStr_869.removeEventListener("unload", loadEventHandler);
                _SafeStr_869.removeEventListener("httpStatus", loadEventHandler);
                _SafeStr_869.removeEventListener("ioError", loadEventHandler);
                _SafeStr_869.removeEventListener("securityError", loadEventHandler);
            };
        }

        protected function debug(_arg_1:String):void
        {
            Core.debug(_arg_1);
            _debugMsg = _arg_1;
            if (_SafeStr_845)
            {
                dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_DEBUG", _status, bytesTotal, bytesLoaded, elapsedTime));
            };
        }

        protected function failure(_arg_1:String):void
        {
            Core.warning(_arg_1);
            _errorMsg = _arg_1;
            throttle();
            dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_ERROR", _status, bytesTotal, bytesLoaded, elapsedTime));
            dispatchEvent(new Event("LIBRARY_LOADER_FINALIZE"));
        }

        public function getLastDebugMessage():String
        {
            return (_debugMsg);
        }

        public function getLastErrorMessage():String
        {
            return (_errorMsg);
        }


    }
}
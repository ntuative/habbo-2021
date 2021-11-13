package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.assets.loaders.BinaryFileLoader;
    import com.sulake.core.assets.loaders.BitmapFileLoader;
    import com.sulake.core.assets.loaders.ZipFileLoader;
    import com.sulake.core.assets.loaders.TextFileLoader;
    import com.sulake.core.assets.loaders.SoundFileLoader;
    import com.sulake.core.Core;
    import com.sulake.core.utils.IFileProxy;
    import flash.utils.ByteArray;
    import deng.fzip.FZipFile;
    import deng.fzip.FZip;
    import flash.system.System;
    import flash.events.Event;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import flash.net.URLRequest;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.events.ProgressEvent;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.assets.loaders.*;

    public class AssetLibrary extends EventDispatcherWrapper implements IAssetLibrary 
    {

        public static const ASSET_LIBRARY_READY:String = "AssetLibraryReady";
        public static const ASSET_LIBRARY_LOADED:String = "AssetLibraryLoaded";
        public static const ASSET_LIBRARY_UNLOADED:String = "AssetLibraryUnloaded";
        public static const ASSET_LIBRARY_LOAD_ERROR:String = "AssetLibraryLoadError";
        private static const NAME:String = "name";
        private static const ASSET:String = "asset";
        private static const PARAM:String = "param";
        private static const TYPE:String = "mimeType";
        private static const LIB:String = "library";
        private static const REF:String = "ref";
        private static const USE_LAZY_ASSET_PROCESSOR:Boolean = false;

        private static var _sharedListOfTypesByMime:Dictionary;
        private static var _SafeStr_786:LazyAssetProcessor = new LazyAssetProcessor();
        private static var _numAssetLibraryInstances:uint = 0;
        private static var _assetLibraryRefArray:Array = [];

        private var _name:String;
        private var _url:String;
        private var _manifest:XML;
        private var _isReady:Boolean;
        private var _numAssets:uint;
        private var _SafeStr_779:LibraryLoader;
        private var _SafeStr_787:Class;
        private var _SafeStr_788:Dictionary;
        private var _SafeStr_789:Dictionary;
        private var _SafeStr_790:Boolean = true;
        private var _SafeStr_791:Dictionary;
        private var _nameArray:Array;
        private var _localListOfTypesByMime:Dictionary;

        public function AssetLibrary(_arg_1:String, _arg_2:XML=null)
        {
            _name = _arg_1;
            _manifest = _arg_2;
            _numAssets = 0;
            _nameArray = [];
            if (_sharedListOfTypesByMime == null)
            {
                _sharedListOfTypesByMime = new Dictionary(false);
                registerAssetTypeDeclaration(new AssetTypeDeclaration("application/octet-stream", UnknownAsset, BinaryFileLoader));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-shockwave-flash", DisplayAsset, BitmapFileLoader, "swf"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-font-truetype", TypeFaceAsset, BinaryFileLoader, "ttf", "otf"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("application/zip", UnknownAsset, ZipFileLoader, "zip"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("text/xml", XmlAsset, TextFileLoader, "xml"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("text/html", XmlAsset, TextFileLoader, "htm", "html"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("text/plain", TextAsset, TextFileLoader, "txt"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("image/jpeg", BitmapDataAsset, BitmapFileLoader, "jpg", "jpeg"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("image/gif", BitmapDataAsset, BitmapFileLoader, "gif"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("image/png", BitmapDataAsset, BitmapFileLoader, "png"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("image/tiff", BitmapDataAsset, BitmapFileLoader, "tif", "tiff"));
                registerAssetTypeDeclaration(new AssetTypeDeclaration("sound/mp3", SoundAsset, SoundFileLoader, "mp3"));
            };
            _numAssetLibraryInstances++;
            _localListOfTypesByMime = new Dictionary(false);
            _SafeStr_791 = new Dictionary(false);
            _SafeStr_788 = new Dictionary(false);
            _SafeStr_789 = new Dictionary(false);
            _assetLibraryRefArray.push(this);
        }

        private static function get fileProxy():IFileProxy
        {
            if (!Core.instance)
            {
                return (null);
            };
            return (Core.instance.fileProxy);
        }

        private static function getCacheFilePath(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            return ((((_arg_1 + "/") + _arg_2) + "/") + _arg_3);
        }

        private static function getCacheDirectoryPath(_arg_1:String):String
        {
            return (_arg_1 + "/");
        }

        public static function get numAssetLibraryInstances():uint
        {
            return (_numAssetLibraryInstances);
        }

        public static function get assetLibraryRefArray():Array
        {
            return (_assetLibraryRefArray);
        }

        public static function cloneBytes(_arg_1:ByteArray):ByteArray
        {
            if (!_arg_1)
            {
                return (null);
            };
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeObject(_arg_1);
            _local_2.position = 0;
            var _local_3:ByteArray = _local_2.readObject();
            _local_2.clear();
            _local_2 = null;
            return (_local_3);
        }

        private static function fetchLibraryContents(_arg_1:AssetLibrary, _arg_2:XML, _arg_3:Class, _arg_4:FZip=null):Boolean
        {
            var _local_5:XML;
            var _local_15:String;
            var _local_10:String;
            var _local_7:AssetTypeDeclaration;
            var _local_17:IAsset;
            var _local_14:XMLList;
            var _local_9:int;
            var _local_16:AssetTypeDeclaration = null;
            var _local_11:XMLList;
            var _local_8:String;
            var _local_12:FZipFile;
            if (((_arg_3 == null) && (_arg_4 == null)))
            {
                throw (new Error((("Library " + _arg_1._url) + " doesn't contain valid resource class!")));
            };
            var _local_6:XMLList = _arg_2.child("library");
            if (_local_6 == null)
            {
                throw (new Error("Provided manifest doesn't contain library node!"));
            };
            var _local_13:String;
            _local_11 = _local_6[0].assets;
            if (_local_11 != null)
            {
                _local_11 = _local_11.child("asset");
                _local_9 = _local_11.length();
                for each (_local_5 in _local_11)
                {
                    _local_15 = _local_5.attribute("name");
                    _local_10 = _local_5.attribute("mimeType");
                    if (_local_10 == _local_13)
                    {
                        _local_7 = _local_16;
                    }
                    else
                    {
                        _local_7 = _arg_1.getAssetTypeDeclarationByMimeType(_local_10);
                        _local_13 = _local_10;
                        _local_16 = _local_7;
                    };
                    if (_local_7 != null)
                    {
                        _local_17 = (new _local_7.assetClass(_local_7) as IAsset);
                        if (((!(_arg_4 == null)) && (_arg_4.getFileCount() > 0)))
                        {
                            _local_8 = ".png";
                            if ((_local_17 is BitmapDataAsset))
                            {
                                _local_8 = ".png";
                            };
                            if ((_local_17 is XmlAsset))
                            {
                                _local_8 = ".xml";
                            };
                            _local_12 = _arg_4.getFileByName((_local_15 + _local_8));
                            if (_local_12)
                            {
                                _local_17.setUnknownContent(_local_12.content);
                            };
                        }
                        else
                        {
                            _local_17.setUnknownContent(_arg_3[_local_15]);
                        };
                        _local_14 = _local_5.child("param");
                        if (_local_14.length())
                        {
                            _local_17.setParamsDesc(_local_14);
                        };
                        _arg_1.setAsset(_local_15, _local_17);
                    };
                };
            };
            _local_11 = _local_6[0].aliases;
            if (_local_11 != null)
            {
                _local_11 = _local_11.child("asset");
                for each (_local_5 in _local_11)
                {
                    _local_15 = _local_5.attribute("name");
                    _local_10 = _local_5.attribute("mimeType");
                    if (_local_10 == _local_13)
                    {
                        _local_7 = _local_16;
                    }
                    else
                    {
                        _local_7 = _arg_1.getAssetTypeDeclarationByMimeType(_local_10);
                        _local_13 = _local_10;
                        _local_16 = _local_7;
                    };
                    if (_local_7 != null)
                    {
                        _local_17 = (new _local_7.assetClass(_local_7) as IAsset);
                        _local_17.setUnknownContent(_arg_1.getAssetByName(_local_5.attribute("ref")).content);
                        _local_14 = _local_5.child("param");
                        if (_local_14.length())
                        {
                            _local_17.setParamsDesc(_local_14);
                        };
                        _arg_1.setAsset(_local_15, _local_17);
                    };
                };
            };
            return (true);
        }


        public function get url():String
        {
            return (_url);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get isReady():Boolean
        {
            return (_isReady);
        }

        public function get manifest():XML
        {
            return ((_manifest) ? _manifest : _manifest = new XML());
        }

        public function get numAssets():uint
        {
            return (_numAssets);
        }

        public function get nameArray():Array
        {
            return (_nameArray);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                unload();
                super.dispose();
                _assetLibraryRefArray.splice(_assetLibraryRefArray.indexOf(this), 1);
                _numAssetLibraryInstances--;
                _SafeStr_791 = null;
                _SafeStr_788 = null;
                _SafeStr_789 = null;
                _nameArray = null;
                System.disposeXML(_manifest);
                _manifest = null;
                _numAssets = 0;
                _isReady = false;
                _name = null;
            };
        }

        public function loadFromFile(_arg_1:LibraryLoader, _arg_2:Boolean=true):void
        {
            if (((_url == _arg_1.url) && (_isReady)))
            {
                if (((!(_SafeStr_790)) && (_arg_2)))
                {
                    AssetLibrary.fetchLibraryContents(this, _manifest, _SafeStr_787);
                };
                _SafeStr_790 = _arg_2;
                dispatchEvent(new Event("AssetLibraryReady"));
            }
            else
            {
                if (((_SafeStr_779 == null) || (_SafeStr_779.disposed)))
                {
                    _SafeStr_779 = _arg_1;
                    _SafeStr_779.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", libraryLoadedHandler);
                    _SafeStr_779.addEventListener("LIBRARY_LOADER_EVENT_ERROR", loadErrorHandler);
                };
                _SafeStr_790 = _arg_2;
                _url = _SafeStr_779.url;
            };
        }

        public function loadFromResource(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (AssetLibrary.fetchLibraryContents(this, _arg_1, _arg_2));
        }

        public function unload():void
        {
            var _local_2:String;
            var _local_1:AssetLoaderStruct;
            var _local_3:IAsset;
            for (_local_2 in _SafeStr_791)
            {
                _local_1 = _SafeStr_791[_local_2];
                _local_1.assetLoader.dispose();
                delete _SafeStr_791[_local_2];
            };
            for (_local_2 in _SafeStr_789)
            {
                _local_3 = _SafeStr_789[_local_2];
                _local_3.dispose();
                delete _SafeStr_789[_local_2];
            };
            for (_local_2 in _SafeStr_788)
            {
                delete _SafeStr_788[_local_2];
            };
            if (_SafeStr_779 != null)
            {
                _SafeStr_779.dispose();
                _SafeStr_779 = null;
            };
            _numAssets = 0;
            _isReady = false;
            _url = null;
            dispatchEvent(new Event("AssetLibraryUnloaded"));
        }

        public function getClass(_arg_1:String):Class
        {
            var _local_2:Class = _SafeStr_788[_arg_1];
            if (_local_2 != null)
            {
                return (_local_2);
            };
            if (_SafeStr_779 != null)
            {
                if (_SafeStr_779.hasDefinition(_arg_1))
                {
                    _local_2 = (_SafeStr_779.getDefinition(_arg_1) as Class);
                    if (_local_2 != null)
                    {
                        _SafeStr_788[_arg_1] = _local_2;
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function loadAssetFromFile(_arg_1:String, _arg_2:URLRequest, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:int=-1):AssetLoaderStruct
        {
            var _local_8:ByteArray;
            var _local_11:AssetTypeDeclaration;
            var _local_13:String;
            var _local_12:String;
            var _local_9:AssetTypeDeclaration;
            if (getAssetByName(_arg_1) != null)
            {
                throw (new Error((("Asset with name " + _arg_1) + " already exists!")));
            };
            if (((((fileProxy) && (_arg_4)) && (_arg_5)) && (!(_arg_5 == "-1"))))
            {
                _local_11 = getAssetTypeDeclarationByMimeType(_arg_3);
                if (((_local_11) && (_local_11.fileTypes.length > 0)))
                {
                    _local_13 = _local_11.fileTypes[0];
                    _local_12 = getCacheFilePath(_arg_4, _arg_5, ((_arg_1 + ".") + _local_13));
                    _local_8 = fileProxy.readCache(_local_12);
                };
            };
            var _local_7:AssetLoaderStruct = _SafeStr_791[_arg_2.url];
            if (_local_7 != null)
            {
                if (_local_7.assetName == _arg_1)
                {
                    return (_local_7);
                };
            };
            if (_arg_3 == null)
            {
                _local_9 = solveAssetTypeDeclarationFromUrl(_arg_2.url);
                if (_local_9 == null)
                {
                    throw (new Error((("Couldn't solve asset type for file " + _arg_2.url) + "!")));
                };
            }
            else
            {
                _local_9 = getAssetTypeDeclarationByMimeType(_arg_3, true);
                if (_local_9 == null)
                {
                    throw (new Error((("Asset type declaration for mime type " + _arg_3) + "not found!")));
                };
            };
            var _local_10:IAssetLoader = new _local_9.loaderClass(_local_9.mimeType, _arg_2, _arg_4, _arg_5, _local_8, _arg_6);
            if (_local_10 == null)
            {
                throw (new Error((("Invalid file loader class defined for mime type " + _arg_3) + "!")));
            };
            _local_10.addEventListener("AssetLoaderEventComplete", assetLoadEventHandler);
            _local_10.addEventListener("AssetLoaderEventError", assetLoadEventHandler);
            _local_10.addEventListener("AssetLoaderEventUnload", assetLoadEventHandler);
            _local_10.addEventListener("AssetLoaderEventProgress", assetLoadEventHandler);
            _local_10.addEventListener("AssetLoaderEventStatus", assetLoadEventHandler);
            _local_10.addEventListener("AssetLoaderEventOpen", assetLoadEventHandler);
            _local_7 = new AssetLoaderStruct(_arg_1, _local_10);
            _SafeStr_791[_arg_2.url] = _local_7;
            return (_local_7);
        }

        private function addToCache(_arg_1:IAssetLoader, _arg_2:String):void
        {
            var _local_7:AssetTypeDeclaration;
            var _local_6:String;
            var _local_5:String;
            var _local_3:String;
            var _local_4:ByteArray;
            if ((((((fileProxy) && (_arg_1)) && (!(_arg_1.cacheKey == null))) && (_arg_1.cacheRevision)) && (!(_arg_1.cacheRevision == "-1"))))
            {
                _local_7 = getAssetTypeDeclarationByMimeType(_arg_1.mimeType);
                if (((_local_7) && (_local_7.fileTypes.length > 0)))
                {
                    _local_6 = _local_7.fileTypes[0];
                    _local_5 = getCacheDirectoryPath(_arg_1.cacheKey);
                    fileProxy.deleteCacheDirectory(_local_5);
                    _local_3 = getCacheFilePath(_arg_1.cacheKey, _arg_1.cacheRevision, ((_arg_2 + ".") + _local_6));
                    _local_4 = _arg_1.bytes;
                    if (((!(_local_4 == null)) && (_local_4.length > 0)))
                    {
                        fileProxy.writeCache(_local_3, _local_4);
                    };
                };
            };
        }

        private function assetLoadEventHandler(_arg_1:AssetLoaderEvent):void
        {
            var _local_5:String;
            var _local_3:AssetTypeDeclaration;
            var _local_6:IAsset;
            var _local_7:Boolean;
            var _local_4:IAssetLoader = (_arg_1.target as IAssetLoader);
            if (_local_4 == null)
            {
                throw (new Error("Failed to downcast object to asset loader!"));
            };
            var _local_2:AssetLoaderStruct = _SafeStr_791[_local_4.url];
            if (_local_2 == null)
            {
                throw (new Error(("Asset loader structure was lost! " + ((_local_4) ? _local_4.url : ""))));
            };
            switch (_arg_1.type)
            {
                case "AssetLoaderEventComplete":
                    _local_5 = _local_4.mimeType;
                    _local_3 = getAssetTypeDeclarationByMimeType(_local_5);
                    _local_7 = true;
                    if (_local_3 != null)
                    {
                        _local_6 = new _local_3.assetClass(_local_3, _local_4.url);
                        try
                        {
                            _local_6.setUnknownContent(_local_4.content);
                            if (!_local_4.fromCache)
                            {
                                addToCache(_local_4, _local_2.assetName);
                            };
                        }
                        catch(error:Error)
                        {
                            _local_6.dispose();
                            _arg_1 = new AssetLoaderEvent("AssetLoaderEventError", _arg_1.status);
                            break;
                        };
                        if (_SafeStr_789[_local_2.assetName] == null)
                        {
                            _numAssets++;
                            _nameArray.push(_local_2.assetName);
                        };
                        _SafeStr_789[_local_2.assetName] = _local_6;
                    }
                    else
                    {
                        _arg_1 = new AssetLoaderEvent("AssetLoaderEventError", _arg_1.status);
                    };
                    break;
                case "AssetLoaderEventError":
                    _local_7 = true;
            };
            _local_2.dispatchEvent(new AssetLoaderEvent(_arg_1.type, _arg_1.status));
            if (_local_7)
            {
                if (((!(_disposed)) && (_local_4)))
                {
                    delete _SafeStr_791[_local_4.url];
                };
                if (_local_2)
                {
                    _local_2.dispose();
                };
            };
        }

        public function getAssetByName(_arg_1:String):IAsset
        {
            var _local_2:IAsset = _SafeStr_789[_arg_1];
            if (_local_2 != null)
            {
                return (_local_2);
            };
            if (_SafeStr_790)
            {
                return (null);
            };
            _local_2 = fetchAssetFromResource(_arg_1);
            if (_local_2 == null)
            {
            };
            return (_local_2);
        }

        public function getAssetByIndex(_arg_1:uint):IAsset
        {
            return ((_arg_1 < _nameArray.length) ? getAssetByName(_nameArray[_arg_1]) : null);
        }

        public function getAssetByContent(_arg_1:Object):IAsset
        {
            var _local_3:IAsset;
            var _local_2:String;
            for (_local_2 in _SafeStr_789)
            {
                _local_3 = _SafeStr_789[_local_2];
                if (_local_3.content === _arg_1)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function getAssetIndex(_arg_1:IAsset):int
        {
            var _local_2:String;
            for (_local_2 in _SafeStr_789)
            {
                if (_SafeStr_789[_local_2] == _arg_1)
                {
                    return (_nameArray.indexOf(_local_2));
                };
            };
            return (-1);
        }

        public function hasAsset(_arg_1:String):Boolean
        {
            return ((!(_SafeStr_789[_arg_1] == null)) || ((_SafeStr_787 != null) ? (!(_SafeStr_787[_arg_1] == null)) : false));
        }

        public function setAsset(_arg_1:String, _arg_2:IAsset, _arg_3:Boolean=true):Boolean
        {
            var _local_4:Boolean = (_SafeStr_789[_arg_1] == null);
            if ((((_arg_3) || (_local_4)) && (_arg_2)))
            {
                if (_local_4)
                {
                    _numAssets++;
                    _nameArray.push(_arg_1);
                };
                _SafeStr_789[_arg_1] = _arg_2;
                return (true);
            };
            return (false);
        }

        public function createAsset(_arg_1:String, _arg_2:AssetTypeDeclaration):IAsset
        {
            if (((hasAsset(_arg_1)) || (!(_arg_2))))
            {
                return (null);
            };
            var _local_3:IAsset = new _arg_2.assetClass(_arg_2);
            if (!setAsset(_arg_1, _local_3))
            {
                _local_3.dispose();
                _local_3 = null;
            };
            return (_local_3);
        }

        public function removeAsset(_arg_1:IAsset):IAsset
        {
            var _local_2:String;
            if (_arg_1)
            {
                for (_local_2 in _SafeStr_789)
                {
                    if (_SafeStr_789[_local_2] == _arg_1)
                    {
                        _nameArray.splice(_nameArray.indexOf(_local_2), 1);
                        delete _SafeStr_789[_local_2];
                        _numAssets--;
                        return (_arg_1);
                    };
                };
            };
            return (null);
        }

        public function registerAssetTypeDeclaration(_arg_1:AssetTypeDeclaration, _arg_2:Boolean=true):Boolean
        {
            if (_arg_2)
            {
                if (_sharedListOfTypesByMime.hasOwnProperty(_arg_1.mimeType))
                {
                    throw (new Error((("Asset type " + _arg_1.mimeType) + " already registered!")));
                };
                _sharedListOfTypesByMime[_arg_1.mimeType] = _arg_1;
            }
            else
            {
                if (_localListOfTypesByMime.hasOwnProperty(_arg_1.mimeType))
                {
                    throw (new Error((("Asset type " + _arg_1.mimeType) + " already registered!")));
                };
                _localListOfTypesByMime[_arg_1.mimeType] = _arg_1;
            };
            return (true);
        }

        public function getAssetTypeDeclarationByMimeType(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:AssetTypeDeclaration;
            if (_arg_2)
            {
                _local_3 = AssetTypeDeclaration(_sharedListOfTypesByMime[_arg_1]);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (AssetTypeDeclaration(_localListOfTypesByMime[_arg_1]));
        }

        public function getAssetTypeDeclarationByClass(_arg_1:Class, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_4:String;
            var _local_3:AssetTypeDeclaration;
            if (_arg_2)
            {
                for (_local_4 in _sharedListOfTypesByMime)
                {
                    _local_3 = AssetTypeDeclaration(_sharedListOfTypesByMime[_local_4]);
                    if (_local_3 != null)
                    {
                        if (_local_3.assetClass == _arg_1)
                        {
                            return (_local_3);
                        };
                    };
                };
            };
            for (_local_4 in _localListOfTypesByMime)
            {
                _local_3 = AssetTypeDeclaration(_localListOfTypesByMime[_local_4]);
                if (_local_3 != null)
                {
                    if (_local_3.assetClass == _arg_1)
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public function getAssetTypeDeclarationByFileName(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_5:String;
            var _local_4:AssetTypeDeclaration;
            var _local_3:String = _arg_1.substr((_arg_1.lastIndexOf(".") + 1), _arg_1.length);
            if (_local_3.indexOf("?"))
            {
                _local_3 = _local_3.substr(0, (_local_3.indexOf("?") - 1));
            };
            if (_arg_2)
            {
                for (_local_5 in _sharedListOfTypesByMime)
                {
                    _local_4 = AssetTypeDeclaration(_sharedListOfTypesByMime[_local_5]);
                    if (_local_4 != null)
                    {
                        if (_local_4.fileTypes.indexOf(_local_3))
                        {
                            return (_local_4);
                        };
                    };
                };
            };
            for (_local_5 in _localListOfTypesByMime)
            {
                _local_4 = AssetTypeDeclaration(_localListOfTypesByMime[_local_5]);
                if (_local_4 != null)
                {
                    if (_local_4.fileTypes.indexOf(_local_3))
                    {
                        return (_local_4);
                    };
                };
            };
            return (null);
        }

        private function libraryLoadedHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            if (_local_2.manifest == null)
            {
                throw (new Error("loader.manifest was null, which would have caused error 1009 anyway. See HL-22347."));
            };
            _manifest = _local_2.manifest.copy();
            _SafeStr_787 = _local_2.resource;
            _url = _local_2.url;
            if (_SafeStr_790)
            {
                AssetLibrary.fetchLibraryContents(this, _manifest, _SafeStr_787);
            };
            _isReady = true;
            dispatchEvent(new Event("AssetLibraryLoaded"));
            dispatchEvent(new Event("AssetLibraryReady"));
            if (_SafeStr_790)
            {
                _SafeStr_779.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", libraryLoadedHandler);
                _SafeStr_779.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", loadErrorHandler);
                _SafeStr_779.addEventListener("LIBRARY_LOADER_FINALIZE", finalizeLoaderEventHandler);
                _SafeStr_779 = null;
                _SafeStr_787 = null;
            };
        }

        private function finalizeLoaderEventHandler(_arg_1:Event):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            if (((_local_2) && (!(_local_2.disposed))))
            {
                if (!_local_2.hasEventListener("LIBRARY_LOADER_EVENT_COMPLETE"))
                {
                    _local_2.removeEventListener("LIBRARY_LOADER_FINALIZE", finalizeLoaderEventHandler);
                    _local_2.dispose();
                };
            };
        }

        private function onLoadProgress(_arg_1:ProgressEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }

        private function loadErrorHandler(_arg_1:LibraryLoaderEvent):void
        {
            _isReady = false;
            var _local_3:LibraryLoader = (_arg_1.target as LibraryLoader);
            var _local_2:String = ((_local_3) ? _local_3.name : "unknown");
            dispatchEvent(new Event("AssetLibraryLoadError"));
            _SafeStr_779 = null;
        }

        private function solveAssetTypeDeclarationFromUrl(_arg_1:String):AssetTypeDeclaration
        {
            var _local_4:int;
            var _local_2:AssetTypeDeclaration;
            var _local_5:Array;
            var _local_3:String;
            _local_4 = _arg_1.indexOf("?", 0);
            if (_local_4 > 0)
            {
                _arg_1 = _arg_1.slice(0, _local_4);
            };
            _local_4 = _arg_1.lastIndexOf(".");
            if (_local_4 == -1)
            {
                return (null);
            };
            _arg_1 = _arg_1.slice((_local_4 + 1), _arg_1.length);
            for (_local_3 in _localListOfTypesByMime)
            {
                _local_2 = _localListOfTypesByMime[_local_3];
                _local_5 = _local_2.fileTypes;
                if (_local_5 != null)
                {
                    if (_local_5.indexOf(_arg_1, 0) > -1)
                    {
                        return (_local_2);
                    };
                };
            };
            for (_local_3 in _sharedListOfTypesByMime)
            {
                _local_2 = _sharedListOfTypesByMime[_local_3];
                _local_5 = _local_2.fileTypes;
                if (_local_5 != null)
                {
                    if (_local_5.indexOf(_arg_1, 0) > -1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        private function fetchAssetFromResource(_arg_1:String):IAsset
        {
            var _local_3:AssetTypeDeclaration;
            var _local_4:XMLList;
            var _local_2:XML;
            var _local_6:uint;
            if (!_SafeStr_787)
            {
                return (null);
            };
            var _local_7:XMLList = _manifest.child("library");
            if (_local_7 == null)
            {
                throw (new Error("Provided manifest doesn't contain library node!"));
            };
            if (_local_7.length() == 0)
            {
                return (null);
            };
            _local_7 = _local_7[0].assets;
            if (_local_7 != null)
            {
                _local_7 = _local_7.child("asset");
                if (_local_7 != null)
                {
                    var _local_8:IAsset = null;
                    var _local_5:int = _local_7.length();
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        _local_2 = _local_7[_local_6];
                        if (((_local_2.attribute("name")) && (_local_2.attribute("name").toString() == _arg_1)))
                        {
                            _local_3 = getAssetTypeDeclarationByMimeType(_local_2.attribute("mimeType"));
                            if (_local_3 == null)
                            {
                                throw (new Error((((("Failed to extract asset " + _arg_1) + " from Library ") + _url) + "!")));
                            };
                            _local_8 = (new _local_3.assetClass(_local_3) as IAsset);
                            _local_8.setUnknownContent(_SafeStr_787[_arg_1]);
                            _local_4 = _local_2.child("param");
                            if (((_local_4) && (_local_4.length())))
                            {
                                _local_8.setParamsDesc(_local_4);
                            };
                            setAsset(_arg_1, _local_8);
                            return (_local_8);
                        };
                        _local_6++;
                    };
                };
            };
            return (null);
        }

        public function toString():String
        {
            return ((getQualifiedClassName(this) + ": ") + _name);
        }


    }
}


package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import __AS3__.vec.Vector;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import com.sulake.core.utils.LibraryLoader;
    import flash.events.Event;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.net.URLRequest;

    public class AssetLibraryCollection extends EventDispatcherWrapper implements IAssetLibrary 
    {

        protected var _SafeStr_794:Vector.<IAssetLibrary>;
        protected var _SafeStr_792:Array;
        protected var _SafeStr_781:LoaderContext;
        protected var _SafeStr_793:AssetLibrary;
        protected var _manifest:XML;
        protected var _name:String;
        private var _SafeStr_795:uint = 0;

        public function AssetLibraryCollection(_arg_1:String)
        {
            _name = _arg_1;
            _manifest = null;
            _SafeStr_794 = new Vector.<IAssetLibrary>();
            _SafeStr_792 = [];
            _SafeStr_781 = new LoaderContext(false, ApplicationDomain.currentDomain, null);
        }

        public function get url():String
        {
            return ("");
        }

        public function get name():String
        {
            return (_name);
        }

        public function get isReady():Boolean
        {
            return (_SafeStr_792.length == 0);
        }

        public function get numAssets():uint
        {
            return (getNumAssets());
        }

        public function get nameArray():Array
        {
            return (getAssetNameArray());
        }

        public function get manifest():XML
        {
            return ((_manifest) ? _manifest : _manifest = new XML());
        }

        public function get loaderContext():LoaderContext
        {
            return (_SafeStr_781);
        }

        public function set loaderContext(_arg_1:LoaderContext):void
        {
            _SafeStr_781 = _arg_1;
        }

        private function get binLibrary():IAssetLibrary
        {
            if (!_SafeStr_793)
            {
                _SafeStr_793 = new AssetLibrary("bin");
                _SafeStr_794.splice(0, 0, _SafeStr_793);
            };
            return (_SafeStr_793);
        }

        public function loadFromFile(_arg_1:LibraryLoader, _arg_2:Boolean=false):void
        {
            if (loaderContext == null)
            {
                loaderContext = _SafeStr_781;
            };
            var _local_3:IAssetLibrary = new AssetLibrary(("lib-" + _SafeStr_795++));
            _SafeStr_792.push(_local_3);
            _local_3.loadFromFile(_arg_1, _arg_2);
            _arg_1.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE", loadEventHandler);
            _arg_1.addEventListener("LIBRARY_LOADER_EVENT_ERROR", loadEventHandler);
            _arg_1.addEventListener("LIBRARY_LOADER_EVENT_PROGRESS", loadEventHandler);
        }

        public function loadFromResource(_arg_1:XML, _arg_2:Class):Boolean
        {
            return (binLibrary.loadFromResource(_arg_1, _arg_2));
        }

        public function unload():void
        {
            while (_SafeStr_792.length > 0)
            {
                (_SafeStr_792.pop() as IAssetLibrary).dispose();
            };
            while (_SafeStr_794.length > 0)
            {
                (_SafeStr_794.pop() as IAssetLibrary).dispose();
            };
        }

        override public function dispose():void
        {
            var _local_2:uint;
            var _local_1:IAssetLibrary;
            var _local_3:uint;
            if (!disposed)
            {
                super.dispose();
                _local_2 = _SafeStr_794.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_1 = _SafeStr_794.pop();
                    _local_1.dispose();
                    _local_3++;
                };
                _SafeStr_793 = null;
            };
        }

        private function loadEventHandler(_arg_1:LibraryLoaderEvent):void
        {
            var _local_3:LibraryLoader;
            var _local_2:IAssetLibrary;
            var _local_4:uint;
            if (_arg_1.type == "LIBRARY_LOADER_EVENT_COMPLETE")
            {
                _local_3 = (_arg_1.target as LibraryLoader);
                _local_4 = 0;
                while (_local_4 < _SafeStr_792.length)
                {
                    _local_2 = (_SafeStr_792[_local_4] as IAssetLibrary);
                    if (_local_2.url == _local_3.url)
                    {
                        _SafeStr_792.splice(_local_4, 1);
                        break;
                    };
                    _local_4++;
                };
                _SafeStr_794.push(_local_2);
                _local_3.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE", loadEventHandler);
                _local_3.removeEventListener("LIBRARY_LOADER_EVENT_ERROR", loadEventHandler);
                _local_3.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS", loadEventHandler);
                if (_SafeStr_792.length == 0)
                {
                    dispatchEvent(new Event("AssetLibraryLoaded"));
                };
            };
        }

        public function hasAssetLibrary(_arg_1:String):Boolean
        {
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                if (_local_2.name == _arg_1)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getAssetLibraryByName(_arg_1:String):IAssetLibrary
        {
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                if (_local_2.name == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getAssetLibraryByUrl(_arg_1:String):IAssetLibrary
        {
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                if (_local_2.url == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getAssetLibraryByPartialUrl(_arg_1:String):IAssetLibrary
        {
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                if (((_local_2.url) && (!(_local_2.url.indexOf(_arg_1) === -1))))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function addAssetLibrary(_arg_1:IAssetLibrary):void
        {
            if (_SafeStr_794.indexOf(_arg_1) == -1)
            {
                _SafeStr_794.push(_arg_1);
            };
        }

        public function loadAssetFromFile(_arg_1:String, _arg_2:URLRequest, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:int=-1):AssetLoaderStruct
        {
            return (binLibrary.loadAssetFromFile(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public function getAssetByName(_arg_1:String):IAsset
        {
            var _local_3:IAsset;
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                _local_3 = _local_2.getAssetByName(_arg_1);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function getAssetsByName(_arg_1:String):Array
        {
            var _local_4:IAsset;
            var _local_2:Array = [];
            for each (var _local_3:IAssetLibrary in _SafeStr_794)
            {
                _local_4 = _local_3.getAssetByName(_arg_1);
                if (_local_4 != null)
                {
                    _local_2.push(_local_4);
                };
            };
            return (_local_2);
        }

        public function getAssetByContent(_arg_1:Object):IAsset
        {
            var _local_3:IAsset;
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                _local_3 = _local_2.getAssetByContent(_arg_1);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function getAssetByIndex(_arg_1:uint):IAsset
        {
            var _local_2:uint;
            var _local_3:uint;
            for each (var _local_4:IAssetLibrary in _SafeStr_794)
            {
                _local_2 = (_local_2 + _local_4.numAssets);
                if (_local_2 <= _arg_1)
                {
                    return (_local_4.getAssetByIndex((_arg_1 - _local_3)));
                };
                _local_3 = _local_2;
            };
            return (null);
        }

        public function getAssetIndex(_arg_1:IAsset):int
        {
            var _local_2:int;
            var _local_4:int;
            for each (var _local_3:IAssetLibrary in _SafeStr_794)
            {
                _local_4 = _local_3.getAssetIndex(_arg_1);
                if (_local_4 != -1)
                {
                    return (_local_2 + _local_4);
                };
                _local_2 = (_local_2 + _local_3.numAssets);
            };
            return (-1);
        }

        public function hasAsset(_arg_1:String):Boolean
        {
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                if (_local_2.hasAsset(_arg_1))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function setAsset(_arg_1:String, _arg_2:IAsset, _arg_3:Boolean=true):Boolean
        {
            return (binLibrary.setAsset(_arg_1, _arg_2, _arg_3));
        }

        public function createAsset(_arg_1:String, _arg_2:AssetTypeDeclaration):IAsset
        {
            return (binLibrary.createAsset(_arg_1, _arg_2));
        }

        public function removeAsset(_arg_1:IAsset):IAsset
        {
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                if (_local_2.removeAsset(_arg_1) == _arg_1)
                {
                    return (_arg_1);
                };
            };
            return (null);
        }

        public function registerAssetTypeDeclaration(_arg_1:AssetTypeDeclaration, _arg_2:Boolean=true):Boolean
        {
            return (binLibrary.registerAssetTypeDeclaration(_arg_1, _arg_2));
        }

        public function getAssetTypeDeclarationByMimeType(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:AssetTypeDeclaration;
            if (_arg_2)
            {
                return (binLibrary.getAssetTypeDeclarationByMimeType(_arg_1, true));
            };
            for each (var _local_4:IAssetLibrary in _SafeStr_794)
            {
                _local_3 = _local_4.getAssetTypeDeclarationByMimeType(_arg_1, false);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function getAssetTypeDeclarationByClass(_arg_1:Class, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:AssetTypeDeclaration;
            if (_arg_2)
            {
                return (binLibrary.getAssetTypeDeclarationByClass(_arg_1, true));
            };
            for each (var _local_4:IAssetLibrary in _SafeStr_794)
            {
                _local_3 = _local_4.getAssetTypeDeclarationByClass(_arg_1, false);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function getAssetTypeDeclarationByFileName(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration
        {
            var _local_3:AssetTypeDeclaration;
            if (_arg_2)
            {
                return (binLibrary.getAssetTypeDeclarationByFileName(_arg_1, true));
            };
            for each (var _local_4:IAssetLibrary in _SafeStr_794)
            {
                _local_3 = _local_4.getAssetTypeDeclarationByFileName(_arg_1, false);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        private function getNumAssets():uint
        {
            var _local_1:uint;
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                _local_1 = (_local_1 + _local_2.numAssets);
            };
            return (_local_1);
        }

        private function getAssetNameArray():Array
        {
            var _local_2:Array = [];
            for each (var _local_1:IAssetLibrary in _SafeStr_794)
            {
                _local_2 = _local_2.concat(_local_1.nameArray);
            };
            return (_local_2);
        }

        public function getManifests():Array
        {
            var _local_2:Array = [];
            for each (var _local_1:IAssetLibrary in _SafeStr_794)
            {
                _local_2.push(_local_1.manifest);
            };
            return (_local_2);
        }

        private function buildManifest():XML
        {
            var _local_3:XML = new XML("<manifest><library></library></manifest>");
            var _local_1:XMLList = _local_3.child("library");
            if (_SafeStr_793)
            {
                applyManifestNodes(_local_1, _SafeStr_793);
            };
            for each (var _local_2:IAssetLibrary in _SafeStr_794)
            {
                applyManifestNodes(_local_1, _local_2);
            };
            return (_local_3);
        }

        private function applyManifestNodes(_arg_1:XMLList, _arg_2:IAssetLibrary):void
        {
            var _local_3:XML;
            var _local_4:XMLList;
            var _local_5:XMLList = _arg_2.manifest.library.children();
            for each (var _local_6:XML in _local_5)
            {
                _local_3 = _arg_1.child(_local_6.name())[0];
                if (!_local_3)
                {
                    _arg_1.appendChild(new XML((("<" + _local_6.name()) + "/>")));
                    _local_3 = _arg_1.child(_local_6.name())[0];
                };
                _local_4 = _local_6.children();
                for each (var _local_7:XML in _local_4)
                {
                    _local_3.appendChild(_local_7);
                };
            };
        }


    }
}


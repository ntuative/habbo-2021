package com.sulake.habbo.window
{
    import com.sulake.core.assets.IResourceManager;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.IAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.IAssetReceiver;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class ResourceManager implements IResourceManager 
    {

        private var _disposed:Boolean;
        private var _windowManager:HabboWindowManagerComponent;
        private var _assetReceivers:Dictionary = new Dictionary();

        public function ResourceManager(_arg_1:HabboWindowManagerComponent)
        {
            _windowManager = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function retrieveAsset(_arg_1:String, _arg_2:IAssetReceiver):void
        {
            var _local_3:AssetLoaderStruct;
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                return;
            };
            var _local_4:String = resolveAssetName(_arg_1);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IAsset = _windowManager.assets.getAssetByName(_local_4);
            if (_local_5 == null)
            {
                if (((_local_4.substr(0, 7) == "http://") || (_local_4.substr(0, 8) == "https://")))
                {
                    _local_3 = _windowManager.assets.loadAssetFromFile(_local_4, new URLRequest(_local_4));
                    if (((!(_local_3 == null)) && (!(_local_3.disposed))))
                    {
                        if (_assetReceivers[_local_4] == null)
                        {
                            _assetReceivers[_local_4] = [];
                        };
                        if (_arg_2 != null)
                        {
                            _assetReceivers[_local_4].push(_arg_2);
                        };
                        _local_3.addEventListener("AssetLoaderEventComplete", passAssetToCallback);
                    };
                };
            }
            else
            {
                if (_arg_2 != null)
                {
                    _arg_2.receiveAsset(_local_5, _local_4);
                };
            };
        }

        private function passAssetToCallback(_arg_1:AssetLoaderEvent=null):void
        {
            if (_disposed)
            {
                return;
            };
            var _local_3:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (((_local_3 == null) || (_assetReceivers[_local_3.assetName] == null)))
            {
                return;
            };
            var _local_4:IAsset = _windowManager.assets.getAssetByName(_local_3.assetName);
            for each (var _local_2:IAssetReceiver in _assetReceivers[_local_3.assetName])
            {
                if (((!(_local_2 == null)) && (!(_local_2.disposed))))
                {
                    _local_2.receiveAsset(_local_4, _local_4.url);
                };
            };
            delete _assetReceivers[_local_3.assetName]; //not popped
        }

        public function isSameAsset(_arg_1:String, _arg_2:String):Boolean
        {
            return (_arg_2 == resolveAssetName(_arg_1));
        }

        private function resolveAssetName(_arg_1:String):String
        {
            return (_windowManager.interpolate(_arg_1));
        }

        public function createAsset(_arg_1:String, _arg_2:Class, _arg_3:Object):IAsset
        {
            var _local_4:IAsset = new _arg_2(_windowManager.assets.getAssetTypeDeclarationByClass(_arg_2));
            _windowManager.assets.setAsset(_arg_1, _local_4);
            _local_4.setUnknownContent(_arg_3);
            return (_local_4);
        }

        public function removeAsset(_arg_1:String):void
        {
            var _local_2:String = resolveAssetName(_arg_1);
            _windowManager.assets.removeAsset(_windowManager.assets.getAssetByName(_local_2));
        }


    }
}
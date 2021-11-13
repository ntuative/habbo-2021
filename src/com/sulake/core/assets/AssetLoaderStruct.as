package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.loaders.IAssetLoader;

    public class AssetLoaderStruct extends EventDispatcherWrapper implements IDisposable 
    {

        private var _assetLoader:IAssetLoader;
        private var _assetName:String;

        public function AssetLoaderStruct(_arg_1:String, _arg_2:IAssetLoader)
        {
            _assetName = _arg_1;
            _assetLoader = _arg_2;
        }

        public function get assetName():String
        {
            return (_assetName);
        }

        public function get assetLoader():IAssetLoader
        {
            return (_assetLoader);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_assetLoader != null)
                {
                    if (!_assetLoader.disposed)
                    {
                        _assetLoader.dispose();
                        _assetLoader = null;
                    };
                };
                super.dispose();
            };
        }


    }
}
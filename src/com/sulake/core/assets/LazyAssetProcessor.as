package com.sulake.core.assets
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import __AS3__.vec.Vector;
    import com.sulake.core.Core;

    public class LazyAssetProcessor implements IUpdateReceiver 
    {

        private var _SafeStr_800:Vector.<ILazyAsset> = new Vector.<ILazyAsset>();
        private var _SafeStr_801:Boolean = false;
        private var _disposed:Boolean = false;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                Core.instance.removeUpdateReceiver(this);
                _SafeStr_800 = null;
                _SafeStr_801 = false;
                _disposed = true;
            };
        }

        public function push(_arg_1:ILazyAsset):void
        {
            if (_arg_1)
            {
                _SafeStr_800.push(_arg_1);
                if (!_SafeStr_801)
                {
                    Core.instance.registerUpdateReceiver(this, 2);
                    _SafeStr_801 = true;
                };
            };
        }

        public function flush():void
        {
            for each (var _local_1:ILazyAsset in _SafeStr_800)
            {
                if (!_local_1.disposed)
                {
                    _local_1.prepareLazyContent();
                };
            };
            _SafeStr_800 = new Vector.<ILazyAsset>();
            if (_SafeStr_801)
            {
                Core.instance.removeUpdateReceiver(this);
                _SafeStr_801 = false;
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:ILazyAsset = _SafeStr_800.shift();
            if (!_local_2)
            {
                if (_SafeStr_801)
                {
                    Core.instance.removeUpdateReceiver(this);
                    _SafeStr_801 = false;
                };
            }
            else
            {
                if (!_local_2.disposed)
                {
                    _local_2.prepareLazyContent();
                };
            };
        }


    }
}


package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import com.sulake.core.assets.IAssetReceiver;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.utils.PropertyStruct;

   public class StaticBitmapWrapperController extends BitmapDataController implements IStaticBitmapWrapperWindow, IBitmapDataContainer, IAssetReceiver
    {

        protected var _assetUri:String;
        protected var _SafeStr_944:Boolean = false;

        public function StaticBitmapWrapperController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_944)
                {
                    _bitmapData.dispose();
                };
                super.dispose();
            };
        }

        public function get assetUri():String
        {
            return (_assetUri);
        }

        public function set assetUri(_arg_1:String):void
        {
            if (_assetUri == _arg_1)
            {
                return;
            };
            _assetUri = _arg_1;
            if (((_arg_1 == null) || (_arg_1.length <= 0)))
            {
                if (_SafeStr_944)
                {
                    _bitmapData.dispose();
                };
                _bitmapData = null;
                _SafeStr_944 = false;
                _context.invalidate(this, null, 1);
            }
            else
            {
                _context.getResourceManager().retrieveAsset(_assetUri, this);
            };
        }

        public function receiveAsset(_arg_1:IAsset, _arg_2:String):void
        {
            var _local_5:Rectangle;
            if (((_disposed) || (!(_context.getResourceManager().isSameAsset(_assetUri, _arg_2)))))
            {
                return;
            };
            var _local_4:BitmapDataAsset = (_arg_1 as BitmapDataAsset);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:BitmapData = (_local_4.content as BitmapData);
            if (_local_3 == null)
            {
                return;
            };
            if (_bitmapData != _local_3)
            {
                if (_SafeStr_944)
                {
                    _bitmapData.dispose();
                };
                _SafeStr_944 = false;
                _local_5 = _local_4.rectangle;
                if (((_local_3.width == _local_5.width) && (_local_3.height == _local_5.height)))
                {
                    _bitmapData = _local_3;
                }
                else
                {
                    _bitmapData = new BitmapData(_local_5.width, _local_5.height);
                    _bitmapData.copyPixels(_local_3, _local_5, new Point(0, 0));
                    _SafeStr_944 = true;
                };
                _context.invalidate(this, null, 1);
            };
            fitSize();
        }

        override public function clone():IWindow
        {
            var _local_1:StaticBitmapWrapperController = (super.clone() as StaticBitmapWrapperController);
            if (_SafeStr_944)
            {
                _local_1._bitmapData = _bitmapData.clone();
            }
            else
            {
                _local_1._bitmapData = _bitmapData;
            };
            _local_1._assetUri = _assetUri;
            _local_1._SafeStr_944 = _SafeStr_944;
            return (_local_1);
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.unshift(createProperty("asset_uri", _assetUri));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "asset_uri":
                        assetUri = (_local_2.value as String);
                };
            };
            super.properties = _arg_1;
        }


    }
}
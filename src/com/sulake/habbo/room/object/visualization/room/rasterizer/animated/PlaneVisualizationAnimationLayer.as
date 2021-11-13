package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class PlaneVisualizationAnimationLayer implements IDisposable 
    {

        private var _color:uint = 0;
        private var _bitmapData:BitmapData = null;
        private var _disposed:Boolean = false;
        private var _items:Array = [];

        public function PlaneVisualizationAnimationLayer(_arg_1:XML, _arg_2:IGraphicAssetCollection)
        {
            var _local_10:XMLList = null;
            var _local_6:int;
            var _local_3:XML = null;
            var _local_7:String = null;
            var _local_9:IGraphicAsset = null;
            var _local_4:BitmapDataAsset = null;
            var _local_5:BitmapData = null;
            var _local_8:AnimationItem = null;
            super();
            if (((!(_arg_1 == null)) && (!(_arg_2 == null))))
            {
                _local_10 = _arg_1.item;
                _local_6 = 0;
                while (_local_6 < _local_10.length())
                {
                    _local_3 = (_local_10[_local_6] as XML);
                    if (_local_3 != null)
                    {
                        _local_7 = _local_3.@asset;
                        _local_9 = _arg_2.getAsset(_local_7);
                        if (_local_9 != null)
                        {
                            _local_4 = (_local_9.asset as BitmapDataAsset);
                            if (_local_4 != null)
                            {
                                _local_5 = (_local_4.content as BitmapData);
                                if (_local_5 != null)
                                {
                                    _local_8 = new AnimationItem(parseFloat(_local_3.@x), parseFloat(_local_3.@y), parseFloat(_local_3.@speedX), parseFloat(_local_3.@speedY), _local_5);
                                    _items.push(_local_8);
                                };
                            };
                        };
                    };
                    _local_6++;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            var _local_2:int;
            var _local_1:AnimationItem;
            _disposed = true;
            if (_bitmapData != null)
            {
                _bitmapData.dispose();
                _bitmapData = null;
            };
            if (_items != null)
            {
                _local_2 = 0;
                while (_local_2 < _items.length)
                {
                    _local_1 = (_items[_local_2] as AnimationItem);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _items = [];
            };
        }

        public function clearCache():void
        {
            if (_bitmapData != null)
            {
                _bitmapData.dispose();
                _bitmapData = null;
            };
        }

        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:Number, _arg_10:Number, _arg_11:int):BitmapData
        {
            var _local_14:int;
            var _local_13:AnimationItem;
            var _local_12:Point;
            if ((((_arg_1 == null) || (!(_arg_1.width == _arg_2))) || (!(_arg_1.height == _arg_3))))
            {
                if ((((_bitmapData == null) || (!(_bitmapData.width == _arg_2))) || (!(_bitmapData.height == _arg_3))))
                {
                    if (_bitmapData != null)
                    {
                        _bitmapData.dispose();
                    };
                    _bitmapData = new BitmapData(_arg_2, _arg_3, true, 0xFFFFFF);
                }
                else
                {
                    _bitmapData.fillRect(_bitmapData.rect, 0xFFFFFF);
                };
                _arg_1 = _bitmapData;
            };
            if (((_arg_7 > 0) && (_arg_8 > 0)))
            {
                _local_14 = 0;
                while (_local_14 < _items.length)
                {
                    _local_13 = (_items[_local_14] as AnimationItem);
                    if (_local_13 != null)
                    {
                        _local_12 = _local_13.getPosition(_arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
                        _local_12.x = (_local_12.x - _arg_5);
                        _local_12.y = (_local_12.y - _arg_6);
                        if (_local_13.bitmapData != null)
                        {
                            if (((((_local_12.x > -(_local_13.bitmapData.width)) && (_local_12.x < _arg_1.width)) && (_local_12.y > -(_local_13.bitmapData.height))) && (_local_12.y < _arg_1.height)))
                            {
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, _local_12, null, null, true);
                            };
                            if ((((((_local_12.x - _arg_7) > -(_local_13.bitmapData.width)) && ((_local_12.x - _arg_7) < _arg_1.width)) && (_local_12.y > -(_local_13.bitmapData.height))) && (_local_12.y < _arg_1.height)))
                            {
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, new Point((_local_12.x - _arg_7), _local_12.y), null, null, true);
                            };
                            if (((((_local_12.x > -(_local_13.bitmapData.width)) && (_local_12.x < _arg_1.width)) && ((_local_12.y - _arg_8) > -(_local_13.bitmapData.height))) && ((_local_12.y - _arg_8) < _arg_1.height)))
                            {
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, new Point(_local_12.x, (_local_12.y - _arg_8)), null, null, true);
                            };
                            if ((((((_local_12.x - _arg_7) > -(_local_13.bitmapData.width)) && ((_local_12.x - _arg_7) < _arg_1.width)) && ((_local_12.y - _arg_8) > -(_local_13.bitmapData.height))) && ((_local_12.y - _arg_8) < _arg_1.height)))
                            {
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, new Point((_local_12.x - _arg_7), (_local_12.y - _arg_8)), null, null, true);
                            };
                        };
                    };
                    _local_14++;
                };
            };
            return (_arg_1);
        }


    }
}
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;

    public class PlaneTexture 
    {

        public static const _SafeStr_3425:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _bitmaps:Array = [];


        public function dispose():void
        {
            var _local_2:int;
            var _local_1:PlaneTextureBitmap;
            if (_bitmaps != null)
            {
                _local_2 = 0;
                while (_local_2 < _bitmaps.length)
                {
                    _local_1 = (_bitmaps[_local_2] as PlaneTextureBitmap);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _bitmaps = null;
            };
        }

        public function addBitmap(_arg_1:BitmapData, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1, _arg_6:String=null):void
        {
            var _local_7:PlaneTextureBitmap = new PlaneTextureBitmap(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            _bitmaps.push(_local_7);
        }

        public function getBitmap(_arg_1:IVector3d):BitmapData
        {
            var _local_2:PlaneTextureBitmap = getPlaneTextureBitmap(_arg_1);
            return ((_local_2 == null) ? null : _local_2.bitmap);
        }

        public function getPlaneTextureBitmap(_arg_1:IVector3d):PlaneTextureBitmap
        {
            var _local_3:int;
            var _local_2:PlaneTextureBitmap;
            if (_arg_1 == null)
            {
                return (null);
            };
            _local_3 = 0;
            while (_local_3 < _bitmaps.length)
            {
                _local_2 = (_bitmaps[_local_3] as PlaneTextureBitmap);
                if (_local_2 != null)
                {
                    if (((((_arg_1.x >= _local_2.normalMinX) && (_arg_1.x <= _local_2.normalMaxX)) && (_arg_1.y >= _local_2.normalMinY)) && (_arg_1.y <= _local_2.normalMaxY)))
                    {
                        return (_local_2);
                    };
                };
                _local_3++;
            };
            return (null);
        }

        public function getAssetName(_arg_1:IVector3d):String
        {
            var _local_2:PlaneTextureBitmap = getPlaneTextureBitmap(_arg_1);
            return ((_local_2 == null) ? null : _local_2.assetName);
        }


    }
}


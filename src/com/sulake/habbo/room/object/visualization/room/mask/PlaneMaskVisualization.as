package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.utils.IVector3d;

    public class PlaneMaskVisualization 
    {

        public static const _SafeStr_3425:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _bitmaps:Array = [];


        public function dispose():void
        {
            var _local_2:int;
            var _local_1:PlaneMaskBitmap;
            if (_bitmaps != null)
            {
                _local_2 = 0;
                while (_local_2 < _bitmaps.length)
                {
                    _local_1 = (_bitmaps[_local_2] as PlaneMaskBitmap);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _bitmaps = null;
            };
        }

        public function addBitmap(_arg_1:IGraphicAsset, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1):void
        {
            var _local_6:PlaneMaskBitmap = new PlaneMaskBitmap(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            _bitmaps.push(_local_6);
        }

        public function getAsset(_arg_1:IVector3d):IGraphicAsset
        {
            var _local_3:int;
            var _local_2:PlaneMaskBitmap;
            if (_arg_1 == null)
            {
                return (null);
            };
            _local_3 = 0;
            while (_local_3 < _bitmaps.length)
            {
                _local_2 = (_bitmaps[_local_3] as PlaneMaskBitmap);
                if (_local_2 != null)
                {
                    if (((((_arg_1.x >= _local_2.normalMinX) && (_arg_1.x <= _local_2.normalMaxX)) && (_arg_1.y >= _local_2.normalMinY)) && (_arg_1.y <= _local_2.normalMaxY)))
                    {
                        return (_local_2.asset);
                    };
                };
                _local_3++;
            };
            return (null);
        }


    }
}


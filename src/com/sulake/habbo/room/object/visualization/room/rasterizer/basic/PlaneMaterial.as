package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.IVector3d;
    import flash.display.BitmapData;

    public class PlaneMaterial 
    {

        public static const _SafeStr_3425:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _planeMaterialItems:Array = [];
        private var _SafeStr_3429:Boolean = false;


        public function dispose():void
        {
            var _local_2:int;
            var _local_1:PlaneMaterialCellMatrix;
            if (_planeMaterialItems != null)
            {
                _local_2 = 0;
                while (_local_2 < _planeMaterialItems.length)
                {
                    _local_1 = (_planeMaterialItems[_local_2] as PlaneMaterialCellMatrix);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _planeMaterialItems = null;
            };
        }

        public function clearCache():void
        {
            var _local_2:int;
            var _local_1:PlaneMaterialCellMatrix;
            if (!_SafeStr_3429)
            {
                return;
            };
            if (_planeMaterialItems != null)
            {
                _local_2 = 0;
                while (_local_2 < _planeMaterialItems.length)
                {
                    _local_1 = (_planeMaterialItems[_local_2] as PlaneMaterialCellMatrix);
                    if (_local_1 != null)
                    {
                        _local_1.clearCache();
                    };
                    _local_2++;
                };
            };
            _SafeStr_3429 = false;
        }

        public function addMaterialCellMatrix(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Number=-1, _arg_5:Number=1, _arg_6:Number=-1, _arg_7:Number=1):PlaneMaterialCellMatrix
        {
            var _local_8:PlaneMaterialCellMatrix;
            _local_8 = new PlaneMaterialCellMatrix(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            _planeMaterialItems.push(_local_8);
            return (_local_8);
        }

        public function getMaterialCellMatrix(_arg_1:IVector3d):PlaneMaterialCellMatrix
        {
            var _local_2:int;
            var _local_3:PlaneMaterialCellMatrix;
            if (_arg_1 == null)
            {
                return (null);
            };
            _local_2 = 0;
            while (_local_2 < _planeMaterialItems.length)
            {
                _local_3 = (_planeMaterialItems[_local_2] as PlaneMaterialCellMatrix);
                if (_local_3 != null)
                {
                    if (((((_arg_1.x >= _local_3.normalMinX) && (_arg_1.x <= _local_3.normalMaxX)) && (_arg_1.y >= _local_3.normalMinY)) && (_arg_1.y <= _local_3.normalMaxY)))
                    {
                        return (_local_3);
                    };
                };
                _local_2++;
            };
            return (null);
        }

        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:Boolean, _arg_6:int, _arg_7:int, _arg_8:Boolean):BitmapData
        {
            if (_arg_2 < 1)
            {
                _arg_2 = 1;
            };
            if (_arg_3 < 1)
            {
                _arg_3 = 1;
            };
            var _local_9:PlaneMaterialCellMatrix = getMaterialCellMatrix(_arg_4);
            if (_local_9 != null)
            {
                _SafeStr_3429 = true;
                return (_local_9.render(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
            };
            return (null);
        }


    }
}


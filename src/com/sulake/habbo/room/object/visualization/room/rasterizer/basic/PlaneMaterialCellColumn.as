package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Point;

    public class PlaneMaterialCellColumn 
    {

        public static const REPEAT_MODE_NONE:int = 0;
        public static const REPEAT_MODE_ALL:int = 1;
        public static const REPEAT_MODE_BORDERS:int = 2;
        public static const REPEAT_MODE_CENTER:int = 3;
        public static const REPEAT_MODE_FIRST:int = 4;
        public static const REPEAT_MODE_LAST:int = 5;

        private var _cells:Array = [];
        private var _SafeStr_3435:int = 1;
        private var _width:int = 1;
        private var _SafeStr_3432:BitmapData;
        private var _cachedBitmapNormal:Vector3d = null;
        private var _SafeStr_3436:int;
        private var _SafeStr_3437:int;
        private var _SafeStr_3429:Boolean = false;
        private var _isStatic:Boolean = true;

        public function PlaneMaterialCellColumn(_arg_1:int, _arg_2:Array, _arg_3:int=1)
        {
            super();
            var _local_4:int;
            var _local_5:PlaneMaterialCell = null;
            if (_arg_1 < 1)
            {
                _arg_1 = 1;
            };
            _width = _arg_1;
            if (_arg_2 != null)
            {
                _local_4 = 0;
                while (_local_4 < _arg_2.length)
                {
                    _local_5 = (_arg_2[_local_4] as PlaneMaterialCell);
                    if (_local_5 != null)
                    {
                        _cells.push(_local_5);
                        if (!_local_5.isStatic)
                        {
                            _isStatic = false;
                        };
                    };
                    _local_4++;
                };
            };
            _SafeStr_3435 = _arg_3;
        }

        public function get isStatic():Boolean
        {
            return (_isStatic);
        }

        public function isRepeated():Boolean
        {
            return (!(_SafeStr_3435 == 0));
        }

        public function get width():int
        {
            return (_width);
        }

        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneMaterialCell;
            if (_cells != null)
            {
                _local_1 = 0;
                while (_local_1 < _cells.length)
                {
                    _local_2 = (_cells[_local_1] as PlaneMaterialCell);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                _cells = null;
            };
            if (_SafeStr_3432 != null)
            {
                _SafeStr_3432.dispose();
                _SafeStr_3432 = null;
            };
            if (_cachedBitmapNormal != null)
            {
                _cachedBitmapNormal = null;
            };
        }

        public function clearCache():void
        {
            var _local_1:int;
            var _local_2:PlaneMaterialCell;
            if (!_SafeStr_3429)
            {
                return;
            };
            if (_SafeStr_3432 != null)
            {
                _SafeStr_3432.dispose();
                _SafeStr_3432 = null;
            };
            if (_cachedBitmapNormal != null)
            {
                _cachedBitmapNormal.x = 0;
                _cachedBitmapNormal.y = 0;
                _cachedBitmapNormal.z = 0;
            };
            if (_cells != null)
            {
                _local_1 = 0;
                while (_local_1 < _cells.length)
                {
                    _local_2 = (_cells[_local_1] as PlaneMaterialCell);
                    if (_local_2 != null)
                    {
                        _local_2.clearCache();
                    };
                    _local_1++;
                };
            };
            _SafeStr_3429 = false;
        }

        public function render(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:int):BitmapData
        {
            var _local_5:int;
            if (_SafeStr_3435 == 0)
            {
                _local_5 = getCellsHeight(_cells, _arg_2);
                _arg_1 = _local_5;
            };
            if (_cachedBitmapNormal == null)
            {
                _cachedBitmapNormal = new Vector3d();
            };
            if (isStatic)
            {
                if (_SafeStr_3432 != null)
                {
                    if (((((_SafeStr_3432.height == _arg_1) && (Vector3d.isEqual(_cachedBitmapNormal, _arg_2))) && (_SafeStr_3436 == _arg_3)) && (_SafeStr_3437 == _arg_4)))
                    {
                        return (_SafeStr_3432);
                    };
                    _SafeStr_3432.dispose();
                    _SafeStr_3432 = null;
                };
            }
            else
            {
                if (_SafeStr_3432 != null)
                {
                    if (_SafeStr_3432.height == _arg_1)
                    {
                        _SafeStr_3432.fillRect(_SafeStr_3432.rect, 0xFFFFFF);
                    }
                    else
                    {
                        _SafeStr_3432.dispose();
                        _SafeStr_3432 = null;
                    };
                };
            };
            _SafeStr_3429 = true;
            if (_SafeStr_3432 == null)
            {
                try
                {
                    _SafeStr_3432 = new BitmapData(_width, _arg_1, true, 0xFFFFFF);
                }
                catch(e:Error)
                {
                    return (null);
                };
            };
            _cachedBitmapNormal.assign(_arg_2);
            _SafeStr_3436 = _arg_3;
            _SafeStr_3437 = _arg_4;
            if (_cells.length == 0)
            {
                return (_SafeStr_3432);
            };
            switch (_SafeStr_3435)
            {
                case 0:
                    renderRepeatNone(_arg_2);
                    break;
                case 2:
                    renderRepeatBorders(_arg_2);
                    break;
                case 3:
                    renderRepeatCenter(_arg_2);
                    break;
                case 4:
                    renderRepeatFirst(_arg_2);
                    break;
                case 5:
                    renderRepeatLast(_arg_2);
                    break;
                default:
                    renderRepeatAll(_arg_2, _arg_3, _arg_4);
            };
            return (_SafeStr_3432);
        }

        private function getCellsHeight(_arg_1:Array, _arg_2:IVector3d):int
        {
            var _local_3:int;
            var _local_5:PlaneMaterialCell;
            var _local_6:int;
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                return (0);
            };
            var _local_4:int;
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_5 = (_arg_1[_local_3] as PlaneMaterialCell);
                if (_local_5 != null)
                {
                    _local_6 = _local_5.getHeight(_arg_2);
                    _local_4 = (_local_4 + _local_6);
                };
                _local_3++;
            };
            return (_local_4);
        }

        private function renderCells(_arg_1:Array, _arg_2:int, _arg_3:Boolean, _arg_4:IVector3d, _arg_5:int=0, _arg_6:int=0):int
        {
            var _local_8:int;
            if ((((_arg_1 == null) || (_arg_1.length == 0)) || (_SafeStr_3432 == null)))
            {
                return (_arg_2);
            };
            var _local_9:PlaneMaterialCell;
            var _local_7:BitmapData;
            _local_8 = 0;
            while (_local_8 < _arg_1.length)
            {
                if (_arg_3)
                {
                    _local_9 = (_arg_1[_local_8] as PlaneMaterialCell);
                }
                else
                {
                    _local_9 = (_arg_1[((_arg_1.length - 1) - _local_8)] as PlaneMaterialCell);
                };
                if (_local_9 != null)
                {
                    _local_7 = _local_9.render(_arg_4, _arg_5, _arg_6);
                    if (_local_7 != null)
                    {
                        if (!_arg_3)
                        {
                            _arg_2 = (_arg_2 - _local_7.height);
                        };
                        _SafeStr_3432.copyPixels(_local_7, _local_7.rect, new Point(0, _arg_2), _local_7, null, true);
                        if (_arg_3)
                        {
                            _arg_2 = (_arg_2 + _local_7.height);
                        };
                        if ((((_arg_3) && (_arg_2 >= _SafeStr_3432.height)) || ((!(_arg_3)) && (_arg_2 <= 0))))
                        {
                            return (_arg_2);
                        };
                    };
                };
                _local_8++;
            };
            return (_arg_2);
        }

        private function renderRepeatNone(_arg_1:IVector3d):void
        {
            if (((_cells.length == 0) || (_SafeStr_3432 == null)))
            {
                return;
            };
            renderCells(_cells, 0, true, _arg_1);
        }

        private function renderRepeatAll(_arg_1:IVector3d, _arg_2:int, _arg_3:int):void
        {
            if (((_cells.length == 0) || (_SafeStr_3432 == null)))
            {
                return;
            };
            var _local_5:int = getCellsHeight(_cells, _arg_1);
            var _local_4:int;
            if (_local_5 > _SafeStr_3432.height)
            {
            };
            while (_local_4 < _SafeStr_3432.height)
            {
                _local_4 = renderCells(_cells, _local_4, true, _arg_1, _arg_2, _arg_3);
                if (_local_4 == 0)
                {
                    return;
                };
            };
        }

        private function renderRepeatBorders(_arg_1:IVector3d):void
        {
            if (((_cells.length == 0) || (_SafeStr_3432 == null)))
            {
                return;
            };
            var _local_8:PlaneMaterialCell;
            var _local_5:BitmapData;
            var _local_3:Array = [];
            var _local_2:int;
            var _local_9:int;
            var _local_6:int;
            _local_6 = 1;
            while (_local_6 < (_cells.length - 1))
            {
                _local_8 = (_cells[_local_6] as PlaneMaterialCell);
                if (_local_8 != null)
                {
                    _local_9 = _local_8.getHeight(_arg_1);
                    if (_local_9 > 0)
                    {
                        _local_2 = (_local_2 + _local_9);
                        _local_3.push(_local_8);
                    };
                };
                _local_6++;
            };
            if (_cells.length == 1)
            {
                _local_8 = (_cells[0] as PlaneMaterialCell);
                if (_local_8 != null)
                {
                    _local_9 = _local_8.getHeight(_arg_1);
                    if (_local_9 > 0)
                    {
                        _local_2 = (_local_2 + _local_9);
                        _local_3.push(_local_8);
                    };
                };
            };
            var _local_4:int = ((_SafeStr_3432.height - _local_2) >> 1);
            var _local_7:int = renderCells(_local_3, _local_4, true, _arg_1);
            _local_8 = (_cells[0] as PlaneMaterialCell);
            if (_local_8 != null)
            {
                _local_3 = [_local_8];
                while (_local_4 >= 0)
                {
                    _local_4 = renderCells(_local_3, _local_4, false, _arg_1);
                };
            };
            _local_8 = (_cells[(_cells.length - 1)] as PlaneMaterialCell);
            if (_local_8 != null)
            {
                _local_3 = [_local_8];
                while (_local_7 < _SafeStr_3432.height)
                {
                    _local_7 = renderCells(_local_3, _local_7, true, _arg_1);
                };
            };
        }

        private function renderRepeatCenter(_arg_1:IVector3d):void
        {
            var _local_7:int;
            var _local_6:int;
            var _local_3:int;
            var _local_8:Array;
            if (((_cells.length == 0) || (_SafeStr_3432 == null)))
            {
                return;
            };
            var _local_5:PlaneMaterialCell;
            var _local_9:BitmapData;
            var _local_11:Array = [];
            var _local_14:Array = [];
            var _local_10:int;
            var _local_12:int;
            var _local_16:int;
            var _local_4:int;
            _local_4 = 0;
            while (_local_4 < (_cells.length >> 1))
            {
                _local_5 = (_cells[_local_4] as PlaneMaterialCell);
                if (_local_5 != null)
                {
                    _local_16 = _local_5.getHeight(_arg_1);
                    if (_local_16 > 0)
                    {
                        _local_10 = (_local_10 + _local_16);
                        _local_11.push(_local_5);
                    };
                };
                _local_4++;
            };
            _local_4 = ((_cells.length >> 1) + 1);
            while (_local_4 < _cells.length)
            {
                _local_5 = (_cells[_local_4] as PlaneMaterialCell);
                if (_local_5 != null)
                {
                    _local_16 = _local_5.getHeight(_arg_1);
                    if (_local_16 > 0)
                    {
                        _local_12 = (_local_12 + _local_16);
                        _local_14.push(_local_5);
                    };
                };
                _local_4++;
            };
            var _local_13:int;
            var _local_2:int;
            var _local_15:int = _SafeStr_3432.height;
            if ((_local_10 + _local_12) > _SafeStr_3432.height)
            {
                _local_13 = ((_local_10 + _local_12) - _SafeStr_3432.height);
                _local_2 = (_local_2 - (_local_13 >> 1));
                _local_15 = (_local_15 + (_local_13 - (_local_13 >> 1)));
            };
            if (_local_13 == 0)
            {
                _local_5 = (_cells[(_cells.length >> 1)] as PlaneMaterialCell);
                if (_local_5 != null)
                {
                    _local_16 = _local_5.getHeight(_arg_1);
                    if (_local_16 > 0)
                    {
                        _local_7 = (_SafeStr_3432.height - (_local_10 + _local_12));
                        _local_6 = int((Math.ceil((_local_7 / _local_16)) * _local_16));
                        _local_2 = (_local_10 - ((_local_6 - _local_7) >> 1));
                        _local_3 = (_local_2 + _local_6);
                        _local_8 = [_local_5];
                        while (_local_2 < _local_3)
                        {
                            _local_2 = renderCells(_local_8, _local_2, true, _arg_1);
                        };
                    };
                };
            };
            _local_2 = 0;
            renderCells(_local_11, _local_2, true, _arg_1);
            renderCells(_local_14, _local_15, false, _arg_1);
        }

        private function renderRepeatFirst(_arg_1:IVector3d):void
        {
            var _local_2:Array;
            if (((_cells.length == 0) || (_SafeStr_3432 == null)))
            {
                return;
            };
            var _local_4:PlaneMaterialCell;
            var _local_3:int = _SafeStr_3432.height;
            _local_3 = renderCells(_cells, _local_3, false, _arg_1);
            _local_4 = (_cells[0] as PlaneMaterialCell);
            if (_local_4 != null)
            {
                _local_2 = [_local_4];
                while (_local_3 >= 0)
                {
                    _local_3 = renderCells(_local_2, _local_3, false, _arg_1);
                };
            };
        }

        private function renderRepeatLast(_arg_1:IVector3d):void
        {
            var _local_2:Array;
            if (((_cells.length == 0) || (_SafeStr_3432 == null)))
            {
                return;
            };
            var _local_4:PlaneMaterialCell;
            var _local_3:int;
            _local_3 = renderCells(_cells, _local_3, true, _arg_1);
            _local_4 = (_cells[(_cells.length - 1)] as PlaneMaterialCell);
            if (_local_4 != null)
            {
                _local_2 = [_local_4];
                while (_local_3 < _SafeStr_3432.height)
                {
                    _local_3 = renderCells(_local_2, _local_3, true, _arg_1);
                };
            };
        }

        public function getCells():Array
        {
            return (_cells);
        }


    }
}


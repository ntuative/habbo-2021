package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import flash.filters.ColorMatrixFilter;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;

    public class BitmapDataRenderer extends SkinRenderer 
    {

        protected static const _MATRIX:Matrix = new Matrix();
        protected static const _SafeStr_1101:ColorTransform = new ColorTransform();
        protected static const _SafeStr_1102:ColorTransform = new ColorTransform(0, 0, 0, 1, 1, 1, 1, 0);
        protected static const _GREYSCALE_FILTER:ColorMatrixFilter = new ColorMatrixFilter();
        protected static const _SafeStr_1103:Number = 0.212671;
        protected static const G:Number = 0.71516;
        protected static const B:Number = 0.072169;

        public function BitmapDataRenderer(_arg_1:String)
        {
            super(_arg_1);
        }

        override public function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_11:int;
            var _local_17:int;
            var _local_16:int;
            var _local_18:int;
            var _local_15:int;
            var _local_14:int;
            var _local_9:Number;
            var _local_8:Number;
            var _local_7:Number;
            var _local_13:int;
            var _local_12:int;
            var _local_6:IBitmapDataContainer = (_arg_1 as IBitmapDataContainer);
            var _local_10:BitmapData = _local_6.bitmapData;
            if (((!(_arg_2 == null)) && (!(_local_10 == null))))
            {
                _local_11 = (((_local_6.stretchedX) ? _arg_1.width : _local_10.width) * _local_6.zoomX);
                _local_17 = (((_local_6.stretchedY) ? _arg_1.height : _local_10.height) * _local_6.zoomY);
                _local_16 = ((_local_6.wrapX) ? ((_arg_1.width / _local_11) + 2) : 1);
                _local_18 = ((_local_6.wrapY) ? ((_arg_1.height / _local_17) + 2) : 1);
                _MATRIX.a = (_local_11 / _local_10.width);
                _MATRIX.d = (_local_17 / _local_10.height);
                switch (_local_6.pivotPoint)
                {
                    case 0:
                    case 3:
                    case 6:
                        _MATRIX.tx = ((_local_6.zoomX < 0) ? -(_local_11) : 0);
                        break;
                    case 1:
                    case 4:
                    case 7:
                        _MATRIX.tx = int(((_arg_1.width - _local_11) / 2));
                        break;
                    case 2:
                    case 5:
                    case 8:
                        _MATRIX.tx = ((_local_6.zoomX < 0) ? _arg_1.width : (_arg_1.width - _local_11));
                    default:
                };
                _local_15 = _MATRIX.tx;
                while (((_local_6.wrapX) && (_local_15 > 0)))
                {
                    _local_15 = (_local_15 - _local_11);
                };
                switch (_local_6.pivotPoint)
                {
                    case 0:
                    case 1:
                    case 2:
                        _MATRIX.ty = ((_local_6.zoomY < 0) ? -(_local_17) : 0);
                        break;
                    case 3:
                    case 4:
                    case 5:
                        _MATRIX.ty = int(((_arg_1.height - _local_17) / 2));
                        break;
                    case 6:
                    case 7:
                    case 8:
                        _MATRIX.ty = ((_local_6.zoomY < 0) ? _arg_1.height : (_arg_1.height - _local_17));
                    default:
                };
                _local_14 = _MATRIX.ty;
                while (((_local_6.wrapY) && (_local_14 > 0)))
                {
                    _local_14 = (_local_14 - _local_17);
                };
                _local_9 = (((_arg_1.color & 0xFF0000) >> 16) / 0xFF);
                _local_8 = (((_arg_1.color & 0xFF00) >> 8) / 0xFF);
                _local_7 = ((_arg_1.color & 0xFF) / 0xFF);
                _SafeStr_1102.alphaMultiplier = (((_local_6.etchingColor >> 24) & 0xFF) / 0xFF);
                _SafeStr_1102.redOffset = ((_local_6.etchingColor >> 16) & 0xFF);
                _SafeStr_1102.greenOffset = ((_local_6.etchingColor >> 8) & 0xFF);
                _SafeStr_1102.blueOffset = (_local_6.etchingColor & 0xFF);
                _arg_2.lock();
                _MATRIX.ty = _local_14;
                _local_13 = 0;
                while (_local_13 < _local_18)
                {
                    _MATRIX.tx = _local_15;
                    _local_12 = 0;
                    while (_local_12 < _local_16)
                    {
                        if (_local_6.greyscale)
                        {
                            _GREYSCALE_FILTER.matrix = [(_local_9 * 0.212671), (_local_9 * 0.71516), (_local_9 * 0.072169), 0, 0, (_local_8 * 0.212671), (_local_8 * 0.71516), (_local_8 * 0.072169), 0, 0, (_local_7 * 0.212671), (_local_7 * 0.71516), (_local_7 * 0.072169), 0, 0, 0, 0, 0, 1, 0];
                            if (_SafeStr_1102.alphaMultiplier >= 0.001)
                            {
                                _MATRIX.tx = (_MATRIX.tx + _local_6.etchingPoint.x);
                                _MATRIX.ty = (_MATRIX.ty + _local_6.etchingPoint.y);
                                _arg_2.draw(_local_10, _MATRIX, _SafeStr_1102, null, null, false);
                                _MATRIX.tx = (_MATRIX.tx - _local_6.etchingPoint.x);
                                _MATRIX.ty = (_MATRIX.ty - _local_6.etchingPoint.y);
                            };
                            _arg_2.draw(_local_10, _MATRIX, null, null, null, false);
                            _arg_2.applyFilter(_arg_2, _arg_2.rect, new Point(), _GREYSCALE_FILTER);
                        }
                        else
                        {
                            _SafeStr_1101.redMultiplier = _local_9;
                            _SafeStr_1101.greenMultiplier = _local_8;
                            _SafeStr_1101.blueMultiplier = _local_7;
                            _SafeStr_1101.alphaMultiplier = 1;
                            _SafeStr_1101.redOffset = 0;
                            _SafeStr_1101.greenOffset = 0;
                            _SafeStr_1101.blueOffset = 0;
                            _SafeStr_1101.alphaOffset = 0;
                            if (_arg_1.dynamicStyleColor)
                            {
                                _SafeStr_1101.concat(_arg_1.dynamicStyleColor);
                            };
                            if (_SafeStr_1102.alphaMultiplier >= 0.001)
                            {
                                _MATRIX.tx = (_MATRIX.tx + _local_6.etchingPoint.x);
                                _MATRIX.ty = (_MATRIX.ty + _local_6.etchingPoint.y);
                                _arg_2.draw(_local_10, _MATRIX, _SafeStr_1102, null, null, false);
                                _MATRIX.tx = (_MATRIX.tx - _local_6.etchingPoint.x);
                                _MATRIX.ty = (_MATRIX.ty - _local_6.etchingPoint.y);
                            };
                            _arg_2.draw(_local_10, _MATRIX, _SafeStr_1101, null, null, false);
                        };
                        _MATRIX.tx = (_MATRIX.tx + _local_11);
                        _local_12++;
                    };
                    _MATRIX.ty = (_MATRIX.ty + _local_17);
                    _local_13++;
                };
                _arg_2.unlock();
            };
        }

        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (_arg_1 == 0);
        }


    }
}


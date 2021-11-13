package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import flash.display.BitmapData;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;

    public class WindowRendererItem implements IDisposable 
    {

        protected static const RENDER_TYPE_NULL:uint = 0;
        protected static const RENDER_TYPE_SKIN:uint = 1;
        protected static const RENDER_TYPE_FILL:uint = 2;
        protected static const MATRIX:Matrix = new Matrix();
        protected static const COLOR_TRANSFORM:ColorTransform = new ColorTransform();

        protected var _SafeStr_1132:TrackedBitmapData;
        protected var _SafeStr_437:ISkinContainer;
        protected var _disposed:Boolean;
        protected var _refresh:Boolean;
        protected var _SafeStr_1133:uint;
        protected var _SafeStr_1134:uint;

        public function WindowRendererItem(_arg_1:ISkinContainer)
        {
            _disposed = false;
            _SafeStr_437 = _arg_1;
            _SafeStr_1133 = 0xFFFFFFFF;
            _SafeStr_1134 = 0;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get buffer():BitmapData
        {
            return (_SafeStr_1132);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
                _SafeStr_437 = null;
                if (_SafeStr_1132 != null)
                {
                    _SafeStr_1132.dispose();
                    _SafeStr_1132 = null;
                };
            };
        }

        public function purge():void
        {
        }

        public function render(_arg_1:IWindow, _arg_2:Point, _arg_3:Rectangle, _arg_4:Rectangle, _arg_5:BitmapData):BitmapData
        {
            var _local_12:Boolean;
            var _local_6:BitmapData;
            var _local_13:uint = ((_arg_1.background) ? 2 : 0);
            var _local_7:ISkinRenderer = _SafeStr_437.getSkinRendererByTypeAndStyle(_arg_1.type, _arg_1.style);
            if (_local_7 != null)
            {
                if (_local_7.isStateDrawable(_SafeStr_1134))
                {
                    _local_13 = 1;
                };
            };
            var _local_11:int = Math.max(_arg_1.renderingWidth, 1);
            var _local_8:int = Math.max(_arg_1.renderingHeight, 1);
            var _local_9:Boolean = true;
            if (_local_13 != 0)
            {
                if ((((!(_SafeStr_1132)) || (!(_SafeStr_1132.width == _local_11))) || (!(_SafeStr_1132.height == _local_8))))
                {
                    if (_SafeStr_1132)
                    {
                        _SafeStr_1132.dispose();
                    };
                    _SafeStr_1132 = new TrackedBitmapData(this, _local_11, _local_8, true, _arg_1.color);
                    _refresh = true;
                    _local_9 = false;
                };
            };
            var _local_14:IGraphicContext = IGraphicContextHost(_arg_1).getGraphicContext(false);
            if (_local_14)
            {
                if (!_local_14.visible)
                {
                    _local_14.visible = true;
                };
                _local_12 = _arg_1.testParamFlag(0x40000000);
                _local_6 = _local_14.setDrawRegion(_arg_1.renderingRectangle, (!(_arg_1.testParamFlag(16))), ((_local_12) ? _arg_4 : null));
                if (_local_6)
                {
                    _arg_5 = _local_6;
                    _refresh = true;
                };
            };
            var _local_10:Boolean = (!(_arg_1.testParamFlag(16)));
            if (_local_13 != 0)
            {
                if (_arg_5 != null)
                {
                    _arg_5.lock();
                    if (_local_13 == 1)
                    {
                        if (_refresh)
                        {
                            if (_local_10)
                            {
                                _arg_5.fillRect(_arg_3, 0);
                            };
                            _refresh = false;
                            if (_local_9)
                            {
                                _SafeStr_1132.fillRect(_SafeStr_1132.rect, _arg_1.color);
                            };
                            _local_7.draw(_arg_1, _SafeStr_1132, _SafeStr_1132.rect, _SafeStr_1134, false);
                        };
                        if (((_arg_1.blend < 1) && (!(_local_10))))
                        {
                            MATRIX.tx = (_arg_2.x - _arg_3.x);
                            MATRIX.ty = (_arg_2.y - _arg_3.y);
                            COLOR_TRANSFORM.alphaMultiplier = _arg_1.blend;
                            _arg_3.offset(MATRIX.tx, MATRIX.ty);
                            _arg_5.draw(_SafeStr_1132, MATRIX, COLOR_TRANSFORM, null, _arg_3, false);
                            _arg_3.offset(-(MATRIX.tx), -(MATRIX.ty));
                        }
                        else
                        {
                            _arg_5.copyPixels(_SafeStr_1132, _arg_3, _arg_2, null, null, true);
                        };
                    }
                    else
                    {
                        if (_local_13 == 2)
                        {
                            if (!_local_10)
                            {
                                _SafeStr_1132.fillRect(_SafeStr_1132.rect, _arg_1.color);
                                _arg_5.copyPixels(_SafeStr_1132, _arg_3, _arg_2, null, null, true);
                            }
                            else
                            {
                                _arg_5.fillRect(new Rectangle(_arg_2.x, _arg_2.y, _arg_3.width, _arg_3.height), _arg_1.color);
                                _local_14.blend = _arg_1.blend;
                            };
                        };
                    };
                    _arg_5.unlock();
                };
            }
            else
            {
                if (((_refresh) && (_local_10)))
                {
                    _refresh = false;
                    if (_arg_5 != null)
                    {
                        _arg_5.fillRect(_arg_3, 0);
                    };
                };
            };
            _SafeStr_1133 = _SafeStr_1134;
            return (_arg_5);
        }

        public function testForStateChange(_arg_1:IWindow):Boolean
        {
            return (!(_SafeStr_437.getTheActualState(_arg_1.type, _arg_1.style, _arg_1.state) == _SafeStr_1133));
        }

        public function invalidate(_arg_1:IWindow, _arg_2:uint):Boolean
        {
            var _local_4:IGraphicContext;
            var _local_3:Boolean;
            switch (_arg_2)
            {
                case 1:
                    _refresh = true;
                    _local_3 = true;
                    break;
                case 2:
                    _refresh = true;
                    _local_3 = true;
                    break;
                case 4:
                    if (_arg_1.testParamFlag(16))
                    {
                        _local_3 = true;
                    }
                    else
                    {
                        _local_4 = IGraphicContextHost(_arg_1).getGraphicContext(true);
                        _local_4.setDrawRegion(_arg_1.renderingRectangle, false, null);
                        if (!_local_4.visible)
                        {
                            _local_3 = true;
                        };
                    };
                    break;
                case 8:
                    _SafeStr_1134 = _SafeStr_437.getTheActualState(_arg_1.type, _arg_1.style, _arg_1.state);
                    if (_SafeStr_1134 != _SafeStr_1133)
                    {
                        _refresh = true;
                        _local_3 = true;
                    };
                    break;
                case 16:
                    if (_arg_1.testParamFlag(16))
                    {
                        _refresh = true;
                        _local_3 = true;
                    }
                    else
                    {
                        IGraphicContextHost(_arg_1).getGraphicContext(true).blend = _arg_1.blend;
                    };
                    break;
                case 32:
                    _local_3 = true;
            };
            return (_local_3);
        }

        private function drawRect(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:uint):void
        {
            var _local_4:int;
            _local_4 = _arg_2.left;
            while (_local_4 < _arg_2.right)
            {
                _arg_1.setPixel32(_local_4, _arg_2.top, _arg_3);
                _arg_1.setPixel32(_local_4, (_arg_2.bottom - 1), _arg_3);
                _local_4++;
            };
            _local_4 = _arg_2.top;
            while (_local_4 < _arg_2.bottom)
            {
                _arg_1.setPixel32(_arg_2.left, _local_4, _arg_3);
                _arg_1.setPixel32((_arg_2.right - 1), _local_4, _arg_3);
                _local_4++;
            };
        }


    }
}


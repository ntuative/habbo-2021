package com.sulake.core.window.graphics
{
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.utils.IChildWindowHost;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.events.WindowDisposeEvent;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import flash.display.BitmapData;

    public class WindowRenderer implements IWindowRenderer 
    {

        protected static const RECT:Rectangle = new Rectangle();
        protected static const MAX_DIRTY_REGIONS_PER_WINDOW:int = 3;
        protected static const MAX_DISTANCE_BEFORE_COMBINE:int = 10;

        protected var _SafeStr_845:Boolean = false;
        protected var _disposed:Boolean;
        protected var _SafeStr_437:ISkinContainer;
        protected var _SafeStr_1129:Dictionary;
        protected var _SafeStr_1130:Vector.<IWindow>;
        protected var _SafeStr_1131:Vector.<Array>;
        protected var _drawLocation:Point;
        protected var _clipRegion:Rectangle;
        protected var _dirtyRegion:Rectangle;
        protected var _visibleRegion:Rectangle;

        public function WindowRenderer(_arg_1:ISkinContainer)
        {
            _disposed = false;
            _SafeStr_437 = _arg_1;
            _SafeStr_1129 = new Dictionary(false);
            _SafeStr_1130 = new Vector.<IWindow>();
            _SafeStr_1131 = new Vector.<Array>();
            _drawLocation = new Point();
            _clipRegion = new Rectangle();
            _dirtyRegion = new Rectangle();
            _visibleRegion = new Rectangle();
        }

        private static function areRectanglesCloseEnough(_arg_1:Rectangle, _arg_2:Rectangle, _arg_3:uint):Boolean
        {
            if (_arg_1.intersects(_arg_2))
            {
                return (true);
            };
            return ((((_arg_1.left > _arg_2.left) ? (_arg_1.left - _arg_2.right) : (_arg_2.left - _arg_1.right)) <= _arg_3) && (((_arg_1.top > _arg_2.top) ? (_arg_1.top - _arg_2.bottom) : (_arg_2.top - _arg_1.bottom)) <= _arg_3));
        }

        private static function getDrawLocationAndClipRegion(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:Point, _arg_4:Rectangle):Boolean
        {
            var _local_6:int;
            var _local_5:Boolean = true;
            _arg_4.x = 0;
            _arg_4.y = 0;
            _arg_4.width = _arg_1.renderingWidth;
            _arg_4.height = _arg_1.renderingHeight;
            if (!_arg_1.testParamFlag(16))
            {
                if (((_arg_1.parent) && (_arg_1.testParamFlag(0x40000000))))
                {
                    _local_5 = childRectToClippedDrawRegion(_arg_1.parent, _arg_3, _arg_4);
                    _arg_3.x = _arg_4.x;
                    _arg_3.y = _arg_4.y;
                }
                else
                {
                    _arg_3.x = 0;
                    _arg_3.y = 0;
                };
            }
            else
            {
                if (_arg_1.parent)
                {
                    _local_5 = childRectToClippedDrawRegion(_arg_1.parent, _arg_3, _arg_4);
                }
                else
                {
                    _arg_3.x = 0;
                    _arg_3.y = 0;
                };
            };
            if (_arg_2.x > _arg_4.x)
            {
                _local_6 = (_arg_2.x - _arg_4.x);
                _arg_3.x = (_arg_3.x + _local_6);
                _arg_4.x = (_arg_4.x + _local_6);
                _arg_4.width = (_arg_4.width - _local_6);
            };
            if (_arg_2.y > _arg_4.y)
            {
                _local_6 = (_arg_2.y - _arg_4.y);
                _arg_3.y = (_arg_3.y + _local_6);
                _arg_4.y = (_arg_4.y + _local_6);
                _arg_4.height = (_arg_4.height - _local_6);
            };
            if (_arg_2.right < _arg_4.right)
            {
                _local_6 = (_arg_4.right - _arg_2.right);
                _arg_4.width = (_arg_4.width - _local_6);
            };
            if (_arg_2.bottom < _arg_4.bottom)
            {
                _local_6 = (_arg_4.bottom - _arg_2.bottom);
                _arg_4.height = (_arg_4.height - _local_6);
            };
            return (((_local_5) && (_arg_4.width > 0)) && (_arg_4.height > 0));
        }

        private static function childRectToClippedDrawRegion(_arg_1:IWindow, _arg_2:Point, _arg_3:Rectangle):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            if (_arg_1.testParamFlag(16))
            {
                _local_5 = _arg_1.renderingX;
                _local_6 = _arg_1.renderingY;
                _arg_2.offset(_local_5, _local_6);
                if (_arg_1.clipping)
                {
                    if (_arg_2.x < _local_5)
                    {
                        _local_4 = (_local_5 - _arg_2.x);
                        _arg_3.x = (_arg_3.x + _local_4);
                        _arg_3.width = (_arg_3.width - _local_4);
                        _arg_2.x = _local_5;
                    };
                    if (_arg_2.x < 0)
                    {
                        _arg_3.x = (_arg_3.x - _arg_2.x);
                        _arg_3.width = (_arg_3.width + _arg_2.x);
                        _arg_2.x = 0;
                    };
                    if (_arg_2.y < _local_6)
                    {
                        _local_4 = (_local_6 - _arg_2.y);
                        _arg_3.y = (_arg_3.y + _local_4);
                        _arg_3.height = (_arg_3.height - _local_4);
                        _arg_2.y = _local_6;
                    };
                    if (_arg_2.y < 0)
                    {
                        _arg_3.y = (_arg_3.y - _arg_2.y);
                        _arg_3.height = (_arg_3.height + _arg_2.y);
                        _arg_2.y = 0;
                    };
                    if ((_arg_2.x + _arg_3.width) > (_local_5 + _arg_1.renderingWidth))
                    {
                        _arg_3.width = (_arg_3.width - ((_arg_2.x + _arg_3.width) - (_local_5 + _arg_1.renderingWidth)));
                    };
                    if ((_arg_2.y + _arg_3.height) > (_local_6 + _arg_1.renderingHeight))
                    {
                        _arg_3.height = (_arg_3.height - ((_arg_2.y + _arg_3.height) - (_local_6 + _arg_1.renderingHeight)));
                    };
                };
                if (_arg_1.parent)
                {
                    childRectToClippedDrawRegion(_arg_1.parent, _arg_2, _arg_3);
                };
            }
            else
            {
                if (_arg_1.clipping)
                {
                    if (_arg_2.x < 0)
                    {
                        _local_4 = _arg_2.x;
                        _arg_3.x = (_arg_3.x - _local_4);
                        _arg_3.width = (_arg_3.width + _local_4);
                        _arg_2.x = 0;
                    };
                    if (_arg_2.y < 0)
                    {
                        _local_4 = _arg_2.y;
                        _arg_3.y = (_arg_3.y - _local_4);
                        _arg_3.height = (_arg_3.height + _local_4);
                        _arg_2.y = 0;
                    };
                };
            };
            return ((_arg_3.width > 0) && (_arg_3.height > 0));
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set debug(_arg_1:Boolean):void
        {
            _SafeStr_845 = _arg_1;
        }

        public function get debug():Boolean
        {
            return (_SafeStr_845);
        }

        public function dispose():void
        {
            var _local_1:WindowRendererItem;
            if (!_disposed)
            {
                _disposed = true;
                for (var _local_2:Object in _SafeStr_1129)
                {
                    _local_1 = (_SafeStr_1129[_local_2] as WindowRendererItem);
                    _local_1.dispose();
                    delete _SafeStr_1129[_local_2];
                };
                _SafeStr_1129 = null;
                _SafeStr_1130 = null;
                _SafeStr_1131 = null;
            };
        }

        public function purge(_arg_1:IWindow=null, _arg_2:Boolean=true):void
        {
            var _local_3:WindowRendererItem;
            var _local_5:IChildWindowHost;
            var _local_4:Vector.<IWindow> = undefined;
            if (_arg_1)
            {
                if (((!(_arg_1.visible)) || (!(_arg_2))))
                {
                    _local_3 = _SafeStr_1129[_arg_1];
                    if (_local_3)
                    {
                        _local_3.dispose();
                        delete _SafeStr_1129[_arg_1];
                    };
                    _arg_2 = false;
                };
                _local_5 = (_arg_1 as IChildWindowHost);
                if (_local_5)
                {
                    for each (_arg_1 in _local_5.children)
                    {
                        purge(_arg_1, _arg_2);
                    };
                };
            }
            else
            {
                _local_4 = new Vector.<IWindow>();
                for (var _local_6:Object in _SafeStr_1129)
                {
                    _arg_1 = (_local_6 as IWindow);
                    if ((((!(_arg_1.visible)) || (!(_arg_2))) || ((_arg_1.parent == null) && (!(_arg_1 is IDesktopWindow)))))
                    {
                        _local_4.push(_arg_1);
                    };
                };
                while (_local_4.length)
                {
                    purge(_local_4.pop(), _arg_2);
                };
            };
        }

        public function addToRenderQueue(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void
        {
            var _local_8:int;
            var _local_12:int;
            var _local_4:IWindow;
            var _local_5:Array;
            var _local_10:int;
            var _local_6:Rectangle;
            var _local_11:Rectangle;
            if (!_arg_2)
            {
                _arg_2 = _dirtyRegion;
                _dirtyRegion.x = 0;
                _dirtyRegion.y = 0;
                _dirtyRegion.width = _arg_1.renderingWidth;
                _dirtyRegion.height = _arg_1.renderingHeight;
            }
            else
            {
                _dirtyRegion.x = _arg_2.x;
                _dirtyRegion.y = _arg_2.y;
                _dirtyRegion.width = _arg_2.width;
                _dirtyRegion.height = _arg_2.height;
            };
            if (_arg_2.isEmpty())
            {
                return;
            };
            if (getWindowRendererItem(_arg_1).invalidate(_arg_1, _arg_3))
            {
                if (((_arg_1.testParamFlag(16)) || (_arg_1.testParamFlag(0x40000000))))
                {
                    var _local_7:IDesktopWindow = _arg_1.context.getDesktopWindow();
                    while (true)
                    {
                        _local_4 = _arg_1.parent;
                        if (_local_4 == null)
                        {
                            return;
                        };
                        if (_local_4 == _local_7) break;
                        if (!_local_4.visible)
                        {
                            return;
                        };
                        _local_8 = _local_4.renderingWidth;
                        _local_12 = _local_4.renderingHeight;
                        _dirtyRegion.offset(_arg_1.renderingX, _arg_1.renderingY);
                        if (_local_4.clipping)
                        {
                            if (((((_dirtyRegion.x > _local_8) || (_dirtyRegion.y > _local_12)) || (_dirtyRegion.right < 0)) || (_dirtyRegion.bottom < 0)))
                            {
                                return;
                            };
                            if (_dirtyRegion.x < 0)
                            {
                                _dirtyRegion.width = (_dirtyRegion.width + _dirtyRegion.x);
                                _dirtyRegion.x = 0;
                            };
                            if (_dirtyRegion.y < 0)
                            {
                                _dirtyRegion.height = (_dirtyRegion.height + _dirtyRegion.y);
                                _dirtyRegion.y = 0;
                            };
                            if (_dirtyRegion.right > _local_8)
                            {
                                _dirtyRegion.right = _local_8;
                            };
                            if (_dirtyRegion.bottom > _local_12)
                            {
                                _dirtyRegion.bottom = _local_12;
                            };
                        };
                        if (_dirtyRegion.isEmpty())
                        {
                            return;
                        };
                        _arg_1 = _local_4;
                        if (((!(_arg_1.testParamFlag(16))) && (!(_arg_1.testParamFlag(0x40000000))))) break;
                    };
                };
                getWindowRendererItem(_arg_1).invalidate(_arg_1, 32);
                _local_10 = _SafeStr_1130.indexOf(_arg_1);
                if (_local_10 > -1)
                {
                    _local_5 = _SafeStr_1131[_local_10];
                    _local_11 = _dirtyRegion;
                    var _local_9:int = _local_5.length;
                    if (_local_9 > 3)
                    {
                        _local_11 = _local_11.union(_local_5.pop());
                        _local_9--;
                    };
                    _local_10 = 0;
                    while (_local_10 < _local_9)
                    {
                        _local_6 = _local_5[_local_10++];
                        if (((((_local_6.left > _local_11.left) ? (_local_6.left - _local_11.right) : (_local_11.left - _local_6.right)) <= 10) && (((_local_6.top > _local_11.top) ? (_local_6.top - _local_11.bottom) : (_local_11.top - _local_6.bottom)) <= 10)))
                        {
                            _local_5.splice((_local_10 - 1), 1);
                            _local_11 = _local_11.union(_local_6);
                            _local_9--;
                            _local_10 = 0;
                        };
                    };
                    _local_5.push(((_local_11 == _dirtyRegion) ? _local_11.clone() : _local_11));
                }
                else
                {
                    _SafeStr_1130.push(_arg_1);
                    _SafeStr_1131.push([_dirtyRegion.clone()]);
                };
            };
        }

        public function flushRenderQueue():void
        {
            if (((_SafeStr_1130.length) || (_SafeStr_1131.length)))
            {
                _SafeStr_1130.splice(0, _SafeStr_1130.length);
                _SafeStr_1131.splice(0, _SafeStr_1131.length);
            };
        }

        public function invalidate(_arg_1:IWindowContext, _arg_2:Rectangle):void
        {
            var _local_5:IWindow;
            var _local_4:IDesktopWindow;
            _local_4 = _arg_1.getDesktopWindow();
            var _local_3:uint = _local_4.numChildren;
            while (_local_3-- > 0)
            {
                _local_5 = _local_4.getChildAt(_local_3);
                addToRenderQueue(_local_5, null, 1);
            };
        }

        protected function getWindowRendererItem(_arg_1:IWindow):WindowRendererItem
        {
            var _local_2:WindowRendererItem = (_SafeStr_1129[_arg_1] as WindowRendererItem);
            if (_local_2 == null)
            {
                registerRenderable(_arg_1);
                _local_2 = _SafeStr_1129[_arg_1];
            };
            return (_local_2);
        }

        public function registerRenderable(_arg_1:IWindow):void
        {
            var _local_2:WindowRendererItem = (_SafeStr_1129[_arg_1] as WindowRendererItem);
            if (_local_2 == null)
            {
                _local_2 = new WindowRendererItem(_SafeStr_437);
                _SafeStr_1129[_arg_1] = _local_2;
                _arg_1.addEventListener("WINDOW_DISPOSE_EVENT", windowDisposedCallback);
            };
        }

        public function removeRenderable(_arg_1:IWindow):void
        {
            _arg_1.removeEventListener("WINDOW_DISPOSE_EVENT", windowDisposedCallback);
            var _local_2:WindowRendererItem = (_SafeStr_1129[_arg_1] as WindowRendererItem);
            if (_local_2 != null)
            {
                _local_2.dispose();
                delete _SafeStr_1129[_arg_1];
            };
        }

        protected function windowDisposedCallback(_arg_1:WindowDisposeEvent):void
        {
            removeRenderable(_arg_1.window);
        }

        public function getDrawBufferForRenderable(_arg_1:IWindow):BitmapData
        {
            var _local_2:Rectangle;
            var _local_4:TrackedBitmapData;
            var _local_3:WindowRendererItem = (_SafeStr_1129[_arg_1] as WindowRendererItem);
            if (!_local_3)
            {
                _local_2 = new Rectangle(0, 0, _arg_1.renderingWidth, _arg_1.renderingHeight);
                _local_4 = new TrackedBitmapData(this, _arg_1.renderingWidth, _arg_1.renderingHeight);
                _local_3 = new WindowRendererItem(_SafeStr_437);
                _local_3.invalidate(_arg_1, 1);
                _local_3.render(_arg_1, new Point(), _local_2, _arg_1.renderingRectangle, _local_4);
                _local_4.dispose();
                _SafeStr_1129[_arg_1] = _local_3;
            };
            return ((_local_3 != null) ? _local_3.buffer : null);
        }

        public function render():void
        {
            var _local_1:Rectangle;
            var _local_2:Array;
            var _local_4:BitmapData;
            var _local_5:IWindow;
            var _local_3:uint = _SafeStr_1130.length;
            while (_local_3-- > 0)
            {
                _local_5 = _SafeStr_1130.pop();
                _local_2 = _SafeStr_1131.pop();
                if (!_local_5.disposed)
                {
                    _local_4 = (_local_5.fetchDrawBuffer() as BitmapData);
                    for each (_local_1 in _local_2)
                    {
                        _visibleRegion.x = _local_5.renderingX;
                        _visibleRegion.y = _local_5.renderingY;
                        _visibleRegion.width = _local_5.renderingWidth;
                        _visibleRegion.height = _local_5.renderingHeight;
                        renderWindowBranch(_local_5, _local_1, _visibleRegion, _local_4);
                    };
                };
            };
        }

        private function renderWindowBranch(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:Rectangle, _arg_4:BitmapData):void
        {
            var _local_8:IWindow;
            var _local_6:IGraphicContextHost;
            var _local_5:Vector.<IWindow> = undefined;
            var _local_7:IGraphicContext = IGraphicContextHost(_arg_1).getGraphicContext(false);
            if (_local_7)
            {
                _local_7.visible = _arg_1.visible;
            };
            if (_arg_1.visible)
            {
                _drawLocation.x = _arg_1.renderingX;
                _drawLocation.y = _arg_1.renderingY;
                if (getDrawLocationAndClipRegion(_arg_1, _arg_2, _drawLocation, _clipRegion))
                {
                    if (_arg_1.clipping)
                    {
                        _arg_3 = _arg_3.intersection(_arg_1.renderingRectangle);
                    };
                    _arg_3.offset(-(_arg_1.x), -(_arg_1.y));
                    _arg_4 = getWindowRendererItem(_arg_1).render(_arg_1, _drawLocation, _clipRegion, _arg_3, _arg_4);
                    if (!(_arg_1 is IChildWindowHost))
                    {
                        return;
                    };
                    _local_5 = IChildWindowHost(_arg_1).children;
                    if (!_local_5)
                    {
                        return;
                    };
                    if (_arg_1.clipping)
                    {
                        _arg_2 = _arg_2.clone();
                        if (_arg_2.x < 0)
                        {
                            _arg_2.width = (_arg_2.width + _arg_2.x);
                            _arg_2.x = 0;
                        };
                        if (_arg_2.y < 0)
                        {
                            _arg_2.height = (_arg_2.height + _arg_2.y);
                            _arg_2.y = 0;
                        };
                        if (_arg_2.width > _arg_1.width)
                        {
                            _arg_2.width = _arg_1.renderingWidth;
                        };
                        if (_arg_2.height > _arg_1.height)
                        {
                            _arg_2.height = _arg_1.renderingHeight;
                        };
                    };
                    for each (_local_8 in _local_5)
                    {
                        RECT.x = _local_8.x;
                        RECT.y = _local_8.y;
                        RECT.width = _local_8.width;
                        RECT.height = _local_8.height;
                        if (RECT.intersects(_arg_2))
                        {
                            if (_local_8.testParamFlag(16))
                            {
                                _arg_2.offset(-(_local_8.x), -(_local_8.y));
                                renderWindowBranch(_local_8, _arg_2, _arg_3, _arg_4);
                                _arg_2.offset(_local_8.x, _local_8.y);
                            }
                            else
                            {
                                if (_local_8.testParamFlag(0x40000000))
                                {
                                    _arg_2.offset(-(_local_8.x), -(_local_8.y));
                                    renderWindowBranch(_local_8, _arg_2, _arg_3, (_local_8.fetchDrawBuffer() as BitmapData));
                                    _arg_2.offset(_local_8.x, _local_8.y);
                                }
                                else
                                {
                                    if (_local_8.visible)
                                    {
                                        _local_6 = IGraphicContextHost(_local_8);
                                        if (_local_6.hasGraphicsContext())
                                        {
                                            _local_6.getGraphicContext(true).visible = true;
                                        };
                                    };
                                };
                            };
                        }
                        else
                        {
                            if (!RECT.intersects(_arg_3))
                            {
                                _local_6 = IGraphicContextHost(_local_8);
                                if (_local_6.hasGraphicsContext())
                                {
                                    _local_6.getGraphicContext(true).visible = false;
                                };
                            };
                        };
                    };
                    _arg_3.offset(_arg_1.renderingX, _arg_1.renderingY);
                }
                else
                {
                    if (!_arg_1.testParamFlag(16))
                    {
                        if (_arg_1.testParamFlag(0x40000000))
                        {
                            if (!_local_7)
                            {
                                _local_7 = IGraphicContextHost(_arg_1).getGraphicContext(true);
                            };
                            _local_7.setDrawRegion(_arg_1.renderingRectangle, false, _clipRegion);
                            _local_7.visible = false;
                        };
                    };
                };
            };
        }


    }
}


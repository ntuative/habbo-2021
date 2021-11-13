package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.IWindowContainer;

    public class ScrollBarController extends InteractiveController implements IScrollbarWindow, ITouchAwareWindow 
    {

        private static const SCROLL_BUTTON_INCREMENT:String = "increment";
        private static const SCROLL_BUTTON_DECREMENT:String = "decrement";
        private static const SCROLL_SLIDER_TRACK:String = "slider_track";
        private static const SCROLL_SLIDER_BAR:String = "slider_bar";

        protected var _offset:Number = 0;
        protected var _SafeStr_938:Number = 0.1;
        protected var _SafeStr_937:IScrollableWindow;
        private var _horizontal:Boolean;
        private var _targetName:String;
        private var _SafeStr_939:Boolean = false;

        public function ScrollBarController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0, _arg_12:IScrollableWindow=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_899 = false;
            _SafeStr_937 = _arg_12;
            _horizontal = (_arg_2 == 130);
            var _local_13:Array = [];
            groupChildrenWithTag("_INTERNAL", _local_13, -1);
            for each (var _local_14:IWindow in _local_13)
            {
                _local_14.procedure = scrollButtonEventProc;
            };
            updateLiftSizeAndPosition();
        }

        public function get scrollH():Number
        {
            return ((_horizontal) ? _offset : 0);
        }

        public function get scrollV():Number
        {
            return ((_horizontal) ? 0 : _offset);
        }

        public function get scrollable():IScrollableWindow
        {
            return (_SafeStr_937);
        }

        public function set scrollH(_arg_1:Number):void
        {
            if (_horizontal)
            {
                if (setScrollPosition(_arg_1))
                {
                    updateLiftSizeAndPosition();
                };
            };
        }

        public function set scrollV(_arg_1:Number):void
        {
            if (!_horizontal)
            {
                if (setScrollPosition(_arg_1))
                {
                    updateLiftSizeAndPosition();
                };
            };
        }

        public function set scrollable(_arg_1:IScrollableWindow):void
        {
            if (((!(_SafeStr_937 == null)) && (!(_SafeStr_937.disposed))))
            {
                _SafeStr_937.removeEventListener("WE_RESIZED", onScrollableResized);
                _SafeStr_937.removeEventListener("WE_SCROLL", onScrollableScrolled);
            };
            _SafeStr_937 = _arg_1;
            if (((!(_SafeStr_937 == null)) && (!(_SafeStr_937.disposed))))
            {
                _SafeStr_937.addEventListener("WE_RESIZED", onScrollableResized);
                _SafeStr_937.addEventListener("WE_SCROLL", onScrollableScrolled);
                updateLiftSizeAndPosition();
            };
        }

        public function get horizontal():Boolean
        {
            return (_horizontal);
        }

        public function get vertical():Boolean
        {
            return (!(_horizontal));
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            var _local_2:String;
            if ((_SafeStr_937 is IWindow))
            {
                _local_2 = IWindow(_SafeStr_937).name;
            }
            else
            {
                if (_targetName != null)
                {
                    _local_2 = _targetName;
                };
            };
            if (_local_2 == null)
            {
                _local_1.push(getDefaultProperty("scrollable"));
            }
            else
            {
                _local_1.push(createProperty("scrollable", _local_2));
            };
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "scrollable":
                        _targetName = (_local_2.value as String);
                        _SafeStr_937 = null;
                };
            };
            super.properties = _arg_1;
        }

        protected function get track():WindowController
        {
            return (findChildByName("slider_track") as WindowController);
        }

        protected function get lift():WindowController
        {
            return (track.findChildByName("slider_bar") as WindowController);
        }

        override public function dispose():void
        {
            scrollable = null;
            super.dispose();
        }

        override public function enable():Boolean
        {
            var _local_1:Array;
            var _local_2:uint;
            if (super.enable())
            {
                _local_1 = [];
                groupChildrenWithTag("_INTERNAL", _local_1, -1);
                _local_2 = 0;
                while (_local_2 < _local_1.length)
                {
                    IWindow(_local_1[_local_2]).enable();
                    _local_2++;
                };
                return (true);
            };
            return (false);
        }

        override public function disable():Boolean
        {
            var _local_1:Array;
            var _local_2:uint;
            if (super.disable())
            {
                _local_1 = [];
                groupChildrenWithTag("_INTERNAL", _local_1, -1);
                _local_2 = 0;
                while (_local_2 < _local_1.length)
                {
                    IWindow(_local_1[_local_2]).disable();
                    _local_2++;
                };
                return (true);
            };
            return (false);
        }

        protected function setScrollPosition(_arg_1:Number):Boolean
        {
            var _local_2:Boolean;
            if (((_SafeStr_937 == null) || (_SafeStr_937.disposed)))
            {
                if (!resolveScrollTarget())
                {
                    return (false);
                };
            };
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_1 > 1)
            {
                _arg_1 = 1;
            };
            _offset = _arg_1;
            if (_horizontal)
            {
                _local_2 = (!(_SafeStr_937.scrollH == _offset));
                if (_local_2)
                {
                    _SafeStr_937.scrollH = _offset;
                };
            }
            else
            {
                _local_2 = (!(_SafeStr_937.scrollV == _offset));
                if (_local_2)
                {
                    _SafeStr_937.scrollV = _offset;
                };
            };
            return (_local_2);
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            switch (_arg_1.name)
            {
                case "slider_bar":
                    if (_arg_2.type == "WE_CHILD_RELOCATED")
                    {
                        if (!_SafeStr_939)
                        {
                            if (_horizontal)
                            {
                                setScrollPosition(ScrollBarLiftController(_arg_1).scrollbarOffsetX);
                            }
                            else
                            {
                                setScrollPosition(ScrollBarLiftController(_arg_1).scrollbarOffsetY);
                            };
                        };
                    };
            };
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            if (_arg_2.type == "WE_PARENT_ADDED")
            {
                if (_SafeStr_937 == null)
                {
                    resolveScrollTarget();
                };
            };
            if (_arg_1 == this)
            {
                if (_arg_2.type == "WE_RESIZED")
                {
                    updateLiftSizeAndPosition();
                }
                else
                {
                    if (_arg_2.type == "WME_WHEEL")
                    {
                        if (WindowMouseEvent(_arg_2).delta > 0)
                        {
                            if (_horizontal)
                            {
                                scrollH = (scrollH - _SafeStr_938);
                            }
                            else
                            {
                                scrollV = (scrollV - _SafeStr_938);
                            };
                        }
                        else
                        {
                            if (_horizontal)
                            {
                                scrollH = (scrollH + _SafeStr_938);
                            }
                            else
                            {
                                scrollV = (scrollV + _SafeStr_938);
                            };
                        };
                        _local_3 = true;
                    };
                };
            };
            return (_local_3);
        }

        private function updateLiftSizeAndPosition():void
        {
            var _local_3:int;
            var _local_4:Number;
            if (((_SafeStr_937 == null) || (_SafeStr_937.disposed)))
            {
                if (((_disposed) || (!(resolveScrollTarget()))))
                {
                    return;
                };
            };
            var _local_2:WindowController = track;
            var _local_1:WindowController = lift;
            if (_local_1 != null)
            {
                if (_horizontal)
                {
                    _local_4 = (_SafeStr_937.visibleRegion.width / _SafeStr_937.scrollableRegion.width);
                    if (_local_4 > 1)
                    {
                        _local_4 = 1;
                    };
                    _local_3 = (_local_4 * _local_2.width);
                    _local_1.width = _local_3;
                    _local_1.x = Math.round((_SafeStr_937.scrollH * (_local_2.width - _local_3)));
                }
                else
                {
                    _local_4 = (_SafeStr_937.visibleRegion.height / _SafeStr_937.scrollableRegion.height);
                    if (_local_4 > 1)
                    {
                        _local_4 = 1;
                    };
                    _local_3 = (_local_4 * _local_2.height);
                    _local_1.height = _local_3;
                    _local_1.y = Math.round((_SafeStr_937.scrollV * (_local_2.height - _local_1.height)));
                };
            };
            if (_local_4 == 1)
            {
                disable();
            }
            else
            {
                enable();
            };
        }

        private function nullEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }

        private function scrollButtonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:IWindow;
            var _local_6:Boolean;
            if (((_arg_1.type == "WME_DOWN") || (_arg_1.type == "WTE_TAP")))
            {
                if (_arg_2.name == "increment")
                {
                    if (_SafeStr_937)
                    {
                        _SafeStr_939 = true;
                        if (_horizontal)
                        {
                            scrollH = (scrollH + (_SafeStr_937.scrollStepH / _SafeStr_937.maxScrollH));
                        }
                        else
                        {
                            scrollV = (scrollV + (_SafeStr_937.scrollStepV / _SafeStr_937.maxScrollV));
                        };
                        _SafeStr_939 = false;
                    };
                }
                else
                {
                    if (_arg_2.name == "decrement")
                    {
                        if (_SafeStr_937)
                        {
                            _SafeStr_939 = true;
                            if (_horizontal)
                            {
                                scrollH = (scrollH - (_SafeStr_937.scrollStepH / _SafeStr_937.maxScrollH));
                            }
                            else
                            {
                                scrollV = (scrollV - (_SafeStr_937.scrollStepV / _SafeStr_937.maxScrollV));
                            };
                            _SafeStr_939 = false;
                        };
                    }
                    else
                    {
                        if (_arg_2.name == "slider_track")
                        {
                            if ((_arg_1 is WindowMouseEvent))
                            {
                                _local_5 = WindowMouseEvent(_arg_1).localX;
                                _local_4 = WindowMouseEvent(_arg_1).localY;
                            }
                            else
                            {
                                if ((_arg_1 is WindowTouchEvent))
                                {
                                    _local_5 = WindowTouchEvent(_arg_1).localX;
                                    _local_4 = WindowTouchEvent(_arg_1).localY;
                                };
                            };
                            _local_3 = WindowController(_arg_2).getChildByName("slider_bar");
                            if (_horizontal)
                            {
                                if (_local_5 < _local_3.x)
                                {
                                    scrollH = (scrollH - ((_SafeStr_937.visibleRegion.width - _SafeStr_937.scrollStepH) / _SafeStr_937.maxScrollH));
                                }
                                else
                                {
                                    if (_local_5 > _local_3.right)
                                    {
                                        scrollH = (scrollH + ((_SafeStr_937.visibleRegion.width - _SafeStr_937.scrollStepH) / _SafeStr_937.maxScrollH));
                                    };
                                };
                            }
                            else
                            {
                                if (_local_4 < _local_3.y)
                                {
                                    scrollV = (scrollV - ((_SafeStr_937.visibleRegion.height - _SafeStr_937.scrollStepV) / _SafeStr_937.maxScrollV));
                                }
                                else
                                {
                                    if (_local_4 > _local_3.bottom)
                                    {
                                        scrollV = (scrollV + ((_SafeStr_937.visibleRegion.height - _SafeStr_937.scrollStepV) / _SafeStr_937.maxScrollV));
                                    };
                                };
                            };
                            _local_6 = true;
                        };
                    };
                };
            };
            if (_arg_1.type == "WME_WHEEL")
            {
                if (WindowMouseEvent(_arg_1).delta > 0)
                {
                    if (_horizontal)
                    {
                        scrollH = (scrollH - _SafeStr_938);
                    }
                    else
                    {
                        scrollV = (scrollV - _SafeStr_938);
                    };
                }
                else
                {
                    if (_horizontal)
                    {
                        scrollH = (scrollH + _SafeStr_938);
                    }
                    else
                    {
                        scrollV = (scrollV + _SafeStr_938);
                    };
                };
                _local_6 = true;
            };
            if (_local_6)
            {
                updateLiftSizeAndPosition();
            };
        }

        private function resolveScrollTarget():Boolean
        {
            var _local_1:IScrollableWindow;
            var _local_4:IScrollableWindow;
            var _local_3:uint;
            var _local_2:uint;
            if (_SafeStr_937 != null)
            {
                if (!_SafeStr_937.disposed)
                {
                    return (true);
                };
            };
            if (_targetName != null)
            {
                _local_1 = (findParentByName(_targetName) as IScrollableWindow);
                if ((((_local_1 == null) && (_parent is IWindowContainer)) && (!(_parent is IDesktopWindow))))
                {
                    _local_1 = (IWindowContainer(_parent).findChildByName(_targetName) as IScrollableWindow);
                    if (_local_1)
                    {
                        scrollable = _local_1;
                        return (true);
                    };
                };
            };
            if ((_parent is IScrollableWindow))
            {
                scrollable = IScrollableWindow(_parent);
                return (true);
            };
            if (((_parent is IWindowContainer) && (!(_parent is IDesktopWindow))))
            {
                _local_2 = IWindowContainer(_parent).numChildren;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (IWindowContainer(_parent).getChildAt(_local_3) as IScrollableWindow);
                    if (_local_4)
                    {
                        scrollable = _local_4;
                        return (true);
                    };
                    _local_3++;
                };
            };
            return (false);
        }

        private function onScrollableResized(_arg_1:WindowEvent):void
        {
            updateLiftSizeAndPosition();
            setScrollPosition(_offset);
        }

        private function onScrollableScrolled(_arg_1:WindowEvent):void
        {
            updateLiftSizeAndPosition();
        }


    }
}


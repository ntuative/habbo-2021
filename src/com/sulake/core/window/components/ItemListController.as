package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IInputProcessorRoot;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.theme.IThemeManager;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.iterators.ItemListIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.PropertyStruct;

    public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot
    {

        private var _SafeStr_924:Boolean = false;
        private var _isPartOfGridWindow:Boolean = false;
        protected var _SafeStr_925:Number = 0;
        protected var _SafeStr_926:Number = 0;
        protected var _scrollAreaWidth:Number = 0;
        protected var _SafeStr_927:Number = 0;
        protected var _container:IWindowContainer;
        protected var _SafeStr_928:Boolean = false;
        protected var _SafeStr_929:Boolean = false;
        protected var _SafeStr_892:int;
        protected var _SafeStr_918:Boolean = false;
        protected var _SafeStr_921:Number = -1;
        protected var _SafeStr_922:Number = -1;
        protected var _arrangeListItems:Boolean;
        protected var _scaleToFitItems:Boolean;
        protected var _resizeOnItemUpdate:Boolean;
        protected var _SafeStr_930:Number;
        protected var _SafeStr_662:Number;
        protected var _SafeStr_931:Number;
        protected var _SafeStr_932:Number;
        protected var _SafeStr_933:Boolean;

        public function ItemListController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _SafeStr_918 = (_arg_2 == 51);
            var _local_12:IThemeManager = _arg_5.getWindowFactory().getThemeManager();
            _SafeStr_892 = int(_local_12.getPropertyDefaults(_arg_3).get("spacing").value);
            _arrangeListItems = _local_12.getPropertyDefaults(_arg_3).get("auto_arrange_items").value;
            _scaleToFitItems = _local_12.getPropertyDefaults(_arg_3).get("scale_to_fit_items").value;
            _resizeOnItemUpdate = _local_12.getPropertyDefaults(_arg_3).get("resize_on_item_update").value;
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_899 = ((_background) || (!(testParamFlag(16))));
            _container = (_context.create("_CONTAINER", "", 4, 0, ((0x10 | 0x00) | 0x00), new Rectangle(0, 0, width, height), null, this, 0, null, "", ["_INTERNAL", "_EXCLUDE"]) as IWindowContainer);
            _container.addEventListener("WE_RESIZED", containerEventHandler);
            _container.addEventListener("WE_CHILD_REMOVED", containerEventHandler);
            _container.addEventListener("WE_CHILD_RESIZED", containerEventHandler);
            _container.addEventListener("WE_CHILD_RELOCATED", containerEventHandler);
            _container.clipping = clipping;
            resizeOnItemUpdate = _resizeOnItemUpdate;
        }

        public function get spacing():int
        {
            return (_SafeStr_892);
        }

        public function set spacing(_arg_1:int):void
        {
            if (_arg_1 != _SafeStr_892)
            {
                _SafeStr_892 = _arg_1;
                updateScrollAreaRegion();
            };
        }

        public function get scrollH():Number
        {
            return (_SafeStr_925);
        }

        public function get scrollV():Number
        {
            return (_SafeStr_926);
        }

        public function get maxScrollH():int
        {
            return (Math.max(0, (_scrollAreaWidth - width)));
        }

        public function get maxScrollV():int
        {
            return (Math.max(0, (_SafeStr_927 - height)));
        }

        public function get isPartOfGridWindow():Boolean
        {
            return (_isPartOfGridWindow);
        }

        public function set isPartOfGridWindow(_arg_1:Boolean):void
        {
            _isPartOfGridWindow = _arg_1;
        }

        public function get scrollableWindow():IWindow
        {
            return (this);
        }

        public function get visibleRegion():Rectangle
        {
            return (new Rectangle((_SafeStr_925 * maxScrollH), (_SafeStr_926 * maxScrollV), width, height));
        }

        public function get scrollableRegion():Rectangle
        {
            return (_container.rectangle);
        }

        public function set scrollH(_arg_1:Number):void
        {
            var _local_2:WindowEvent;
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_1 > 1)
            {
                _arg_1 = 1;
            };
            if (_arg_1 != _SafeStr_925)
            {
                _SafeStr_925 = _arg_1;
                _container.x = (-(_SafeStr_925) * maxScrollH);
                _context.invalidate(_container, visibleRegion, 1);
                if (_SafeStr_913)
                {
                    _local_2 = WindowEvent.allocate("WE_SCROLL", this, null);
                    _SafeStr_913.dispatchEvent(_local_2);
                    _local_2.recycle();
                };
            };
        }

        public function set scrollV(_arg_1:Number):void
        {
            var _local_2:WindowEvent;
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_1 > 1)
            {
                _arg_1 = 1;
            };
            if (_arg_1 != _SafeStr_926)
            {
                _SafeStr_926 = _arg_1;
                _container.y = (-(_SafeStr_926) * maxScrollV);
                if (_SafeStr_913)
                {
                    _local_2 = WindowEvent.allocate("WE_SCROLL", this, null);
                    _SafeStr_913.dispatchEvent(_local_2);
                    _local_2.recycle();
                };
            };
        }

        public function get scrollStepH():Number
        {
            if (_SafeStr_921 >= 0)
            {
                return (_SafeStr_921);
            };
            return ((_SafeStr_918) ? (_container.width / numListItems) : (0.1 * _container.width));
        }

        public function get scrollStepV():Number
        {
            if (_SafeStr_922 >= 0)
            {
                return (_SafeStr_922);
            };
            return ((_SafeStr_918) ? (0.1 * _container.height) : (_container.height / numListItems));
        }

        public function set scrollStepH(_arg_1:Number):void
        {
            _SafeStr_921 = _arg_1;
        }

        public function set scrollStepV(_arg_1:Number):void
        {
            _SafeStr_922 = _arg_1;
        }

        public function set scaleToFitItems(_arg_1:Boolean):void
        {
            if (_scaleToFitItems != _arg_1)
            {
                _scaleToFitItems = _arg_1;
                updateScrollAreaRegion();
            };
        }

        public function get scaleToFitItems():Boolean
        {
            return (_scaleToFitItems);
        }

        public function set autoArrangeItems(_arg_1:Boolean):void
        {
            _arrangeListItems = _arg_1;
            updateScrollAreaRegion();
        }

        public function get autoArrangeItems():Boolean
        {
            return (_arrangeListItems);
        }

        public function set resizeOnItemUpdate(_arg_1:Boolean):void
        {
            _resizeOnItemUpdate = _arg_1;
            if (_container)
            {
                if (_SafeStr_918)
                {
                    _container.setParamFlag(0x400000, _arg_1);
                }
                else
                {
                    _container.setParamFlag(0x800000, _arg_1);
                };
            };
        }

        public function get resizeOnItemUpdate():Boolean
        {
            return (_resizeOnItemUpdate);
        }

        public function get iterator():IIterator
        {
            return (new ItemListIterator(this));
        }

        public function get firstListItem():IWindow
        {
            return ((numListItems > 0) ? getListItemAt(0) : null);
        }

        public function get lastListItem():IWindow
        {
            return ((numListItems > 0) ? getListItemAt((numListItems - 1)) : null);
        }

        override public function set clipping(_arg_1:Boolean):void
        {
            super.clipping = _arg_1;
            if (_container)
            {
                _container.clipping = _arg_1;
            };
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                _container.removeEventListener("WE_RESIZED", containerEventHandler);
                _container.removeEventListener("WE_CHILD_REMOVED", containerEventHandler);
                _container.removeEventListener("WE_CHILD_RESIZED", containerEventHandler);
                _container.removeEventListener("WE_CHILD_RELOCATED", containerEventHandler);
                super.dispose();
            };
        }

        override protected function cloneChildWindows(_arg_1:WindowController):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < numListItems)
            {
                IItemListWindow(_arg_1).addListItem(getListItemAt(_local_2).clone());
                _local_2++;
            };
        }

        public function get numListItems():int
        {
            return ((_container != null) ? _container.numChildren : 0);
        }

        public function addListItem(_arg_1:IWindow):IWindow
        {
            _SafeStr_929 = true;
            if (_SafeStr_918)
            {
                _arg_1.x = (_scrollAreaWidth + ((numListItems > 0) ? _SafeStr_892 : 0));
                _scrollAreaWidth = _arg_1.right;
                _container.width = _scrollAreaWidth;
            }
            else
            {
                if (autoArrangeItems)
                {
                    _arg_1.y = (_SafeStr_927 + ((numListItems > 0) ? _SafeStr_892 : 0));
                    _SafeStr_927 = _arg_1.bottom;
                }
                else
                {
                    _SafeStr_927 = Math.max(_SafeStr_927, _arg_1.bottom);
                };
                _container.height = _SafeStr_927;
            };
            _arg_1 = _container.addChild(_arg_1);
            _SafeStr_929 = false;
            return (_arg_1);
        }

        public function addListItemAt(_arg_1:IWindow, _arg_2:uint):IWindow
        {
            _arg_1 = _container.addChildAt(_arg_1, _arg_2);
            updateScrollAreaRegion();
            return (_arg_1);
        }

        public function getListItemAt(_arg_1:uint):IWindow
        {
            return (_container.getChildAt(_arg_1));
        }

        public function getListItemByID(_arg_1:uint):IWindow
        {
            return (_container.getChildByID(_arg_1));
        }

        public function getListItemByName(_arg_1:String):IWindow
        {
            return (_container.getChildByName(_arg_1));
        }

        public function getListItemByTag(_arg_1:String):IWindow
        {
            return (_container.getChildByTag(_arg_1));
        }

        public function getListItemIndex(_arg_1:IWindow):int
        {
            return (_container.getChildIndex(_arg_1));
        }

        public function removeListItem(_arg_1:IWindow):IWindow
        {
            _arg_1 = _container.removeChild(_arg_1);
            if (_arg_1)
            {
                updateScrollAreaRegion();
            };
            return (_arg_1);
        }

        public function removeListItemAt(_arg_1:int):IWindow
        {
            return (_container.removeChildAt(_arg_1));
        }

        public function setListItemIndex(_arg_1:IWindow, _arg_2:int):void
        {
            _container.setChildIndex(_arg_1, _arg_2);
        }

        public function swapListItems(_arg_1:IWindow, _arg_2:IWindow):void
        {
            _container.swapChildren(_arg_1, _arg_2);
            updateScrollAreaRegion();
        }

        public function swapListItemsAt(_arg_1:int, _arg_2:int):void
        {
            _container.swapChildrenAt(_arg_1, _arg_2);
            updateScrollAreaRegion();
        }

        public function groupListItemsWithID(_arg_1:uint, _arg_2:Array, _arg_3:int=0):uint
        {
            return (_container.groupChildrenWithID(_arg_1, _arg_2, _arg_3));
        }

        public function groupListItemsWithTag(_arg_1:String, _arg_2:Array, _arg_3:int=0):uint
        {
            return (_container.groupChildrenWithTag(_arg_1, _arg_2, _arg_3));
        }

        public function removeListItems():void
        {
            _SafeStr_929 = true;
            while (numListItems > 0)
            {
                _container.removeChildAt(0);
            };
            _SafeStr_929 = false;
            updateScrollAreaRegion();
        }

        public function destroyListItems():void
        {
            _SafeStr_929 = true;
            while (numListItems > 0)
            {
                _container.removeChildAt(0).destroy();
            };
            _SafeStr_929 = false;
            updateScrollAreaRegion();
        }

        public function arrangeListItems():void
        {
            updateScrollAreaRegion();
        }

        override public function populate(_arg_1:Array):void
        {
            WindowController(_container).populate(_arg_1);
            updateScrollAreaRegion();
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            switch (_arg_2.type)
            {
                case "WE_RESIZE":
                    _SafeStr_928 = true;
                    break;
                case "WE_RESIZED":
                    if (!_scaleToFitItems)
                    {
                        if (_SafeStr_918)
                        {
                            _container.height = _SafeStr_909;
                        }
                        else
                        {
                            _container.width = _SafeStr_908;
                        };
                    };
                    updateScrollAreaRegion();
                    _SafeStr_928 = false;
                    break;
                default:
                    if ((_arg_2 is WindowEvent))
                    {
                        _local_3 = process((_arg_2 as WindowEvent));
                    };
            };
            return (_local_3);
        }

        public function process(_arg_1:WindowEvent):Boolean
        {
            var _local_5:Boolean;
            var _local_3:int;
            var _local_4:int;
            var _local_2:int;
            if ((_arg_1 is WindowMouseEvent))
            {
                _local_3 = WindowMouseEvent(_arg_1).localX;
                _local_4 = WindowMouseEvent(_arg_1).localY;
                _local_2 = WindowMouseEvent(_arg_1).delta;
            };
            switch (_arg_1.type)
            {
                case "WME_WHEEL":
                    if (_SafeStr_918)
                    {
                        scrollH = (scrollH - ((_local_2 * scrollStepH) / maxScrollH));
                    }
                    else
                    {
                        scrollV = (scrollV - ((_local_2 * scrollStepV) / maxScrollV));
                    };
                    _local_5 = (!(_isPartOfGridWindow));
                    break;
                case "WME_DOWN":
                    _SafeStr_930 = _local_3;
                    _SafeStr_662 = _local_4;
                    _SafeStr_931 = (_SafeStr_925 * maxScrollH);
                    _SafeStr_932 = (_SafeStr_926 * maxScrollV);
                    _SafeStr_933 = true;
                    _local_5 = true;
                    break;
                case "WME_MOVE":
                    if (((_SafeStr_933) && (!(_SafeStr_924))))
                    {
                        if (_SafeStr_918)
                        {
                            scrollH = (((_SafeStr_931 + _SafeStr_930) - _local_3) / maxScrollH);
                        }
                        else
                        {
                            scrollV = (((_SafeStr_932 + _SafeStr_662) - _local_4) / maxScrollV);
                        };
                        _local_5 = true;
                    };
                    break;
                case "WME_UP":
                case "WME_UP_OUTSIDE":
                    if (_SafeStr_933)
                    {
                        _SafeStr_933 = false;
                        _local_5 = true;
                    };
            };
            return (_local_5);
        }

        private function scrollAnimationCallback(_arg_1:int, _arg_2:int):void
        {
            if (!disposed)
            {
                scrollH = (scrollH - (_arg_1 / _scrollAreaWidth));
                scrollV = (scrollV - (_arg_2 / _SafeStr_927));
            };
        }

        private function containerEventHandler(_arg_1:WindowEvent):void
        {
            var _local_2:WindowEvent;
            switch (_arg_1.type)
            {
                case "WE_CHILD_REMOVED":
                    updateScrollAreaRegion();
                    return;
                case "WE_CHILD_RESIZED":
                    if (!_SafeStr_928)
                    {
                        updateScrollAreaRegion();
                    };
                    return;
                case "WE_CHILD_RELOCATED":
                    updateScrollAreaRegion();
                    return;
                case "WE_RESIZED":
                    if (_SafeStr_913)
                    {
                        _local_2 = WindowEvent.allocate("WE_RESIZED", this, null);
                        _SafeStr_913.dispatchEvent(_local_2);
                        _local_2.recycle();
                    };
                    return;
                default:
                    return;
            };
        }

        protected function updateScrollAreaRegion():void
        {
            var _local_4:IWindow;
            var _local_1:int;
            var _local_3:uint;
            var _local_2:uint;
            if ((((_arrangeListItems) && (!(_SafeStr_929))) && (_container)))
            {
                _SafeStr_929 = true;
                _local_2 = _container.numChildren;
                if (_SafeStr_918)
                {
                    _scrollAreaWidth = 0;
                    _SafeStr_927 = _SafeStr_909;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_4 = _container.getChildAt(_local_3);
                        if (_local_4.visible)
                        {
                            _local_4.x = _scrollAreaWidth;
                            _scrollAreaWidth = (_scrollAreaWidth + (_local_4.width + _SafeStr_892));
                            if (_scaleToFitItems)
                            {
                                _local_1 = (_local_4.height + _local_4.y);
                                _SafeStr_927 = ((_local_1 > _SafeStr_927) ? _local_1 : _SafeStr_927);
                            };
                        };
                        _local_3++;
                    };
                    if (_local_2 > 0)
                    {
                        _scrollAreaWidth = (_scrollAreaWidth - _SafeStr_892);
                    };
                }
                else
                {
                    _scrollAreaWidth = _SafeStr_908;
                    _SafeStr_927 = 0;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_4 = _container.getChildAt(_local_3);
                        if (_local_4.visible)
                        {
                            _local_4.y = _SafeStr_927;
                            _SafeStr_927 = (_SafeStr_927 + (_local_4.height + _SafeStr_892));
                            if (_scaleToFitItems)
                            {
                                _local_1 = (_local_4.width + _local_4.x);
                                _scrollAreaWidth = ((_local_1 > _scrollAreaWidth) ? _local_1 : _scrollAreaWidth);
                            };
                        };
                        _local_3++;
                    };
                    if (_local_2 > 0)
                    {
                        _SafeStr_927 = (_SafeStr_927 - _SafeStr_892);
                    };
                };
                if (_SafeStr_925 > 0)
                {
                    if (_scrollAreaWidth <= _SafeStr_908)
                    {
                        scrollH = 0;
                    }
                    else
                    {
                        _container.x = -(_SafeStr_925 * maxScrollH);
                    };
                };
                if (_SafeStr_926 > 0)
                {
                    if (_SafeStr_927 <= _SafeStr_909)
                    {
                        scrollV = 0;
                    }
                    else
                    {
                        _container.y = -(_SafeStr_926 * maxScrollV);
                    };
                };
                _container.height = _SafeStr_927;
                _container.width = _scrollAreaWidth;
                _SafeStr_929 = false;
            };
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("spacing", _SafeStr_892));
            _local_1.push(createProperty("auto_arrange_items", _arrangeListItems));
            _local_1.push(createProperty("scale_to_fit_items", _scaleToFitItems));
            _local_1.push(createProperty("resize_on_item_update", _resizeOnItemUpdate));
            _local_1.push(createProperty("scroll_step_h", _SafeStr_921));
            _local_1.push(createProperty("scroll_step_v", _SafeStr_922));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "spacing":
                        spacing = (_local_2.value as int);
                        break;
                    case "scale_to_fit_items":
                        scaleToFitItems = (_local_2.value as Boolean);
                        break;
                    case "resize_on_item_update":
                        resizeOnItemUpdate = (_local_2.value as Boolean);
                        break;
                    case "auto_arrange_items":
                        _arrangeListItems = (_local_2.value as Boolean);
                        break;
                    case "scroll_step_h":
                        _SafeStr_921 = (_local_2.value as Number);
                        break;
                    case "scroll_step_v":
                        _SafeStr_922 = (_local_2.value as Number);
                };
            };
            super.properties = _arg_1;
        }

        public function stopDragging():void
        {
            _SafeStr_933 = false;
        }

        public function set disableAutodrag(_arg_1:Boolean):void
        {
            _SafeStr_924 = _arg_1;
        }


    }
}
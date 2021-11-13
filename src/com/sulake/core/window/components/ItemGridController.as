package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.iterators.ItemGridIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.PropertyStruct;

    public class ItemGridController extends ItemListController implements IItemGridWindow 
    {

        private var _containerResizeToColumns:Boolean = false;
        private var _SafeStr_919:Boolean = false;
        private var _SafeStr_920:int;
        private var _shouldRebuildGridOnResize:Boolean = true;
        private var _SafeStr_923:Boolean = false;

        public function ItemGridController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_918 = (!(_arg_2 == 54));
            _scaleToFitItems = true;
            if (!_SafeStr_918)
            {
                throw (new Error("Horizontal item grid not yet implemented!"));
            };
        }

        override public function set spacing(_arg_1:int):void
        {
            var _local_2:uint = numListItems;
            if (_SafeStr_919 == false)
            {
                while (_local_2-- > 0)
                {
                    IItemListWindow(getListItemAt(_local_2)).spacing = _arg_1;
                };
            };
            super.spacing = _arg_1;
        }

        override public function set background(_arg_1:Boolean):void
        {
            var _local_2:uint;
            super.background = _arg_1;
            _local_2 = 0;
            while (_local_2 < numListItems)
            {
                getListItemAt(_local_2).background = _arg_1;
                _local_2++;
            };
        }

        override public function set color(_arg_1:uint):void
        {
            var _local_2:uint;
            super.color = _arg_1;
            _local_2 = 0;
            while (_local_2 < numListItems)
            {
                getListItemAt(_local_2).color = _arg_1;
                _local_2++;
            };
        }

        override public function set autoArrangeItems(_arg_1:Boolean):void
        {
            var _local_2:int;
            super.autoArrangeItems = _arg_1;
            _local_2 = 0;
            while (_local_2 < numColumns)
            {
                IItemListWindow(getListItemAt(_local_2)).autoArrangeItems = _arg_1;
                _local_2++;
            };
        }

        override public function get scrollStepH():Number
        {
            if (_SafeStr_921 >= 0)
            {
                return (_SafeStr_921);
            };
            return ((_SafeStr_918) ? (0.1 * scrollableRegion.height) : (scrollableRegion.width / numColumns));
        }

        override public function get scrollStepV():Number
        {
            if (_SafeStr_922 >= 0)
            {
                return (_SafeStr_922);
            };
            return ((_SafeStr_918) ? (scrollableRegion.height / numRows) : (0.1 * scrollableRegion.width));
        }

        public function get shouldRebuildGridOnResize():Boolean
        {
            return (_shouldRebuildGridOnResize);
        }

        public function set shouldRebuildGridOnResize(_arg_1:Boolean):void
        {
            _shouldRebuildGridOnResize = _arg_1;
        }

        public function set verticalSpacing(_arg_1:int):void
        {
            _SafeStr_920 = _arg_1;
            _SafeStr_919 = true;
            var _local_2:uint = numListItems;
            while (_local_2-- > 0)
            {
                IItemListWindow(getListItemAt(_local_2)).spacing = _arg_1;
            };
        }

        override public function get iterator():IIterator
        {
            return (new ItemGridIterator(this));
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            switch (_arg_2.type)
            {
                case "WE_RESIZED":
                    if (_shouldRebuildGridOnResize)
                    {
                        rebuildGridStructure();
                    };
                    break;
                case "WME_WHEEL":
                    if (_SafeStr_918)
                    {
                        scrollV = (scrollV - (WindowMouseEvent(_arg_2).delta * 0.01));
                    }
                    else
                    {
                        scrollH = (scrollH - (WindowMouseEvent(_arg_2).delta * 0.01));
                    };
                    _local_3 = true;
            };
            return (_local_3);
        }

        public function get numGridItems():uint
        {
            var _local_1:uint = numListItems;
            var _local_2:uint;
            while (_local_1-- > 0)
            {
                _local_2 = (_local_2 + IItemListWindow(getListItemAt(_local_1)).numListItems);
            };
            return (_local_2);
        }

        public function get numColumns():uint
        {
            return (numListItems);
        }

        public function get numRows():uint
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_1:uint = numColumns;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                _local_3 = Math.max(_local_3, IItemListWindow(getListItemAt(_local_2)).numListItems);
                _local_2++;
            };
            return (_local_3);
        }

        public function addGridItem(_arg_1:IWindow):IWindow
        {
            var _local_2:IItemListWindow = resolveColumnForNextItem(_arg_1);
            return (_arg_1);
        }

        public function addGridItemAt(_arg_1:IWindow, _arg_2:uint):IWindow
        {
            offsetGridItemsForwards(_arg_1, Math.min(numGridItems, _arg_2));
            return (_arg_1);
        }

        public function getGridItemAt(_arg_1:uint):IWindow
        {
            var _local_2:IItemListWindow = resolveColumnByIndex(_arg_1);
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2.getListItemAt((_arg_1 / numColumns)));
        }

        public function getGridItemByID(_arg_1:uint):IWindow
        {
            var _local_4:IItemListWindow;
            var _local_2:IWindow;
            var _local_5:uint;
            var _local_3:uint = numColumns;
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_4 = (getListItemAt(_local_5) as IItemListWindow);
                _local_2 = _local_4.getListItemByID(_arg_1);
                if (_local_2)
                {
                    return (_local_2);
                };
                _local_5++;
            };
            return (null);
        }

        public function getGridItemByName(_arg_1:String):IWindow
        {
            var _local_4:IItemListWindow;
            var _local_2:IWindow;
            var _local_5:uint;
            var _local_3:uint = numColumns;
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_4 = (getListItemAt(_local_5) as IItemListWindow);
                _local_2 = _local_4.getListItemByName(_arg_1);
                if (_local_2)
                {
                    return (_local_2);
                };
                _local_5++;
            };
            return (null);
        }

        public function getGridItemByTag(_arg_1:String):IWindow
        {
            var _local_4:IItemListWindow;
            var _local_2:IWindow;
            var _local_5:uint;
            var _local_3:uint = numColumns;
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_4 = (getChildAt(_local_5) as IItemListWindow);
                _local_2 = _local_4.getListItemByTag(_arg_1);
                if (_local_2)
                {
                    return (_local_2);
                };
                _local_5++;
            };
            return (null);
        }

        public function getGridItemIndex(_arg_1:IWindow):int
        {
            var _local_2:IItemListWindow = resolveColumnByItem(_arg_1);
            if (_local_2 == null)
            {
                return (-1);
            };
            return ((_local_2.getListItemIndex(_arg_1) * numColumns) + getColumnIndex(_local_2));
        }

        public function removeGridItem(_arg_1:IWindow):IWindow
        {
            var _local_3:int = getGridItemIndex(_arg_1);
            if (_local_3 == -1)
            {
                return (null);
            };
            if (offsetGridItemsBackwards(_local_3) != _arg_1)
            {
                throw (new Error("Item grid is out of order!"));
            };
            var _local_2:IItemListWindow = resolveColumnByIndex(_local_3);
            if (!_SafeStr_918)
            {
                _local_2.width = _local_2.scrollableRegion.width;
            }
            else
            {
                _local_2.height = _local_2.scrollableRegion.height;
            };
            return (_arg_1);
        }

        public function removeGridItemAt(_arg_1:int):IWindow
        {
            return (removeGridItem(getGridItemAt(_arg_1)));
        }

        public function setGridItemIndex(_arg_1:IWindow, _arg_2:int):void
        {
            if (removeGridItem(_arg_1) == null)
            {
                throw (new Error("Item not found in grid!"));
            };
            addListItemAt(_arg_1, _arg_2);
        }

        public function swapGridItems(_arg_1:IWindow, _arg_2:IWindow):void
        {
            throw (new Error("ItemGridWindow / Unimplemented method!"));
        }

        public function swapGridItemsAt(_arg_1:int, _arg_2:int):void
        {
            swapGridItems(getGridItemAt(_arg_1), getGridItemAt(_arg_2));
        }

        public function removeGridItems():void
        {
            var _local_2:IItemListWindow;
            var _local_3:uint;
            var _local_1:uint = numColumns;
            _local_3 = 0;
            while (_local_3 < _local_1)
            {
                _local_2 = IItemListWindow(getListItemAt(_local_3));
                _local_2.removeListItems();
                if (!_SafeStr_918)
                {
                    _local_2.width = 0;
                }
                else
                {
                    _local_2.height = 0;
                };
                _local_3++;
            };
        }

        public function destroyGridItems():void
        {
            var _local_2:IItemListWindow;
            var _local_3:uint;
            var _local_1:uint = numColumns;
            _local_3 = 0;
            while (_local_3 < _local_1)
            {
                _local_2 = IItemListWindow(getListItemAt(_local_3));
                _local_2.destroyListItems();
                if (!_SafeStr_918)
                {
                    _local_2.width = 0;
                }
                else
                {
                    _local_2.height = 0;
                };
                _local_3++;
            };
            destroyListItems();
        }

        protected function listEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }

        protected function listItemEventHandler(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow;
            if (_arg_1.type == "WE_DESTROYED")
            {
                _local_2 = (_arg_1.target as IWindow);
                removeGridItem(_local_2);
            };
        }

        protected function getColumnIndex(_arg_1:IItemListWindow):int
        {
            return (getListItemIndex(_arg_1));
        }

        protected function resolveColumnByIndex(_arg_1:uint):IItemListWindow
        {
            return (getListItemAt((_arg_1 % numColumns)) as IItemListWindow);
        }

        public function getColumnNumberByItemIndex(_arg_1:uint):uint
        {
            return (_arg_1 % numColumns);
        }

        public function getRowNumberByItemIndex(_arg_1:uint):uint
        {
            return (_arg_1 / numColumns);
        }

        override public function populate(_arg_1:Array):void
        {
            var _local_7:IItemListWindow;
            var _local_9:IItemListWindow;
            var _local_8:int;
            var _local_5:Boolean;
            var _local_2:Boolean = autoArrangeItems;
            autoArrangeItems = false;
            var _local_10:int = numGridItems;
            var _local_6:int = numColumns;
            var _local_3:Array = [];
            for each (var _local_4:IWindow in _arg_1)
            {
                if (_local_6 == 0)
                {
                    addColumnForItem(_local_4);
                    _local_6++;
                }
                else
                {
                    if (_local_10 > 0)
                    {
                        _local_9 = resolveColumnByIndex(((_local_10 > 0) ? (_local_10 - 1) : 0));
                        _local_8 = getListItemIndex(_local_9);
                        _local_5 = ((_local_8 > -1) ? (_local_8 == (_local_6 - 1)) : true);
                        if (_local_5)
                        {
                            if (_local_9.numListItems == 1)
                            {
                                if ((_local_9.right + _local_4.width) <= _SafeStr_908)
                                {
                                    addColumnForItem(_local_4);
                                    continue;
                                };
                            };
                        };
                        _local_7 = (getListItemAt(((_local_5) ? 0 : (_local_8 + 1))) as IItemListWindow);
                    }
                    else
                    {
                        _local_7 = (getListItemAt(0) as IItemListWindow);
                    };
                    _local_7.addListItem(_local_4);
                    _local_10++;
                    if (_local_4.width > _local_7.width)
                    {
                        _local_7.width = _local_4.width;
                    };
                    if (_local_4.bottom > _local_7.height)
                    {
                        _local_7.height = _local_4.bottom;
                    };
                };
            };
            autoArrangeItems = _local_2;
        }

        protected function resolveColumnByItem(_arg_1:IWindow):IItemListWindow
        {
            var _local_3:IItemListWindow;
            var _local_2:uint = numColumns;
            while (_local_2-- > 0)
            {
                _local_3 = IItemListWindow(getListItemAt(_local_2));
                if (_local_3.getListItemIndex(_arg_1) > -1)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        protected function resolveColumnForNextItem(_arg_1:IWindow):IItemListWindow
        {
            var _local_3:IItemListWindow;
            var _local_6:IItemListWindow;
            if (numColumns == 0)
            {
                return (addColumnForItem(_arg_1));
            };
            var _local_5:uint = numGridItems;
            if (_local_5 > 0)
            {
                _local_6 = resolveColumnByIndex(((_local_5 > 0) ? (_local_5 - 1) : 0));
                var _local_4:int = getListItemIndex(_local_6);
                var _local_2:Boolean = ((_local_4 > -1) ? (_local_4 == (numColumns - 1)) : true);
                if (_local_2)
                {
                    if (_local_6.numListItems == 1)
                    {
                        if ((_local_6.right + _arg_1.width) <= _SafeStr_908)
                        {
                            return (addColumnForItem(_arg_1));
                        };
                    };
                };
                _local_3 = (getListItemAt(((_local_2) ? 0 : (_local_4 + 1))) as IItemListWindow);
            }
            else
            {
                _local_3 = (getListItemAt(0) as IItemListWindow);
            };
            _local_3.addListItem(_arg_1);
            if (_arg_1.width > _local_3.width)
            {
                _local_3.width = _arg_1.width;
            };
            if (_arg_1.bottom > _local_3.height)
            {
                _local_3.height = _arg_1.bottom;
            };
            return (_local_3);
        }

        protected function addColumnForItem(_arg_1:IWindow):IItemListWindow
        {
            var _local_2:IItemListWindow = (_context.create(((_name + "_COLUMN_") + numListItems), null, 50, 0, (0x10 | 0x00), new Rectangle(0, 0, Math.max(_arg_1.width, 0), Math.max(_arg_1.height, 0)), listEventProc, null, numListItems, null, "", ["_INTERNAL", "_EXCLUDE"]) as IItemListWindow);
            _local_2.isPartOfGridWindow = true;
            _local_2.background = background;
            _local_2.color = color;
            _local_2.spacing = ((_SafeStr_919) ? _SafeStr_920 : _SafeStr_892);
            addListItem(_local_2);
            _local_2.addListItem(_arg_1);
            return (_local_2);
        }

        protected function removeColumnAt(_arg_1:uint):void
        {
            var _local_2:IItemListWindow = (removeChildAt(_arg_1) as IItemListWindow);
            if (_local_2)
            {
                _local_2.dispose();
            };
        }

        protected function offsetGridItemsForwards(_arg_1:IWindow, _arg_2:uint):void
        {
            var _local_6:IItemListWindow;
            var _local_3:IWindow;
            var _local_9:uint;
            var _local_5:uint;
            var _local_8:int;
            _local_5 = numGridItems;
            var _local_7:int = (_local_5 - 1);
            var _local_4:uint = numColumns;
            _local_8 = 0;
            while (_local_8 < _local_4)
            {
                IItemListWindow(getListItemAt(_local_8)).autoArrangeItems = false;
                _local_8++;
            };
            if (_local_5 <= _arg_2)
            {
                resolveColumnForNextItem(_arg_1);
            }
            else
            {
                if (numRows == 1)
                {
                    _local_3 = getGridItemAt(_local_7);
                    _local_6 = resolveColumnForNextItem(_local_3);
                    _local_7--;
                };
                while (_local_7 >= _arg_2)
                {
                    _local_3 = getGridItemAt(_local_7);
                    _local_9 = getRowNumberByItemIndex((_local_7 + 1));
                    _local_6 = resolveColumnByIndex((_local_7 + 1));
                    _local_6.addListItemAt(_local_3, _local_9);
                    _local_7--;
                };
                resolveColumnByIndex(_arg_2).addListItemAt(_arg_1, (_arg_2 / numColumns));
            };
            var _local_10:uint;
            _local_4 = numColumns;
            _local_8 = 0;
            while (_local_8 < _local_4)
            {
                _local_6 = IItemListWindow(getListItemAt(_local_8));
                _local_6.autoArrangeItems = true;
                _local_6.height = _local_6.scrollableRegion.height;
                _local_10 = Math.max(_local_10, _local_6.height);
                _local_8++;
            };
            _container.height = _local_10;
        }

        protected function offsetGridItemsBackwards(_arg_1:uint):IWindow
        {
            var _local_2:IWindow;
            var _local_8:uint;
            var _local_7:int;
            _local_8 = getRowNumberByItemIndex(_arg_1);
            var _local_4:IItemListWindow = resolveColumnByIndex(_arg_1);
            var _local_3:IWindow = _local_4.removeListItemAt(_local_8);
            var _local_5:uint = numGridItems;
            var _local_6:uint = _arg_1;
            if (_local_3 == null)
            {
                return (null);
            };
            _local_7 = 0;
            while (_local_7 < numColumns)
            {
                IItemListWindow(getListItemAt(_local_7)).autoArrangeItems = false;
                _local_7++;
            };
            while (_local_6 < _local_5)
            {
                _local_8 = getRowNumberByItemIndex(_local_6);
                _local_2 = getGridItemAt((_local_6 + 1));
                _local_4 = resolveColumnByIndex(_local_6);
                _local_4.addListItemAt(_local_2, _local_8);
                _local_6++;
            };
            var _local_9:uint;
            _local_7 = 0;
            while (_local_7 < numColumns)
            {
                _local_4 = IItemListWindow(getListItemAt(_local_7));
                _local_4.autoArrangeItems = true;
                _local_4.height = _local_4.scrollableRegion.height;
                _local_9 = Math.max(_local_9, _local_4.height);
                _local_7++;
            };
            _container.height = _local_9;
            return (_local_3);
        }

        public function rebuildGridStructure():void
        {
            var _local_4:IItemListWindow;
            var _local_1:IWindow;
            var _local_7:int;
            var _local_8:uint;
            var _local_5:int = numGridItems;
            var _local_2:Array = [];
            var _local_3:int = numColumns;
            if (_SafeStr_923)
            {
                return;
            };
            _SafeStr_923 = true;
            var _local_6:Boolean = autoArrangeItems;
            autoArrangeItems = false;
            while (_local_5 > 0)
            {
                _local_7 = 0;
                while (_local_7 < _local_3)
                {
                    _local_4 = (getListItemAt(_local_7) as IItemListWindow);
                    _local_1 = _local_4.removeListItemAt(0);
                    _local_2.push(_local_1);
                    if (--_local_5 < 1) break;
                    _local_7++;
                };
            };
            destroyListItems();
            autoArrangeItems = _local_6;
            for each (_local_1 in _local_2)
            {
                addGridItem(_local_1);
            };
            if (_containerResizeToColumns)
            {
                _local_8 = 0;
                _local_7 = 0;
                while (_local_7 < numColumns)
                {
                    _local_4 = IItemListWindow(getListItemAt(_local_7));
                    _local_4.autoArrangeItems = true;
                    _local_4.height = _local_4.scrollableRegion.height;
                    _local_8 = Math.max(_local_8, _local_4.height);
                    _local_7++;
                };
                _container.height = _local_8;
            };
            _SafeStr_923 = false;
        }

        public function set containerResizeToColumns(_arg_1:Boolean):void
        {
            _containerResizeToColumns = _arg_1;
        }

        public function get containerResizeToColumns():Boolean
        {
            return (_containerResizeToColumns);
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("container_resize_to_columns", containerResizeToColumns));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "container_resize_to_columns":
                        containerResizeToColumns = (_local_2.value as Boolean);
                };
            };
            super.properties = _arg_1;
        }


    }
}


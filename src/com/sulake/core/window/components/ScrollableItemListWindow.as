package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.utils.PropertyStruct;

    public class ScrollableItemListWindow extends WindowController implements IScrollableListWindow 
    {

        private var _SafeStr_936:IItemListWindow;
        private var _SafeStr_935:IScrollbarWindow;
        private var _autoHideScrollBar:Boolean = true;

        public function ScrollableItemListWindow(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _scrollBar.scrollable = _itemList;
            if (((_scrollBar.testStateFlag(32)) && (_autoHideScrollBar)))
            {
                hideScrollBar();
            };
        }

        override public function dispose():void
        {
            if (_SafeStr_935)
            {
                _SafeStr_935.removeEventListener("WE_ENABLED", scrollBarEventProc);
                _SafeStr_935.removeEventListener("WE_DISABLED", scrollBarEventProc);
                _SafeStr_935 = null;
            };
            if (_SafeStr_936)
            {
                _SafeStr_936 = null;
            };
            super.dispose();
        }

        protected function get _itemList():IItemListWindow
        {
            if (!_SafeStr_936)
            {
                _SafeStr_936 = (findChildByTag("_ITEMLIST") as IItemListWindow);
            };
            return (_SafeStr_936);
        }

        public function get scrollableWindow():IWindow
        {
            return (_itemList);
        }

        protected function get _scrollBar():IScrollbarWindow
        {
            if (!_SafeStr_935)
            {
                _SafeStr_935 = (findChildByTag("_SCROLLBAR") as IScrollbarWindow);
                if (_SafeStr_935)
                {
                    _SafeStr_935.addEventListener("WE_ENABLED", scrollBarEventProc);
                    _SafeStr_935.addEventListener("WE_DISABLED", scrollBarEventProc);
                };
            };
            return (_SafeStr_935);
        }

        private function scrollBarEventProc(_arg_1:WindowEvent):void
        {
            if (_arg_1.type == "WE_ENABLED")
            {
                showScrollBar();
            }
            else
            {
                if (((_arg_1.type == "WE_DISABLED") && (_autoHideScrollBar)))
                {
                    hideScrollBar();
                };
            };
        }

        private function hideScrollBar():void
        {
            if (_scrollBar.visible)
            {
                _scrollBar.visible = false;
                _itemList.width = _SafeStr_908;
            };
        }

        private function showScrollBar():void
        {
            if (!_scrollBar.visible)
            {
                _scrollBar.visible = true;
                _itemList.width = (_SafeStr_908 - _scrollBar.width);
            };
        }

        private function updateScrollBarVisibility(_arg_1:Boolean=false):void
        {
            if (_autoHideScrollBar)
            {
                if (_scrollBar.testStateFlag(32))
                {
                    if (_scrollBar.visible)
                    {
                        hideScrollBar();
                    };
                };
            }
            else
            {
                if (((_arg_1) || (_scrollBar.visible)))
                {
                    showScrollBar();
                };
            };
        }

        protected function isConstructionReady():Boolean
        {
            return ((_itemList) && (_scrollBar));
        }

        public function set autoHideScrollBar(_arg_1:Boolean):void
        {
            _autoHideScrollBar = _arg_1;
            updateScrollBarVisibility(true);
        }

        public function get autoHideScrollBar():Boolean
        {
            return (_autoHideScrollBar);
        }

        public function get iterator():IIterator
        {
            return ((isConstructionReady()) ? _itemList.iterator : null);
        }

        public function get scrollH():Number
        {
            return (_itemList.scrollH);
        }

        public function get scrollV():Number
        {
            return (_itemList.scrollV);
        }

        public function set scrollH(_arg_1:Number):void
        {
            _itemList.scrollH = _arg_1;
        }

        public function set scrollV(_arg_1:Number):void
        {
            _itemList.scrollV = _arg_1;
        }

        public function get maxScrollH():int
        {
            return (_itemList.maxScrollH);
        }

        public function get maxScrollV():int
        {
            return (_itemList.maxScrollV);
        }

        public function get visibleRegion():Rectangle
        {
            return (_itemList.visibleRegion);
        }

        public function get scrollableRegion():Rectangle
        {
            return (_itemList.scrollableRegion);
        }

        public function get scrollStepH():Number
        {
            return (_itemList.scrollStepH);
        }

        public function get scrollStepV():Number
        {
            return (_itemList.scrollStepV);
        }

        public function set scrollStepH(_arg_1:Number):void
        {
            _itemList.scrollStepH = _arg_1;
        }

        public function set scrollStepV(_arg_1:Number):void
        {
            _itemList.scrollStepV = _arg_1;
        }

        public function get spacing():int
        {
            return (_itemList.spacing);
        }

        public function set spacing(_arg_1:int):void
        {
            _itemList.spacing = _arg_1;
        }

        public function get scaleToFitItems():Boolean
        {
            return (_itemList.scaleToFitItems);
        }

        public function set scaleToFitItems(_arg_1:Boolean):void
        {
            _itemList.scaleToFitItems = _arg_1;
        }

        public function get autoArrangeItems():Boolean
        {
            return (_itemList.autoArrangeItems);
        }

        public function set autoArrangeItems(_arg_1:Boolean):void
        {
            _itemList.autoArrangeItems = _arg_1;
        }

        public function set resizeOnItemUpdate(_arg_1:Boolean):void
        {
            _itemList.resizeOnItemUpdate = _arg_1;
        }

        public function get resizeOnItemUpdate():Boolean
        {
            return (_itemList.resizeOnItemUpdate);
        }

        public function get numListItems():int
        {
            return (_itemList.numListItems);
        }

        public function addListItem(_arg_1:IWindow):IWindow
        {
            return (_itemList.addListItem(_arg_1));
        }

        public function addListItemAt(_arg_1:IWindow, _arg_2:uint):IWindow
        {
            return (_itemList.addListItemAt(_arg_1, _arg_2));
        }

        public function getListItemAt(_arg_1:uint):IWindow
        {
            return (_itemList.getListItemAt(_arg_1));
        }

        public function getListItemByID(_arg_1:uint):IWindow
        {
            return (_itemList.getListItemByID(_arg_1));
        }

        public function getListItemByName(_arg_1:String):IWindow
        {
            return (_itemList.getListItemByName(_arg_1));
        }

        public function getListItemByTag(_arg_1:String):IWindow
        {
            return (_itemList.getListItemByTag(_arg_1));
        }

        public function getListItemIndex(_arg_1:IWindow):int
        {
            return (_itemList.getListItemIndex(_arg_1));
        }

        public function removeListItem(_arg_1:IWindow):IWindow
        {
            return (_itemList.removeListItem(_arg_1));
        }

        public function removeListItemAt(_arg_1:int):IWindow
        {
            return (_itemList.removeListItemAt(_arg_1));
        }

        public function setListItemIndex(_arg_1:IWindow, _arg_2:int):void
        {
            _itemList.setListItemIndex(_arg_1, _arg_2);
        }

        public function swapListItems(_arg_1:IWindow, _arg_2:IWindow):void
        {
            _itemList.swapListItems(_arg_1, _arg_2);
        }

        public function swapListItemsAt(_arg_1:int, _arg_2:int):void
        {
            _itemList.swapListItemsAt(_arg_1, _arg_2);
        }

        public function groupListItemsWithID(_arg_1:uint, _arg_2:Array, _arg_3:int=0):uint
        {
            return (_itemList.groupListItemsWithID(_arg_1, _arg_2, _arg_3));
        }

        public function groupListItemsWithTag(_arg_1:String, _arg_2:Array, _arg_3:int=0):uint
        {
            return (_itemList.groupListItemsWithTag(_arg_1, _arg_2, _arg_3));
        }

        public function removeListItems():void
        {
            _itemList.removeListItems();
        }

        public function destroyListItems():void
        {
            _itemList.destroyListItems();
        }

        public function arrangeListItems():void
        {
            _itemList.arrangeListItems();
        }

        public function stopDragging():void
        {
            _itemList.stopDragging();
        }

        public function set disableAutodrag(_arg_1:Boolean):void
        {
            _itemList.disableAutodrag = _arg_1;
        }

        public function get isPartOfGridWindow():Boolean
        {
            return (_itemList.isPartOfGridWindow);
        }

        public function set isPartOfGridWindow(_arg_1:Boolean):void
        {
            _itemList.disableAutodrag = _arg_1;
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("spacing", spacing));
            _local_1.push(createProperty("auto_arrange_items", autoArrangeItems));
            _local_1.push(createProperty("scale_to_fit_items", scaleToFitItems));
            _local_1.push(createProperty("resize_on_item_update", resizeOnItemUpdate));
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
                        autoArrangeItems = (_local_2.value as Boolean);
                };
            };
            super.properties = _arg_1;
        }


    }
}


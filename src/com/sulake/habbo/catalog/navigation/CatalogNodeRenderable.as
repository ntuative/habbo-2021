package com.sulake.habbo.catalog.navigation
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class CatalogNodeRenderable extends CatalogNode 
    {

        private static const ITEM_SELECTION_COLOR:Number = 0xFFFFFFFF;

        private var _window:IWindowContainer;
        private var _SafeStr_1466:IItemListWindow;
        private var _isOpen:Boolean = false;
        private var _active:Boolean;
        private var _itemNormalColor:uint;
        private var _itemSelectedEtchingColor:uint;

        public function CatalogNodeRenderable(_arg_1:ICatalogNavigator, _arg_2:NodeData, _arg_3:int, _arg_4:ICatalogNode)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        override public function get isOpen():Boolean
        {
            return (_isOpen);
        }

        override public function get visible():Boolean
        {
            return (true);
        }

        override public function dispose():void
        {
            if (_isOpen)
            {
                close();
                deactivate();
            };
            _window = null;
            _SafeStr_1466 = null;
            super.dispose();
        }

        public function addToList(_arg_1:IItemListWindow, _arg_2:Boolean=true):void
        {
            if (_window == null)
            {
                createWindow();
                setInactiveLook();
            };
            _arg_1.addListItem(_window);
            if (isBranch)
            {
                if (_SafeStr_1466 == null)
                {
                    createChildList();
                };
                _arg_1.addListItem(_SafeStr_1466);
                refreshChildren();
            };
            _arg_1.arrangeListItems();
        }

        public function removeFromList(_arg_1:IItemListWindow):void
        {
            _arg_1.removeListItem(_window);
            if (isBranch)
            {
                _arg_1.removeListItem(_SafeStr_1466);
            };
        }

        override public function activate():void
        {
            setActiveLook();
            _active = true;
        }

        override public function deactivate():void
        {
            setInactiveLook();
            _active = false;
        }

        override public function open():void
        {
            var _local_1:IWindow;
            showChildren();
            _isOpen = true;
            if (((isBranch) && (!(_window == null))))
            {
                _local_1 = _window.findChildByTag("DOWNBTN");
                if (_local_1 != null)
                {
                    _local_1.style = 7;
                };
            };
        }

        override public function close():void
        {
            var _local_1:IWindow;
            removeChildren();
            _isOpen = false;
            if (((isBranch) && (!(_window == null))))
            {
                _local_1 = _window.findChildByTag("DOWNBTN");
                if (_local_1 != null)
                {
                    _local_1.style = 5;
                };
            };
        }

        private function refreshChildren():void
        {
            var _local_1:CatalogNodeRenderable;
            if (_SafeStr_1466 == null)
            {
                return;
            };
            for each (var _local_2:ICatalogNode in children)
            {
                _local_1 = (_local_2 as CatalogNodeRenderable);
                if (_local_1 != null)
                {
                    if (_local_1.visible)
                    {
                        _local_1.addToList(_SafeStr_1466);
                        _local_1.setInactiveLook();
                    }
                    else
                    {
                        _local_1.removeFromList(_SafeStr_1466);
                    };
                };
            };
            _SafeStr_1466.arrangeListItems();
        }

        private function showChildren():void
        {
            var _local_1:int;
            var _local_2:int;
            if (_SafeStr_1466 == null)
            {
                createChildList();
            };
            for each (var _local_3:ICatalogNode in children)
            {
                if (_local_3.visible)
                {
                    (_local_3 as CatalogNodeRenderable).addToList(_SafeStr_1466);
                };
            };
            if (_SafeStr_1466 != null)
            {
                _SafeStr_1466.visible = true;
                _local_1 = 0;
                _local_2 = 0;
                while (_local_2 < _SafeStr_1466.numListItems)
                {
                    if (_SafeStr_1466.getListItemAt(_local_2).visible)
                    {
                        _local_1++;
                    };
                    _local_2++;
                };
                _SafeStr_1466.height = (_local_1 * 21);
            };
        }

        private function removeChildren():void
        {
            for each (var _local_1:ICatalogNode in children)
            {
                if (_local_1.visible)
                {
                    (_local_1 as CatalogNodeRenderable).removeFromList(_SafeStr_1466);
                };
            };
            if (_SafeStr_1466 != null)
            {
                _SafeStr_1466.height = 0;
                _SafeStr_1466.visible = false;
                _SafeStr_1466.x = 0;
            };
        }

        private function createChildList():void
        {
            _SafeStr_1466 = (navigator.listTemplate.clone() as IItemListWindow);
            removeChildren();
        }

        private function createWindow():void
        {
            _window = (navigator.getItemTemplate(depth).clone() as IWindowContainer);
            var _local_2:ITextWindow = (_window.findChildByTag("ITEM_TITLE") as ITextWindow);
            var _local_1:IWindow = _window.findChildByTag("DOWNBTN");
            if (_local_2 != null)
            {
                _local_2.caption = localization;
                _itemNormalColor = _local_2.textColor;
                _itemSelectedEtchingColor = _local_2.etchingColor;
            };
            var _local_3:IWindow = _window.findChildByTag("SELECTION_HILIGHT");
            if (_local_3)
            {
                _local_3.visible = false;
            };
            if (_local_1 != null)
            {
                _local_1.visible = (!(isLeaf));
            };
            IStaticBitmapWrapperWindow(_window.findChildByName("icon")).assetUri = ((navigator.catalog.imageGalleryHost + iconName) + ".png");
            if (navigator.isDeepHierarchy)
            {
                if (depth == 1)
                {
                    _window.findChildByName("icon").visible = false;
                    _window.findChildByTag("ITEM_TITLE").x = 0;
                };
                if (depth > 3)
                {
                    _window.findChildByName("icon").visible = isBranch;
                    _window.findChildByTag("ITEM_TITLE").x = (42 + (5 * (depth - 3)));
                };
            };
            _window.addEventListener("WME_CLICK", onButtonClicked);
            _window.addEventListener("WME_OVER", onOver);
            _window.addEventListener("WME_OUT", onOut);
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", onButtonClicked);
            };
        }

        private function onOut(_arg_1:WindowMouseEvent):void
        {
            if (!_active)
            {
                setInactiveLook();
            };
        }

        private function onOver(_arg_1:WindowMouseEvent):void
        {
            if (!_active)
            {
                setActiveLook();
            };
        }

        private function setInactiveLook():void
        {
            var _local_1:ITextWindow;
            var _local_2:IWindow;
            if (_window != null)
            {
                _local_1 = (_window.findChildByTag("SELECTION_COLOR") as ITextWindow);
                if (_local_1 != null)
                {
                    _local_1.textColor = _itemNormalColor;
                    _local_1.etchingColor = 0;
                };
                _local_2 = _window.findChildByTag("SELECTION_HILIGHT");
                if (_local_2 != null)
                {
                    _local_2.visible = false;
                };
            };
        }

        private function setActiveLook():void
        {
            var _local_1:ITextWindow;
            var _local_2:IWindowContainer;
            if (_window != null)
            {
                _local_1 = (_window.findChildByTag("SELECTION_COLOR") as ITextWindow);
                if (_local_1 != null)
                {
                    _local_1.textColor = 0xFFFFFFFF;
                    _local_1.etchingColor = _itemSelectedEtchingColor;
                };
                _local_2 = (_window.findChildByTag("SELECTION_HILIGHT") as IWindowContainer);
                if (_local_2 != null)
                {
                    _local_2.visible = true;
                };
            };
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            navigator.activateNode(this);
        }

        public function updateChildListHeight():void
        {
            var _local_2:int;
            if (_SafeStr_1466 == null)
            {
                return;
            };
            _SafeStr_1466.height = 0;
            if (_SafeStr_1466 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_1466.numListItems)
                {
                    if (_SafeStr_1466.getListItemAt(_local_2).visible)
                    {
                        _SafeStr_1466.height = (_SafeStr_1466.height + _SafeStr_1466.getListItemAt(_local_2).height);
                    };
                    _local_2++;
                };
            };
            var _local_1:CatalogNodeRenderable = (parent as CatalogNodeRenderable);
            if (_local_1)
            {
                _local_1.updateChildListHeight();
            };
        }

        override public function get offsetV():int
        {
            return (_window.y + 21);
        }


    }
}


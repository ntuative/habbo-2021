package com.sulake.habbo.inventory.badges
{
    import com.sulake.core.window.components.IItemGridWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class BadgeGridView 
    {

        private var _SafeStr_570:BadgesView;
        private var _SafeStr_1654:IItemGridWindow;
        private var _items:Vector.<Badge>;
        private var _passedItems:Vector.<Badge>;
        private var _SafeStr_2716:IItemListWindow;
        private var _SafeStr_2717:IRegionWindow;
        private var _SafeStr_2718:int = 200;
        private var _SafeStr_2271:int = -1;
        private var _currentPageItems:Vector.<Badge>;
        private var _SafeStr_2719:String = "";

        public function BadgeGridView(_arg_1:BadgesView, _arg_2:IItemGridWindow, _arg_3:IItemListWindow)
        {
            _SafeStr_570 = _arg_1;
            _SafeStr_1654 = _arg_2;
            _SafeStr_1654.shouldRebuildGridOnResize = false;
            _items = new Vector.<Badge>(0);
            _passedItems = new Vector.<Badge>(0);
            _SafeStr_2716 = _arg_3;
            if (_SafeStr_2716)
            {
                _SafeStr_2717 = (_SafeStr_2716.removeListItemAt(0) as IRegionWindow);
            };
        }

        public function get visibleCount():int
        {
            return (_SafeStr_1654.numGridItems);
        }

        public function get currentPageItems():Vector.<Badge>
        {
            return (_currentPageItems);
        }

        private function get pageCount():int
        {
            return ((_passedItems.length / _SafeStr_2718) + 1);
        }

        public function dispose():void
        {
            _SafeStr_1654 = null;
            _items = null;
        }

        public function clearGrid():void
        {
            if (_SafeStr_1654 != null)
            {
                _SafeStr_1654.removeGridItems();
            };
            _SafeStr_1654.destroyGridItems();
        }

        public function setFilter(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            _SafeStr_2719 = ((_arg_3 == null) ? "" : _arg_3.toLowerCase());
            update();
        }

        public function itemWasUpdated(_arg_1:Badge):void
        {
            if (passFilter(_arg_1))
            {
                update();
            };
        }

        public function getFirstThumb():IWindowContainer
        {
            if (_SafeStr_1654.numGridItems == 0)
            {
                return (null);
            };
            return (_SafeStr_1654.getGridItemAt(0) as IWindowContainer);
        }

        public function setItems(_arg_1:Vector.<Badge>):void
        {
            _items = _arg_1;
            update();
        }

        private function update():void
        {
            var _local_2:Badge;
            var _local_3:Boolean;
            var _local_4:int;
            var _local_1:Vector.<Badge> = new Vector.<Badge>(0);
            for each (_local_2 in _items)
            {
                if (passFilter(_local_2))
                {
                    _local_1.push(_local_2);
                };
            };
            if (_local_1.length == _passedItems.length)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < _local_1.length)
                {
                    if (_local_1[_local_4] != _passedItems[_local_4])
                    {
                        _local_3 = true;
                        break;
                    };
                    _local_4++;
                };
                if (!_local_3)
                {
                    return;
                };
            };
            _passedItems = _local_1;
            changeToPage(_SafeStr_2271, true);
            updatePaging();
        }

        private function changeToPage(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_5:int;
            if (_arg_1 > -1)
            {
                if (((_SafeStr_2271 == _arg_1) && (!(_arg_2))))
                {
                    return;
                };
            }
            else
            {
                _arg_1 = 0;
            };
            _SafeStr_2271 = _arg_1;
            if (_SafeStr_2271 >= pageCount)
            {
                _SafeStr_2271 = (pageCount - 1);
            };
            _SafeStr_2271 = Math.max(_SafeStr_2271, 0);
            _currentPageItems = new Vector.<Badge>(0);
            clearGrid();
            var _local_3:int = (_SafeStr_2271 * _SafeStr_2718);
            var _local_4:int = (_local_3 + _SafeStr_2718);
            _local_4 = Math.min(_local_4, _passedItems.length);
            _local_5 = _local_3;
            while (_local_5 < _local_4)
            {
                _SafeStr_1654.addGridItem(_passedItems[_local_5].window);
                _currentPageItems.push(_passedItems[_local_5]);
                _local_5++;
            };
        }

        private function updatePassedItems(_arg_1:Badge):void
        {
        }

        private function updatePaging():void
        {
            var _local_4:IRegionWindow;
            var _local_3:int;
            var _local_2:ITextWindow;
            if (!_SafeStr_2716)
            {
                return;
            };
            var _local_1:int = pageCount;
            _SafeStr_2716.visible = (_local_1 > 1);
            if (_SafeStr_2271 >= _local_1)
            {
                _SafeStr_2271 = (_local_1 - 1);
            };
            _SafeStr_2271 = Math.max(_SafeStr_2271, 0);
            if (pageCount != _SafeStr_2716.numListItems)
            {
                for each (_local_4 in _SafeStr_2716)
                {
                    _local_4.removeEventListener("WME_CLICK", onPageEventProc);
                };
                _SafeStr_2716.destroyListItems();
                _local_3 = 0;
                while (_local_3 < _local_1)
                {
                    _local_4 = (_SafeStr_2717.clone() as IRegionWindow);
                    _local_4.addEventListener("WME_CLICK", onPageEventProc);
                    _local_4.addEventListener("WME_OVER", onPageEventProc);
                    _local_4.addEventListener("WME_OUT", onPageEventProc);
                    _local_4.id = _local_3;
                    _local_4.name = ("page_" + _local_3);
                    _SafeStr_2716.addListItem(_local_4);
                    _local_3++;
                };
            };
            _local_3 = 0;
            while (_local_3 < _local_1)
            {
                _local_4 = (_SafeStr_2716.getListItemAt(_local_3) as IRegionWindow);
                _local_2 = (_local_4.findChildByTag("PAGE") as ITextWindow);
                _local_2.caption = _local_3.toString();
                if (_local_3 == _SafeStr_2271)
                {
                    _local_2.underline = true;
                    _local_2.textColor = 0xFF0000;
                }
                else
                {
                    _local_2.underline = false;
                    _local_2.textColor = 0;
                };
                _local_3++;
            };
        }

        private function onPageEventProc(_arg_1:WindowMouseEvent):void
        {
            var _local_3:int = _arg_1.window.id;
            var _local_2:ITextWindow = ((_arg_1.target as IWindowContainer).findChildByTag("PAGE") as ITextWindow);
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    changeToPage(_local_3);
                    updatePaging();
                    return;
                case "WME_OVER":
                    _local_2.textColor = 0xFF0000;
                    return;
                case "WME_OUT":
                    if (_local_3 != _SafeStr_2271)
                    {
                        _local_2.textColor = 0;
                    };
                    return;
            };
        }

        private function passFilter(_arg_1:Badge):Boolean
        {
            var _local_2:String;
            var _local_3:String;
            if ((((_arg_1 == null) || (_arg_1.badgeName == null)) || (_arg_1.badgeDescription == null)))
            {
                return (false);
            };
            if (_SafeStr_2719.length > 0)
            {
                _local_2 = _arg_1.badgeName.toLowerCase();
                _local_3 = _arg_1.badgeDescription.toLowerCase();
                if (((_local_2.indexOf(_SafeStr_2719) == -1) && (_local_3.indexOf(_SafeStr_2719) == -1)))
                {
                    return (false);
                };
            };
            return (true);
        }


    }
}


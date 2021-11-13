package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.ui.widget.events.ChooserItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ChooserView 
    {

        private const COLOR_EVEN:uint = 4293848814;
        private const COLOR_ODD:uint = 0;
        private const COLOR_HILITE:uint = 4282169599;

        private var _SafeStr_1324:ChooserWidgetBase;
        private var _SafeStr_906:String;
        private var _window:IFrameWindow;
        private var _itemList:IItemListWindow;
        private var _items:Array;
        private var _SafeStr_3990:Boolean;
        private var _SafeStr_1290:int;

        public function ChooserView(_arg_1:ChooserWidgetBase, _arg_2:String)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_906 = _arg_2;
        }

        public function dispose():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function isOpen():Boolean
        {
            return ((!(_window == null)) && (_window.visible));
        }

        public function populate(_arg_1:Array, _arg_2:Boolean):void
        {
            var _local_4:ChooserItem;
            var _local_5:IWindowContainer;
            var _local_6:int;
            var _local_7:ITextWindow;
            if (_SafeStr_1324 == null)
            {
                return;
            };
            if (_window == null)
            {
                createWindow();
            };
            if ((((_window == null) || (_itemList == null)) || (_arg_1 == null)))
            {
                return;
            };
            _itemList.destroyListItems();
            var _local_3:XmlAsset = XmlAsset(_SafeStr_1324.assets.getAssetByName("chooser_item"));
            if (_local_3 == null)
            {
                return;
            };
            _items = _arg_1.slice();
            _SafeStr_3990 = _arg_2;
            _local_6 = 0;
            while (_local_6 < _arg_1.length)
            {
                _local_4 = (_arg_1[_local_6] as ChooserItem);
                if (_local_4 != null)
                {
                    _local_5 = (_SafeStr_1324.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
                    if (_local_5 == null)
                    {
                        return;
                    };
                    _local_7 = (_local_5.findChildByName("itemtext") as ITextWindow);
                    if (_local_7 == null)
                    {
                        return;
                    };
                    _local_5.id = _local_6;
                    if (_SafeStr_3990)
                    {
                        _local_7.text = ((_local_4.name + " id: ") + _local_4.id);
                    }
                    else
                    {
                        _local_7.text = _local_4.name;
                    };
                    _local_5.color = ((_local_6 % 2) ? 0 : 4293848814);
                    _local_5.addEventListener("WME_CLICK", onListItemClicked);
                    _itemList.addListItem(_local_5);
                };
                _local_6++;
            };
            _local_6 = 0;
            while (_local_6 < _itemList.numListItems)
            {
                _local_5 = (_itemList.getListItemAt(_local_6) as IWindowContainer);
                if (_local_5 != null)
                {
                    _local_5.width = _itemList.width;
                };
                _local_6++;
            };
            _SafeStr_1290 = -1;
        }

        private function createWindow():void
        {
            var _local_1:XmlAsset = XmlAsset(_SafeStr_1324.assets.getAssetByName("chooser_view"));
            if (_local_1 == null)
            {
                return;
            };
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (_window == null)
            {
                return;
            };
            _window.caption = _SafeStr_906;
            _itemList = (_window.findChildByName("item_list") as IItemListWindow);
            var _local_2:IWindow = _window.findChildByTag("close");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onClose);
            };
            if (_window.parent != null)
            {
                _window.x = ((_window.parent.width - _window.width) - 10);
                _window.y = 10;
            };
        }

        private function hideWindow():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onListItemClicked(_arg_1:WindowMouseEvent):void
        {
            if ((((_arg_1 == null) || (_arg_1.window == null)) || (_items == null)))
            {
                return;
            };
            var _local_3:int = _arg_1.window.id;
            if (((_local_3 < 0) || (_local_3 > _items.length)))
            {
                return;
            };
            var _local_2:ChooserItem = (_items[_local_3] as ChooserItem);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_1324.choose(_local_2.id, _local_2.category);
            highlightItem(_local_3);
        }

        private function highlightItem(_arg_1:int):void
        {
            var _local_2:IWindowContainer;
            if (((((_itemList == null) || (_arg_1 < 0)) || (_arg_1 > _itemList.numListItems)) || (_arg_1 == _SafeStr_1290)))
            {
                return;
            };
            if (_SafeStr_1290 != -1)
            {
                _local_2 = (_itemList.getListItemAt(_SafeStr_1290) as IWindowContainer);
                if (_local_2 != null)
                {
                    _local_2.color = ((_SafeStr_1290 % 2) ? 0 : 4293848814);
                };
            };
            _local_2 = (_itemList.getListItemAt(_arg_1) as IWindowContainer);
            if (_local_2 != null)
            {
                _local_2.color = 4282169599;
                _SafeStr_1290 = _arg_1;
            };
        }

        public function removeItem(_arg_1:int, _arg_2:int):void
        {
            var _local_3:ChooserItem;
            var _local_4:int;
            if (((_items == null) || (_itemList == null)))
            {
                return;
            };
            _local_4 = 0;
            while (_local_4 < _items.length)
            {
                _local_3 = (_items[_local_4] as ChooserItem);
                if (_local_3 != null)
                {
                    if (((_local_3.id == _arg_1) && (_local_3.category == _arg_2)))
                    {
                        _items.splice(_local_4, 1);
                        break;
                    };
                };
                _local_4++;
            };
            populate(_items, _SafeStr_3990);
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            hideWindow();
        }


    }
}


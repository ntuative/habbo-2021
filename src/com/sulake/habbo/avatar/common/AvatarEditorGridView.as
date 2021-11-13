package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IScrollableGridWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class AvatarEditorGridView implements IAvatarEditorGridView 
    {

        public static const REMOVE_ITEM:String = "REMOVE_ITEM";
        public static const GET_MORE:String = "GET_MORE";

        private const MAX_COLOR_LAYERS:int = 2;

        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_1275:IAvatarEditorCategoryModel;
        private var _SafeStr_1282:IItemGridWindow;
        private var _SafeStr_1281:Array;
        private var _SafeStr_1283:String;
        private var _notification:IWindow;
        private var _SafeStr_906:IWindow;

        public function AvatarEditorGridView(_arg_1:IWindowContainer)
        {
            _SafeStr_570 = _arg_1;
            _SafeStr_1282 = (_SafeStr_570.findChildByName("thumbs") as IItemGridWindow);
            _SafeStr_1281 = [];
            _SafeStr_1281.push((_SafeStr_570.findChildByName("palette0") as IItemGridWindow));
            _SafeStr_1281.push((_SafeStr_570.findChildByName("palette1") as IItemGridWindow));
            _notification = _SafeStr_570.findChildByName("content_notification");
            _SafeStr_906 = _SafeStr_570.findChildByName("content_title");
            _notification.visible = false;
            _SafeStr_906.visible = false;
        }

        public function dispose():void
        {
            if (_SafeStr_1282)
            {
                _SafeStr_1282.dispose();
                _SafeStr_1282 = null;
            };
            if (_SafeStr_1281)
            {
                for each (var _local_1:IItemGridWindow in _SafeStr_1281)
                {
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                        _local_1 = null;
                    };
                };
                _SafeStr_1281 = null;
            };
            _SafeStr_1275 = null;
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        public function get window():IWindowContainer
        {
            if (_SafeStr_570 == null)
            {
                return (null);
            };
            if (_SafeStr_570.disposed)
            {
                return (null);
            };
            return (_SafeStr_570);
        }

        public function initFromList(_arg_1:IAvatarEditorCategoryModel, _arg_2:String):void
        {
            var _local_3:int;
            var _local_6:Array;
            var _local_4:CategoryData = _arg_1.getCategoryData(_arg_2);
            if (!_local_4)
            {
                return;
            };
            _SafeStr_570.visible = true;
            _SafeStr_1275 = _arg_1;
            _SafeStr_1283 = _arg_2;
            _SafeStr_1282.removeGridItems();
            if (_local_4.parts.length == 0)
            {
                _SafeStr_906.visible = true;
                _notification.visible = true;
            }
            else
            {
                _SafeStr_906.visible = false;
                _notification.visible = false;
                for each (var _local_8:IItemGridWindow in _SafeStr_1281)
                {
                    _local_8.removeGridItems();
                };
                for each (var _local_5:AvatarEditorGridPartItem in _local_4.parts)
                {
                    if (_local_5)
                    {
                        _SafeStr_1282.addGridItem(_local_5.view);
                        _local_5.view.addEventListener("WME_CLICK", onGridItemClicked);
                        if (_local_5.isSelected)
                        {
                            showPalettes(_local_5.colorLayerCount);
                        };
                    };
                };
                _local_3 = 0;
                while (_local_3 < 2)
                {
                    _local_6 = _local_4.getPalette(_local_3);
                    _local_8 = (_SafeStr_1281[_local_3] as IItemGridWindow);
                    if (!((!(_local_6)) || (!(_local_8))))
                    {
                        for each (var _local_7:AvatarEditorGridColorItem in _local_6)
                        {
                            _local_8.addGridItem(_local_7.view);
                            _local_7.view.procedure = paletteEventProc;
                        };
                    };
                    _local_3++;
                };
            };
        }

        public function showPalettes(_arg_1:int):void
        {
            var _local_4:IScrollableGridWindow = (_SafeStr_570.findChildByName("palette0") as IScrollableGridWindow);
            var _local_3:IScrollableGridWindow = (_SafeStr_570.findChildByName("palette1") as IScrollableGridWindow);
            var _local_5:int = _SafeStr_1282.width;
            var _local_2:int = int(((_SafeStr_1282.width - 10) / 2));
            if (_arg_1 <= 1)
            {
                _local_4.width = _local_5;
                _local_4.visible = true;
                _local_3.visible = false;
            }
            else
            {
                _local_4.width = _local_2;
                _local_3.width = _local_2;
                _local_3.x = (_local_4.right + 10);
                _local_4.visible = true;
                _local_3.visible = true;
            };
        }

        public function updatePart(_arg_1:int, _arg_2:IWindowContainer):void
        {
            var _local_3:IWindow = _SafeStr_1282.getGridItemAt(_arg_1);
            if (!_local_3)
            {
                return;
            };
            _local_3 = _arg_2;
        }

        private function onGridItemClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:int;
            switch (_arg_1.target.name)
            {
                case "REMOVE_ITEM":
                    _local_2 = _SafeStr_1282.getGridItemIndex(_arg_1.window);
                    _SafeStr_1275.selectPart(_SafeStr_1283, _local_2);
                    return;
                case "GET_MORE":
                    _SafeStr_1275.controller.manager.catalog.openCatalogPage(_SafeStr_1275.controller.manager.getProperty("catalog.clothes.page"));
                    return;
                default:
                    _local_2 = _SafeStr_1282.getGridItemIndex(_arg_1.window);
                    _SafeStr_1275.selectPart(_SafeStr_1283, _local_2);
                    return;
            };
        }

        private function paletteEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:int;
            var _local_4:IItemGridWindow;
            var _local_7:int;
            var _local_3:IWindow;
            var _local_6:int;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _arg_1.window;
                _local_6 = 0;
                while (_local_6 < 2)
                {
                    if (_SafeStr_1281.length > _local_6)
                    {
                        _local_4 = (_SafeStr_1281[_local_6] as IItemGridWindow);
                        _local_7 = _local_4.getGridItemIndex(_local_3);
                        if (_local_7 > -1)
                        {
                            _SafeStr_1275.selectColor(_SafeStr_1283, _local_7, _local_6);
                            return;
                        };
                    };
                    _local_6++;
                };
            };
        }


    }
}


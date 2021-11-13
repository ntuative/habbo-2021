package com.sulake.habbo.groups
{
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.users.GuildColorData;
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.ColorTransform;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.runtime.exceptions.Exception;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class ColorGridCtrl 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _SafeStr_2607:IWindowContainer;
        private var _parentCallback:Function;
        private var _SafeStr_2625:Vector.<GuildColorData>;
        private var _SafeStr_2626:IItemGridWindow;
        private var _selectedColorIndex:int = -1;
        private var _SafeStr_2627:BitmapData;
        private var _SafeStr_2628:BitmapData;
        private var _SafeStr_2629:BitmapData;
        private var _disposed:Boolean = false;

        public function ColorGridCtrl(_arg_1:HabboGroupsManager, _arg_2:Function)
        {
            _SafeStr_825 = _arg_1;
            _parentCallback = _arg_2;
        }

        public function get selectedColorIndex():int
        {
            return (_selectedColorIndex);
        }

        public function get isInitialized():Boolean
        {
            return ((!(_SafeStr_2625 == null)) && (!(_SafeStr_2626 == null)));
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_2626)
                {
                    _SafeStr_2626.destroyGridItems();
                    _SafeStr_2626 = null;
                };
                if (_SafeStr_2628)
                {
                    _SafeStr_2628.dispose();
                    _SafeStr_2628 = null;
                };
                if (_SafeStr_2629)
                {
                    _SafeStr_2629.dispose();
                    _SafeStr_2629 = null;
                };
                if (_SafeStr_2628)
                {
                    _SafeStr_2628.dispose();
                    _SafeStr_2628 = null;
                };
                if (_SafeStr_2627)
                {
                    _SafeStr_2627.dispose();
                    _SafeStr_2627 = null;
                };
                _SafeStr_825 = null;
                _SafeStr_2607 = null;
                _disposed = true;
            };
        }

        public function createAndAttach(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Vector.<GuildColorData>):void
        {
            var _local_4:IWindowContainer;
            if (((((!(_SafeStr_2626 == null)) || (_arg_1 == null)) || (_arg_2 == null)) || (_arg_3 == null)))
            {
                return;
            };
            _SafeStr_2607 = _arg_1;
            _SafeStr_2625 = _arg_3;
            _SafeStr_2626 = (_SafeStr_2607.findChildByName(_arg_2) as IItemGridWindow);
            _SafeStr_2628 = getBitmap("color_chooser_bg");
            _SafeStr_2629 = getBitmap("color_chooser_fg");
            _SafeStr_2627 = getBitmap("color_chooser_selected");
            for each (var _local_5:GuildColorData in _SafeStr_2625)
            {
                _local_4 = (_SafeStr_825.getXmlWindow("badge_color_item") as IWindowContainer);
                _local_4.procedure = onClick;
                _local_4.background = true;
                _local_4.color = 4290689957;
                _local_4.width = _SafeStr_2628.width;
                _local_4.height = _SafeStr_2628.height;
                setGridItemBitmap(_local_4, "background", _SafeStr_2628, true, null);
                setGridItemBitmap(_local_4, "foreground", _SafeStr_2629, true, _local_5);
                setGridItemBitmap(_local_4, "selected", _SafeStr_2627, false, null);
                _SafeStr_2626.addGridItem(_local_4);
            };
        }

        private function setGridItemBitmap(_arg_1:IWindowContainer, _arg_2:String, _arg_3:BitmapData, _arg_4:Boolean, _arg_5:GuildColorData=null):void
        {
            var _local_7:BitmapData;
            var _local_6:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_6 != null)
            {
                _local_7 = _arg_3.clone();
                if (_arg_5 != null)
                {
                    _local_7.colorTransform(_local_7.rect, new ColorTransform((_arg_5.red / 0xFF), (_arg_5.green / 0xFF), (_arg_5.blue / 0xFF)));
                };
                _local_6.bitmap = _local_7;
                _local_6.visible = _arg_4;
            };
        }

        public function setSelectedColorIndex(_arg_1:int, _arg_2:Boolean=true):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (((!(_selectedColorIndex == _arg_1)) && (_arg_1 < _SafeStr_2626.numGridItems)))
            {
                setSelectedItemVisibility(_selectedColorIndex, false);
                _selectedColorIndex = _arg_1;
                setSelectedItemVisibility(_selectedColorIndex, true);
            };
            if (((_arg_2) && (!(_parentCallback == null))))
            {
                (_parentCallback(this));
            };
        }

        public function setSelectedColorById(_arg_1:int):void
        {
            var _local_2:int;
            if (!isInitialized)
            {
                return;
            };
            _local_2 = 0;
            while (_local_2 < _SafeStr_2625.length)
            {
                if (_SafeStr_2625[_local_2].id == _arg_1)
                {
                    setSelectedColorIndex(_local_2);
                    return;
                };
                _local_2++;
            };
            setSelectedColorIndex(0);
        }

        public function getSelectedColorId():int
        {
            var _local_1:GuildColorData = getSelectedColorData();
            if (_local_1 != null)
            {
                return (_local_1.id);
            };
            return (0);
        }

        public function getSelectedColorData():GuildColorData
        {
            if ((((!(_SafeStr_2625 == null)) && (_selectedColorIndex >= 0)) && (_selectedColorIndex < _SafeStr_2625.length)))
            {
                return (_SafeStr_2625[_selectedColorIndex]);
            };
            return (null);
        }

        private function getBitmap(_arg_1:String):BitmapData
        {
            var _local_3:BitmapData;
            var _local_2:BitmapDataAsset = (_SafeStr_825.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2)
            {
                _local_3 = (_local_2.content as BitmapData);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            throw (new Exception((("Failed to load bitmap asset " + _arg_1) + " in ColorGridWidget")));
        }

        private function setSelectedItemVisibility(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:IWindow;
            if (((_arg_1 < 0) || (_arg_1 >= _SafeStr_2626.numGridItems)))
            {
                return;
            };
            var _local_4:IWindowContainer = (_SafeStr_2626.getGridItemAt(_arg_1) as IWindowContainer);
            if (_local_4 != null)
            {
                _local_3 = (_local_4.findChildByName("selected") as IWindow);
                if (_local_3 != null)
                {
                    _local_3.visible = _arg_2;
                };
            };
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            setSelectedColorIndex(_SafeStr_2626.getGridItemIndex(_arg_2));
        }


    }
}


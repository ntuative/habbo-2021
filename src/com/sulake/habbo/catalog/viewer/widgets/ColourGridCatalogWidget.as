package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ColourGridCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _colours:Array;
        private var _colourGrid:IItemGridWindow;
        private var _colourChooserLayout:XML;
        private var _colourChooserBackground:BitmapData;
        private var _SafeStr_1562:BitmapData;
        private var _colourChosen:BitmapData;
        private var _SafeStr_1563:IWindowContainer;

        public function ColourGridCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            if (!_colourGrid.disposed)
            {
                _colourGrid.destroyGridItems();
                _colourGrid.dispose();
            };
            _colourGrid = null;
            _colourChooserLayout = null;
            _SafeStr_1563 = null;
            events.removeEventListener("COLOUR_ARRAY", onAvailableColours);
            events.removeEventListener("MULTI_COLOUR_ARRAY", onAvailableMultiColours);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("colourGridWidget");
            var _local_2:Boolean = (_window.tags.indexOf("FIXED") > -1);
            if (!_local_2)
            {
                _window.getChildAt(0).width = _window.width;
                _window.getChildAt(0).height = _window.height;
            };
            _colourGrid = (_window.findChildByName("colourGrid") as IItemGridWindow);
            _colourGrid.width = window.width;
            _colourGrid.height = window.height;
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("color_chooser_cell") as XmlAsset);
            _colourChooserLayout = (_local_1.content as XML);
            events.addEventListener("COLOUR_ARRAY", onAvailableColours);
            events.addEventListener("MULTI_COLOUR_ARRAY", onAvailableMultiColours);
            return (true);
        }

        private function onAvailableColours(_arg_1:CatalogWidgetColoursEvent):void
        {
            _colours = [];
            for each (var _local_4:int in _arg_1.colours)
            {
                _colours.push([_local_4]);
            };
            var _local_5:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1.backgroundAssetName) as BitmapDataAsset);
            _colourChooserBackground = (_local_5.content as BitmapData);
            var _local_3:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1.colourAssetName) as BitmapDataAsset);
            _SafeStr_1562 = (_local_3.content as BitmapData);
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1.chosenColourAssetName) as BitmapDataAsset);
            _colourChosen = (_local_2.content as BitmapData);
            populateColourGrid();
            select((_colourGrid.getGridItemAt(_arg_1.index) as IWindowContainer));
        }

        private function onAvailableMultiColours(_arg_1:CatalogWidgetMultiColoursEvent):void
        {
            _colours = [];
            for each (var _local_4:Array in _arg_1.colours)
            {
                _colours.push(_local_4.slice());
            };
            var _local_5:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1.backgroundAssetName) as BitmapDataAsset);
            _colourChooserBackground = (_local_5.content as BitmapData);
            var _local_3:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1.colourAssetName) as BitmapDataAsset);
            _SafeStr_1562 = (_local_3.content as BitmapData);
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1.chosenColourAssetName) as BitmapDataAsset);
            _colourChosen = (_local_2.content as BitmapData);
            populateColourGrid();
            select((_colourGrid.getGridItemAt(0) as IWindowContainer));
        }

        private function select(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindow;
            Logger.log(("[ColourGridCatalogWidget] Select: " + _arg_1));
            if (_SafeStr_1563 != null)
            {
                _local_2 = _SafeStr_1563.getChildByName("chosen");
                if (_local_2 != null)
                {
                    _local_2.visible = false;
                };
            };
            _SafeStr_1563 = _arg_1;
            if (_SafeStr_1563 != null)
            {
                _local_2 = _SafeStr_1563.getChildByName("chosen");
            };
            if (_local_2 != null)
            {
                _local_2.visible = true;
            };
        }

        private function populateColourGrid():void
        {
            var _local_4:IWindowContainer;
            var _local_7:IBitmapWrapperWindow;
            var _local_12:IBitmapWrapperWindow;
            var _local_9:uint;
            var _local_2:uint;
            var _local_1:uint;
            var _local_5:BitmapData;
            var _local_3:BitmapData;
            var _local_10:int;
            var _local_6:int;
            var _local_11:int;
            var _local_8:IBitmapWrapperWindow;
            Logger.log(("[ColourGridCatalogWidget] Display colors: " + [_colours.length, _colourGrid.numGridItems]));
            _colourGrid.destroyGridItems();
            _SafeStr_1563 = null;
            for each (var _local_13:Array in _colours)
            {
                if (_local_13.length > 0)
                {
                    _local_4 = (page.viewer.catalog.windowManager.buildFromXML(_colourChooserLayout) as IWindowContainer);
                    _local_4.addEventListener("WME_CLICK", onClick);
                    _local_4.background = true;
                    _local_4.color = 0xFFFFFFFF;
                    _local_4.width = _colourChooserBackground.width;
                    _local_4.height = _colourChooserBackground.height;
                    _colourGrid.addGridItem(_local_4);
                    _local_7 = (_local_4.findChildByTag("BG_BORDER") as IBitmapWrapperWindow);
                    if (_local_7 != null)
                    {
                        _local_7.bitmap = new BitmapData(_colourChooserBackground.width, _colourChooserBackground.height, true, 0);
                        _local_7.bitmap.copyPixels(_colourChooserBackground, _colourChooserBackground.rect, new Point(0, 0));
                    };
                    _local_12 = (_local_4.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
                    if (_local_12 != null)
                    {
                        _local_12.bitmap = new BitmapData(_SafeStr_1562.width, _SafeStr_1562.height, true, 0);
                        _local_9 = 0xFF;
                        _local_2 = 0xFF;
                        _local_1 = 0xFF;
                        _local_5 = null;
                        _local_3 = null;
                        _local_10 = _local_13[0];
                        if (_local_10 >= 0)
                        {
                            _local_9 = ((_local_10 >> 16) & 0xFF);
                            _local_2 = ((_local_10 >> 8) & 0xFF);
                            _local_1 = ((_local_10 >> 0) & 0xFF);
                        };
                        _local_5 = _SafeStr_1562.clone();
                        _local_5.colorTransform(_local_5.rect, new ColorTransform((_local_9 / 0xFF), (_local_2 / 0xFF), (_local_1 / 0xFF)));
                        if (_local_13.length > 1)
                        {
                            _local_6 = _local_13[1];
                            if (_local_6 >= 0)
                            {
                                _local_9 = ((_local_6 >> 16) & 0xFF);
                                _local_2 = ((_local_6 >> 8) & 0xFF);
                                _local_1 = ((_local_6 >> 0) & 0xFF);
                            };
                            _local_3 = _SafeStr_1562.clone();
                            _local_3.colorTransform(_local_3.rect, new ColorTransform((_local_9 / 0xFF), (_local_2 / 0xFF), (_local_1 / 0xFF)));
                        };
                        _local_12.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
                        _local_5.dispose();
                        if (_local_3 != null)
                        {
                            _local_11 = int((_local_3.width / 2));
                            _local_12.bitmap.copyPixels(_local_3, new Rectangle(_local_11, 0, (_local_3.width - _local_11), _local_3.height), new Point((_local_3.width / 2), 0));
                            _local_3.dispose();
                        };
                    };
                    _local_8 = (_local_4.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow);
                    if (_local_8 != null)
                    {
                        _local_8.bitmap = new BitmapData(_colourChosen.width, _colourChosen.height, true, 0xFFFFFF);
                        _local_8.bitmap.copyPixels(_colourChosen, _colourChosen.rect, new Point(0, 0), null, null, true);
                        _local_8.visible = false;
                    };
                };
            };
        }

        private function onClick(_arg_1:WindowMouseEvent):void
        {
            select((_arg_1.target as IWindowContainer));
            var _local_2:int = _colourGrid.getGridItemIndex((_arg_1.target as IWindow));
            events.dispatchEvent(new CatalogWidgetColourIndexEvent(_local_2));
        }


    }
}


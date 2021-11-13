package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.catalog.viewer.IProductContainer;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;
    import __AS3__.vec.Vector;

    public class BundleGridViewCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid, IProductContainer 
    {

        private var _offer:IPurchasableOffer;
        private var _gridItemLayout:XML;
        private var _itemGrid:IItemGridWindow;

        public function BundleGridViewCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            events.addEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            _gridItemLayout = (_local_1.content as XML);
            _itemGrid = IItemGridWindow(_window.findChildByName("bundleGrid"));
            return (true);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                events.removeEventListener("SELECT_PRODUCT", onSelectProduct);
                events.removeEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
                super.dispose();
            };
        }

        private function onWidgetsInitialized(_arg_1:CatalogWidgetEvent):void
        {
            var _local_2:IPurchasableOffer;
            if (page.offers.length == 1)
            {
                _local_2 = page.offers[0];
                if (_local_2 != null)
                {
                    events.dispatchEvent(new SelectProductEvent(_local_2));
                };
            };
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            _offer = _arg_1.offer;
            _itemGrid.destroyGridItems();
            populateItemGrid();
        }

        protected function populateItemGrid():void
        {
            var _local_5:IWindowContainer;
            var _local_1:IWindow;
            var _local_4:BitmapData;
            var _local_2:IWindowContainer = (_offer.page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as IWindowContainer);
            for each (var _local_3:IProduct in _offer.productContainer.products)
            {
                if (_local_3.productType != "b")
                {
                    _local_5 = (_local_2.clone() as IWindowContainer);
                    _local_1 = _local_5.findChildByName("clubLevelIcon");
                    if (_local_1 != null)
                    {
                        _local_1.visible = false;
                    };
                    _itemGrid.addGridItem(_local_5);
                    _local_3.view = _local_5;
                    _local_4 = _local_3.initIcon(this);
                    if (_local_4 != null)
                    {
                        _local_4.dispose();
                    };
                    _local_3.grid = this;
                };
            };
        }

        public function get offer():IPurchasableOffer
        {
            return (_offer);
        }

        public function select(_arg_1:IGridItem, _arg_2:Boolean):void
        {
        }

        public function startDragAndDrop(_arg_1:IGridItem):Boolean
        {
            return (false);
        }

        public function initProductIcon(_arg_1:IRoomEngine, _arg_2:IStuffData=null):void
        {
        }

        public function activate():void
        {
        }

        public function get products():Vector.<IProduct>
        {
            return (null);
        }

        public function get firstProduct():IProduct
        {
            return (null);
        }

        public function set view(_arg_1:IWindowContainer):void
        {
        }

        public function get view():IWindowContainer
        {
            return (null);
        }

        public function set grid(_arg_1:IItemGrid):void
        {
        }

        public function setClubIconLevel(_arg_1:int):void
        {
        }


    }
}
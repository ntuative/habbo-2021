package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import flash.utils.Timer;
    import com.sulake.habbo.session.ISessionDataManager;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.viewer.BundleProductContainer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.viewer.IProductContainer;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;

    public class ItemGridCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid, IDragAndDropDoneReceiver 
    {

        protected var _itemGrid:IItemGridWindow;
        protected var _gridItemLayout:XML;
        protected var _SafeStr_1571:XML;
        protected var _SafeStr_1572:XML;
        protected var _SafeStr_1563:IGridItem;
        private var _bundleCounter:int = 0;
        protected var _SafeStr_1163:Timer;
        protected var _SafeStr_1573:Boolean = true;
        private var _offerInitIndex:int = 0;
        protected var _session:ISessionDataManager;
        private var _SafeStr_1574:int = -1;
        private var _selectedGuildColor1:String;
        private var _selectedGuildColor2:String;
        private var _SafeStr_1575:String;
        private var _SafeStr_1460:String;
        public var itemColors:Dictionary = new Dictionary();
        public var chosenItemColorIndex:int = 0;
        private var lastChosenColorIndex:int = 0;

        public function ItemGridCatalogWidget(_arg_1:IWindowContainer, _arg_2:ISessionDataManager, _arg_3:String)
        {
            super(_arg_1);
            _session = _arg_2;
            _SafeStr_1460 = _arg_3;
        }

        override public function dispose():void
        {
            if (_SafeStr_1163 != null)
            {
                _SafeStr_1163.stop();
                _SafeStr_1163.removeEventListener("timer", loadItemGridGraphics);
                _SafeStr_1163 = null;
            };
            if (_itemGrid != null)
            {
                _itemGrid.destroyGridItems();
                _itemGrid = null;
            };
            _gridItemLayout = null;
            _SafeStr_1571 = null;
            _SafeStr_1572 = null;
            _SafeStr_1563 = null;
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("itemGridWidget");
            var _local_2:Boolean = (_window.tags.indexOf("FIXED") > -1);
            _itemGrid = (_window.findChildByName("itemGrid") as IItemGridWindow);
            if (!_local_2)
            {
                _window.getChildAt(0).width = _window.width;
                _window.getChildAt(0).height = _window.height;
            };
            _itemGrid.verticalSpacing = 0;
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            _gridItemLayout = (_local_1.content as XML);
            _local_1 = (page.viewer.catalog.assets.getAssetByName("grid_item_with_price_single") as XmlAsset);
            _SafeStr_1572 = (_local_1.content as XML);
            _local_1 = (page.viewer.catalog.assets.getAssetByName("grid_item_with_price_multi") as XmlAsset);
            _SafeStr_1571 = (_local_1.content as XML);
            populateItemGrid();
            if (_SafeStr_1573)
            {
                _SafeStr_1163 = new Timer(25);
                _SafeStr_1163.addEventListener("timer", loadItemGridGraphics);
                _SafeStr_1163.start();
            }
            else
            {
                loadItemGridGraphics();
            };
            events.addEventListener("GUILD_SELECTED", onGuildSelected);
            events.addEventListener("COLOUR_INDEX", onColourIndex);
            return (true);
        }

        public function select(_arg_1:IGridItem, _arg_2:Boolean):void
        {
            if (_SafeStr_1563 != null)
            {
                _SafeStr_1563.deactivate();
            };
            _SafeStr_1563 = _arg_1;
            _arg_1.activate();
            if (_SafeStr_1563.view)
            {
                _SafeStr_1563.view.findChildByName("border_outline").color = ((_SafeStr_1460 == "NORMAL") ? 6538729 : 16758076);
            };
            var _local_4:ProductContainer = (_arg_1 as ProductContainer);
            if (!_local_4)
            {
                return;
            };
            if (_local_4.isLazy)
            {
                return;
            };
            var _local_3:IPurchasableOffer = _local_4.offer;
            if (_local_3 != null)
            {
                events.dispatchEvent(new SelectProductEvent(_local_3));
                if (((_local_3.product) && (_local_3.product.productType == "i")))
                {
                    events.dispatchEvent(new SetExtraPurchaseParameterEvent(_local_3.product.extraParam));
                };
            };
            if (_arg_2)
            {
                events.dispatchEvent(new CatalogWidgetColoursEvent(getCurrentItemColors(), "ctlg_clr_27x22_1", "ctlg_clr_27x22_2", "ctlg_clr_27x22_3", getCurrentItemColourIndex()));
            };
        }

        public function startDragAndDrop(_arg_1:IGridItem):Boolean
        {
            var _local_2:IPurchasableOffer = (_arg_1 as ProductContainer).offer;
            if (_local_2 != null)
            {
                if (_session.clubLevel >= _local_2.clubLevel)
                {
                    (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, _local_2);
                };
            };
            return (true);
        }

        public function onDragAndDropDone(_arg_1:Boolean, _arg_2:String):void
        {
            if (disposed)
            {
                return;
            };
            if (_arg_1)
            {
                events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false, _arg_2));
            };
        }

        public function stopDragAndDrop():void
        {
        }

        protected function populateItemGrid():void
        {
            var _local_4:String;
            var _local_5:int;
            var _local_1:IPurchasableOffer;
            var _local_2:uint;
            var _local_3:int;
            var _local_7:Array = [];
            var _local_6:Vector.<IPurchasableOffer> = new Vector.<IPurchasableOffer>();
            if (page.layoutCode == "default_3x3_color_grouping")
            {
                page.offers.sort(sortByColourIndex);
                for each (_local_1 in page.offers)
                {
                    if (((!(_local_1.product.furnitureData)) || (!(_local_1.product.isColorable))))
                    {
                        _local_6.push(_local_1);
                    }
                    else
                    {
                        _local_4 = _local_1.product.furnitureData.fullName.split("*")[0];
                        _local_5 = _local_1.product.furnitureData.fullName.split("*")[1];
                        if (!itemColors[_local_4])
                        {
                            itemColors[_local_4] = [];
                        };
                        if (_local_1.product.furnitureData.colours)
                        {
                            for each (_local_2 in _local_1.product.furnitureData.colours)
                            {
                                if (_local_2 != 0xFFFFFF)
                                {
                                    _local_3 = _local_2;
                                };
                            };
                            if (itemColors[_local_4].indexOf(_local_3) == -1)
                            {
                                itemColors[_local_4][_local_5] = _local_3;
                            };
                        };
                        if (_local_7.indexOf(_local_4) == -1)
                        {
                            _local_6.push(_local_1);
                            _local_7.push(_local_4);
                        };
                    };
                };
                page.offers.sort(sortByFurniTypeName);
            }
            else
            {
                _local_6 = page.offers;
            };
            for each (_local_1 in page.offers)
            {
                createGridItem(_local_1.gridItem, (!(_local_6.indexOf(_local_1) == -1)));
                _local_1.gridItem.grid = this;
                if (_local_1.pricingModel == "pricing_model_bundle")
                {
                    _bundleCounter++;
                    if ((_local_1.productContainer is BundleProductContainer))
                    {
                        (_local_1.productContainer as BundleProductContainer).setBundleCounter(_bundleCounter);
                    };
                };
            };
        }

        private function sortByColourIndex(_arg_1:IPurchasableOffer, _arg_2:IPurchasableOffer):int
        {
            if (((!(_arg_1.product.furnitureData.colourIndex)) || (!(_arg_2.product.furnitureData.colourIndex))))
            {
                return (1);
            };
            if (_arg_1.product.furnitureData.colourIndex > _arg_2.product.furnitureData.colourIndex)
            {
                return (1);
            };
            if (_arg_1 == _arg_2)
            {
                return (0);
            };
            return (-1);
        }

        private function sortByFurniTypeName(_arg_1:IPurchasableOffer, _arg_2:IPurchasableOffer):int
        {
            if (_arg_1.product.furnitureData.className > _arg_2.product.furnitureData.className)
            {
                return (1);
            };
            if (_arg_1 == _arg_2)
            {
                return (0);
            };
            return (-1);
        }

        protected function resetTimer():void
        {
            if (_SafeStr_1163 != null)
            {
                _SafeStr_1163.reset();
            };
            _offerInitIndex = 0;
        }

        protected function loadItemGridGraphics(_arg_1:TimerEvent=null):void
        {
            var _local_4:int;
            var _local_2:IPurchasableOffer;
            if (disposed)
            {
                return;
            };
            if (_arg_1 != null)
            {
            };
            var _local_3:int = page.offers.length;
            if (_local_3 > 0)
            {
                _local_4 = 0;
                while (_local_4 < 3)
                {
                    if (((_offerInitIndex >= 0) && (_offerInitIndex < _local_3)))
                    {
                        _local_2 = page.offers[_offerInitIndex];
                        loadGraphics(_local_2);
                        _local_2.productContainer.grid = this;
                    };
                    _offerInitIndex++;
                    if (_offerInitIndex >= _local_3)
                    {
                        resetTimer();
                        return;
                    };
                    _local_4++;
                };
            };
        }

        protected function createGridItem(_arg_1:IGridItem, _arg_2:Boolean=true):void
        {
            var _local_3:XML;
            var _local_4:IProductContainer = (_arg_1 as IProductContainer);
            var _local_6:Boolean = (((!(_local_4 == null)) && (!(_local_4.offer == null))) && ((_local_4.offer.priceInCredits > 0) || (_local_4.offer.priceInActivityPoints > 0)));
            if (((_local_6) && (!(_SafeStr_1460 == "BUILDERS_CLUB"))))
            {
                if ((((_local_4.offer) && (_local_4.offer.priceInCredits > 0)) && (_local_4.offer.priceInActivityPoints > 0)))
                {
                    _local_3 = _SafeStr_1571;
                }
                else
                {
                    _local_3 = _SafeStr_1572;
                };
            }
            else
            {
                _local_3 = _gridItemLayout;
            };
            var _local_5:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(_local_3) as IWindowContainer);
            if (_arg_2)
            {
                _itemGrid.addGridItem(_local_5);
            };
            _arg_1.view = _local_5;
            if ((_local_4 is ProductContainer))
            {
                (_local_4 as ProductContainer).createCurrencyIndicators((page.viewer.catalog as HabboCatalog));
            };
        }

        protected function loadGraphics(_arg_1:IPurchasableOffer):void
        {
            var _local_3:IStuffData;
            var _local_2:Array;
            var _local_4:StringArrayStuffData;
            if (((!(_arg_1 == null)) && (!(_arg_1.disposed))))
            {
                _local_3 = null;
                if (_SafeStr_1574 != -1)
                {
                    _local_2 = [];
                    _local_2.push("0");
                    _local_2.push(_SafeStr_1574.toString());
                    _local_2.push(_SafeStr_1575);
                    _local_2.push(_selectedGuildColor1);
                    _local_2.push(_selectedGuildColor2);
                    _local_4 = new StringArrayStuffData();
                    _local_4.setArray(_local_2);
                    _local_3 = _local_4;
                };
                _arg_1.productContainer.initProductIcon(page.viewer.roomEngine, _local_3);
            };
        }

        private function onGuildSelected(_arg_1:CatalogWidgetGuildSelectedEvent):void
        {
            if (disposed)
            {
                return;
            };
            _SafeStr_1574 = _arg_1.guildId;
            _selectedGuildColor1 = _arg_1.color1;
            _selectedGuildColor2 = _arg_1.color2;
            _SafeStr_1575 = _arg_1.badgeCode;
            _itemGrid.destroyGridItems();
            for each (var _local_2:IPurchasableOffer in page.offers)
            {
                createGridItem(_local_2.gridItem);
                loadGraphics(_local_2);
                _local_2.productContainer.grid = this;
            };
        }

        private function removeColorableGridItemIfExists(_arg_1:IPurchasableOffer):void
        {
            if (_itemGrid.getGridItemIndex(_arg_1.gridItem.view) >= 0)
            {
                _itemGrid.removeGridItem(_arg_1.gridItem.view);
            };
        }

        private function onColourIndex(_arg_1:CatalogWidgetColourIndexEvent):void
        {
            var _local_3:IPurchasableOffer = null;
            var _local_2:IPurchasableOffer;
            var _local_5:int;
            for each (_local_2 in page.offers)
            {
                if (_local_2.gridItem == _SafeStr_1563)
                {
                    _local_3 = _local_2;
                };
            };
            if (((!(_local_3)) || (!(_local_3.product.isColorable))))
            {
                return;
            };
            _local_5 = _itemGrid.getGridItemIndex(_local_3.gridItem.view);
            removeColorableGridItemIfExists(_local_3);
            var _local_4:String = ((_local_3.product.furnitureData.fullName.split("*")[0] + "*") + (_arg_1.index + 1));
            for each (_local_2 in page.offers)
            {
                if (_local_2.product.furnitureData.fullName == _local_4)
                {
                    _itemGrid.addGridItemAt(_local_2.gridItem.view, _local_5);
                    select(_local_2.gridItem, false);
                    _local_2.gridItem.grid = this;
                };
            };
        }

        public function getCurrentItemColors():Array
        {
            var _local_2:IPurchasableOffer = null;
            for each (var _local_1:IPurchasableOffer in page.offers)
            {
                if (_local_1.gridItem == _SafeStr_1563)
                {
                    _local_2 = _local_1;
                };
            };
            if (((!(_local_2)) || (!(_local_2.product.isColorable))))
            {
                return ([]);
            };
            return (itemColors[_local_2.product.furnitureData.fullName.split("*")[0]]);
        }

        private function getCurrentItemColourIndex():int
        {
            var _local_2:IPurchasableOffer = null;
            for each (var _local_1:IPurchasableOffer in page.offers)
            {
                if (_local_1.gridItem == _SafeStr_1563)
                {
                    _local_2 = _local_1;
                };
            };
            if (((!(_local_2)) || (!(_local_2.product.isColorable))))
            {
                return (0);
            };
            return (Math.max((_local_2.product.furnitureData.colourIndex - 1), 0));
        }


    }
}


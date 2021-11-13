package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.ISessionDataManager;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.events.WindowEvent;

    public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IDisposable, ICatalogWidget, IItemGrid 
    {

        private var _SafeStr_1619:Array = ["wallpaper", "floor", "landscape"];
        private var _SafeStr_1620:Array = [];
        private var _selectedGroup:int = 0;
        private var _SafeStr_1621:Array = [0, 0, 0];
        private var _SafeStr_1459:ISelectorWindow;
        private var _SafeStr_575:Array = ["group.walls", "group.floors", "group.views"];

        public function SpacesNewCatalogWidget(_arg_1:IWindowContainer, _arg_2:ISessionDataManager, _arg_3:String)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function dispose():void
        {
            super.dispose();
            for each (var _local_2:Vector.<IPurchasableOffer> in _SafeStr_1620)
            {
                for each (var _local_1:IPurchasableOffer in _local_2)
                {
                    _local_1.dispose();
                };
            };
            _SafeStr_1620 = null;
        }

        override public function init():Boolean
        {
            var _local_2:int;
            var _local_1:IWindow;
            Logger.log("Init Item Group Catalog Widget (Spaces New)");
            createOfferGroups();
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
            _SafeStr_1459 = (_window.findChildByName("groups") as ISelectorWindow);
            if (_SafeStr_1459)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_1459.numSelectables)
                {
                    _local_1 = _SafeStr_1459.getSelectableAt(_local_2);
                    if ((_local_1 is ISelectableWindow))
                    {
                        _local_1.addEventListener("WE_SELECTED", onSelectGroup);
                    };
                    _local_2++;
                };
            };
            switchCategory(_SafeStr_575[_selectedGroup]);
            updateRoomPreview();
            return (true);
        }

        public function onWidgetsInitialized(_arg_1:CatalogWidgetEvent):void
        {
            var _local_3:int = _SafeStr_1621[_selectedGroup];
            var _local_2:IPurchasableOffer = _SafeStr_1620[_selectedGroup][_local_3];
            this.select(_local_2.gridItem, false);
        }

        public function selectIndex(_arg_1:int):void
        {
            var _local_2:IPurchasableOffer;
            if (((_arg_1 > -1) && (_arg_1 < _itemGrid.numGridItems)))
            {
                _local_2 = _SafeStr_1620[_selectedGroup][_arg_1];
                this.select(_local_2.gridItem, false);
            };
        }

        override public function select(_arg_1:IGridItem, _arg_2:Boolean):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            super.select(_arg_1, false);
            var _local_3:IPurchasableOffer = (_arg_1 as ProductContainer).offer;
            if (_local_3 == null)
            {
                return;
            };
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(_local_3.product.extraParam));
            _SafeStr_1621[_selectedGroup] = (_SafeStr_1620[_selectedGroup] as Vector.<IPurchasableOffer>).indexOf(_local_3);
            updateRoomPreview();
        }

        private function updateRoomPreview():void
        {
            var _local_5:int = _SafeStr_1621[0];
            var _local_6:int = _SafeStr_1621[1];
            var _local_3:int = _SafeStr_1621[2];
            var _local_2:IPurchasableOffer = ((_SafeStr_1620[0].length > _local_5) ? _SafeStr_1620[0][_local_5] : null);
            var _local_4:IPurchasableOffer = ((_SafeStr_1620[1].length > _local_6) ? _SafeStr_1620[1][_local_6] : null);
            var _local_1:IPurchasableOffer = ((_SafeStr_1620[2].length > _local_3) ? _SafeStr_1620[2][_local_3] : null);
            if ((((!(_local_4)) || (!(_local_2))) || (!(_local_1))))
            {
                return;
            };
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_local_4.product.extraParam, _local_2.product.extraParam, _local_1.product.extraParam, 64));
        }

        private function createOfferGroups():Boolean
        {
            var _local_2:IProduct;
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            for each (var _local_1:IPurchasableOffer in page.offers)
            {
                if (((_local_1.pricingModel == "pricing_model_single") || (_local_1.pricingModel == "pricing_model_multi")))
                {
                    _local_2 = _local_1.product;
                    if (_local_2 != null)
                    {
                        _local_3 = _local_2.productClassId;
                        if (((_local_2.productType == "i") || (_local_2.productType == "s")))
                        {
                            if (_local_2.furnitureData != null)
                            {
                                _local_4 = _local_2.furnitureData.className;
                                _local_5 = _SafeStr_1619.indexOf(_local_4);
                                if (_SafeStr_1619.indexOf(_local_4) == -1)
                                {
                                    _SafeStr_1619.push(_local_4);
                                };
                                while (_SafeStr_1620.length < _SafeStr_1619.length)
                                {
                                    _SafeStr_1620.push(new Vector.<IPurchasableOffer>(0));
                                };
                                switch (_local_4)
                                {
                                    case "floor":
                                        (_SafeStr_1620[_local_5] as Vector.<IPurchasableOffer>).push(_local_1);
                                        break;
                                    case "wallpaper":
                                        (_SafeStr_1620[_local_5] as Vector.<IPurchasableOffer>).push(_local_1);
                                        break;
                                    case "landscape":
                                        (_SafeStr_1620[_local_5] as Vector.<IPurchasableOffer>).push(_local_1);
                                        break;
                                    default:
                                        Logger.log(("[Spaces Catalog Widget] : " + _local_4));
                                };
                            };
                        };
                    };
                };
            };
            page.replaceOffers(new Vector.<IPurchasableOffer>(0), false);
            return (true);
        }

        private function onSelectGroup(_arg_1:WindowEvent):void
        {
            var _local_2:int;
            var _local_3:ISelectableWindow = (_arg_1.target as ISelectableWindow);
            if (_local_3)
            {
                _local_2 = _SafeStr_1459.getSelectableIndex(_local_3);
                Logger.log(("select: " + [_local_3.name, _local_2]));
                switchCategory(_local_3.name);
            };
        }

        private function switchCategory(_arg_1:String):void
        {
            var _local_2:Vector.<IPurchasableOffer> = undefined;
            var _local_3:int;
            if (disposed)
            {
                return;
            };
            if (!_SafeStr_1459)
            {
                return;
            };
            _SafeStr_1459.setSelected(_SafeStr_1459.getSelectableByName(_arg_1));
            var _local_4:int = -1;
            switch (_arg_1)
            {
                case "group.walls":
                    _local_4 = 0;
                    break;
                case "group.floors":
                    _local_4 = 1;
                    break;
                case "group.views":
                    _local_4 = 2;
                    break;
                default:
                    _local_4 = -1;
            };
            if (_local_4 > -1)
            {
                if (_SafeStr_1563 != null)
                {
                    _SafeStr_1563.deactivate();
                };
                _SafeStr_1563 = null;
                _selectedGroup = _local_4;
                if (_itemGrid)
                {
                    _itemGrid.destroyGridItems();
                };
                _local_2 = ((_SafeStr_1620[_selectedGroup] == null) ? new Vector.<IPurchasableOffer>(0) : _SafeStr_1620[_selectedGroup]);
                page.replaceOffers(_local_2, false);
                resetTimer();
                populateItemGrid();
                loadItemGridGraphics();
                if (_SafeStr_1163)
                {
                    _SafeStr_1163.start();
                };
                _local_3 = _SafeStr_1621[_selectedGroup];
                selectIndex(_local_3);
            };
        }


    }
}


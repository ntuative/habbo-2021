package com.sulake.habbo.ui.widget.crafting.controller
{
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.ui.widget.crafting.renderer.CraftingRecipeItemRenderer;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.communication.messages.parser.crafting.OutgoingIngredient;
    import com.sulake.core.window.components.IItemGridWindow;

    public class CraftingRecipeListController extends CraftingGridControllerBase 
    {

        private var _SafeStr_4006:CraftingFurnitureItem;
        private var _items:Vector.<CraftingRecipeItemRenderer>;

        public function CraftingRecipeListController(_arg_1:CraftingWidget)
        {
            super(_arg_1);
            _items = new Vector.<CraftingRecipeItemRenderer>(0);
        }

        override public function dispose():void
        {
            clearItems();
            _SafeStr_4006 = null;
            super.dispose();
        }

        public function clearItems():void
        {
            if (_items)
            {
                for each (var _local_1:CraftingRecipeItemRenderer in _items)
                {
                    _local_1.dispose();
                };
                _items.length = 0;
            };
            if (container)
            {
                container.destroyGridItems();
            };
        }

        public function populateRecipeItems(_arg_1:Vector.<CraftingFurnitureItem>):void
        {
            var _local_4:int;
            var _local_3:CraftingRecipeItemRenderer;
            if (!container)
            {
                return;
            };
            var _local_2:IWindowContainer = getItemTemplate();
            container.removeGridItems();
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_3 = new CraftingRecipeItemRenderer(_arg_1[_local_4], (_local_2.clone() as IWindowContainer), _SafeStr_1324);
                container.addGridItem(_local_3.window);
                _items.push(_local_3);
                _local_4++;
            };
        }

        public function showRecipe(_arg_1:CraftingFurnitureItem, _arg_2:Vector.<OutgoingIngredient>):void
        {
            var _local_3:int;
            var _local_8:IFurnitureData;
            var _local_4:Array;
            var _local_7:int;
            var _local_10:CraftingFurnitureItem;
            _SafeStr_4006 = _arg_1;
            if (!_arg_2)
            {
                _SafeStr_1324.setInfoState(7);
                return;
            };
            _SafeStr_1324.mixerCtrl.clearItems();
            var _local_9:Boolean = true;
            var _local_6:Vector.<String> = new Vector.<String>(0);
            for each (var _local_5:OutgoingIngredient in _arg_2)
            {
                _local_8 = _SafeStr_1324.sessionDataManager.getFloorItemDataByName(_local_5.furnitureClassName);
                if (!_local_8)
                {
                    return;
                };
                _local_4 = _SafeStr_1324.handler.container.inventory.getNonRentedInventoryIds("furni", _local_8.id);
                if (((_local_4 == null) || (_local_4.length < _local_5.count)))
                {
                    _local_9 = false;
                };
                _local_7 = 0;
                while (_local_7 < _local_5.count)
                {
                    _local_10 = new CraftingFurnitureItem(null, _local_8);
                    if (((_local_4) && (_local_4.length)))
                    {
                        _local_3 = _local_4.shift();
                    }
                    else
                    {
                        _local_3 = 0;
                        if (_local_6.indexOf(_local_8.localizedName) == -1)
                        {
                            _local_6.push(_local_8.localizedName);
                        };
                    };
                    _SafeStr_1324.mixerCtrl.addItemToMixer(_local_10, _local_3);
                    _local_7++;
                };
            };
            if (_local_9)
            {
                _SafeStr_1324.setInfoState(8, _SafeStr_4006.furnitureData);
            }
            else
            {
                _SafeStr_1324.setInfoState(7, _SafeStr_4006.furnitureData, _local_6);
            };
        }

        private function get container():IItemGridWindow
        {
            return ((mainWindow) ? (mainWindow.findChildByName("itemgrid_products") as IItemGridWindow) : null);
        }


    }
}


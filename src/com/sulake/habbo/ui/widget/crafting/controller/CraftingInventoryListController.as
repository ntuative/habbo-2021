package com.sulake.habbo.ui.widget.crafting.controller
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.ui.widget.crafting.renderer.CraftingInventoryItemRenderer;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.core.window.components.IItemGridWindow;

    public class CraftingInventoryListController extends CraftingGridControllerBase 
    {

        private var _items:Vector.<CraftingInventoryItemRenderer>;

        public function CraftingInventoryListController(_arg_1:CraftingWidget)
        {
            super(_arg_1);
            _items = new Vector.<CraftingInventoryItemRenderer>(0);
        }

        override public function dispose():void
        {
            clearItems();
            super.dispose();
        }

        public function clearItems():void
        {
            if (_items)
            {
                for each (var _local_1:CraftingInventoryItemRenderer in _items)
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

        public function populateInventoryItems(_arg_1:Vector.<CraftingFurnitureItem>):void
        {
            var _local_4:int;
            var _local_3:CraftingInventoryItemRenderer;
            if (!container)
            {
                return;
            };
            var _local_2:IWindowContainer = getItemTemplate();
            container.removeGridItems();
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_3 = new CraftingInventoryItemRenderer(_arg_1[_local_4], (_local_2.clone() as IWindowContainer), _SafeStr_1324);
                container.addGridItem(_local_3.window);
                _items.push(_local_3);
                _local_4++;
            };
        }

        public function updateItemCounts():void
        {
            for each (var _local_1:CraftingInventoryItemRenderer in _items)
            {
                _local_1.updateItemCount();
            };
        }

        private function get container():IItemGridWindow
        {
            return ((mainWindow) ? (mainWindow.findChildByName("itemgrid_inventory") as IItemGridWindow) : null);
        }


    }
}


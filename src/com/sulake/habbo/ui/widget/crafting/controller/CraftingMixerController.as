package com.sulake.habbo.ui.widget.crafting.controller
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.ui.widget.crafting.renderer.CraftingMixerItemRenderer;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.ui.widget.crafting.*;

    public class CraftingMixerController extends CraftingGridControllerBase 
    {

        private static const MAX_ITEMS:int = 10;

        private var _renderers:Vector.<CraftingMixerItemRenderer>;

        public function CraftingMixerController(_arg_1:CraftingWidget)
        {
            super(_arg_1);
            _renderers = new Vector.<CraftingMixerItemRenderer>(0);
        }

        override public function dispose():void
        {
            returnItemsToInventory();
            super.dispose();
        }

        public function returnItemsToInventory():void
        {
            var _local_2:int;
            var _local_1:CraftingMixerItemRenderer;
            _local_2 = 0;
            while (_local_2 < _renderers.length)
            {
                _local_1 = _renderers[_local_2];
                if (_local_1)
                {
                    _local_1.returnItemToInventory();
                };
                _local_2++;
            };
            _renderers.length = 0;
            if (container)
            {
                container.destroyGridItems();
            };
            if (((_SafeStr_1324) && (_SafeStr_1324.inventoryCtrl)))
            {
                _SafeStr_1324.inventoryCtrl.updateItemCounts();
            };
        }

        public function clearItems():void
        {
            returnItemsToInventory();
            if (container)
            {
                container.destroyGridItems();
            };
        }

        public function canAdd():Boolean
        {
            return (_renderers.length < 10);
        }

        public function addItemToMixer(_arg_1:CraftingFurnitureItem, _arg_2:int):Boolean
        {
            if (!container)
            {
                return (false);
            };
            var _local_3:IWindowContainer = getItemTemplate();
            var _local_4:CraftingMixerItemRenderer = new CraftingMixerItemRenderer(_arg_1, (_local_3.clone() as IWindowContainer), _SafeStr_1324);
            _local_4.inventoryId = _arg_2;
            container.addGridItem(_local_4.window);
            _renderers.push(_local_4);
            if (_SafeStr_1324.inSecretRecipeMode)
            {
                _SafeStr_1324.mixerContentChanged(collectSelectedFurnitureIds());
            };
            return (true);
        }

        public function removeListItem(_arg_1:CraftingMixerItemRenderer):void
        {
            var _local_3:int;
            var _local_2:CraftingMixerItemRenderer;
            if (!container)
            {
                return;
            };
            _local_3 = 0;
            while (_local_3 < _renderers.length)
            {
                _local_2 = _renderers[_local_3];
                if (_local_2 == _arg_1)
                {
                    _renderers.splice(_local_3, 1);
                    if (_local_2.window)
                    {
                        container.removeGridItem(_local_2.window);
                        container.rebuildGridStructure();
                    };
                    _local_2.returnItemToInventory();
                    _SafeStr_1324.inventoryCtrl.updateItemCounts();
                    _SafeStr_1324.mixerContentChanged(collectSelectedFurnitureIds());
                    return;
                };
                _local_3++;
            };
        }

        public function collectSelectedFurnitureIds():Vector.<int>
        {
            var _local_2:int;
            var _local_1:CraftingMixerItemRenderer;
            var _local_3:Vector.<int> = new Vector.<int>(0);
            _local_2 = 0;
            while (_local_2 < _renderers.length)
            {
                _local_1 = _renderers[_local_2];
                if (_local_1)
                {
                    _local_3.push(_local_1.inventoryId);
                };
                _local_2++;
            };
            return (_local_3);
        }

        private function get container():IItemGridWindow
        {
            return ((mainWindow) ? (mainWindow.findChildByName("itemgrid_mixer") as IItemGridWindow) : null);
        }


    }
}


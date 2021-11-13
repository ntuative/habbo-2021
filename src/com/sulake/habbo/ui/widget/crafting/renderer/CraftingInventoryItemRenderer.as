package com.sulake.habbo.ui.widget.crafting.renderer
{
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;

    public class CraftingInventoryItemRenderer extends FurniThumbnailRendererBase 
    {

        public function CraftingInventoryItemRenderer(_arg_1:CraftingFurnitureItem, _arg_2:IWindowContainer, _arg_3:CraftingWidget)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function onTriggered():void
        {
            if ((((!(_SafeStr_1324)) || (_SafeStr_1324.craftingInProgress)) || (_SafeStr_1324.inventoryDirty)))
            {
                return;
            };
            if (!_SafeStr_1324.mixerCtrl.canAdd())
            {
                return;
            };
            var _local_1:int = content.getItemToMixer();
            if (_local_1 == 0)
            {
                return;
            };
            _SafeStr_1324.showSecretRecipeView();
            _SafeStr_1324.mixerCtrl.addItemToMixer(content, _local_1);
            _SafeStr_1324.inventoryCtrl.updateItemCounts();
        }

        override public function updateItemCount():void
        {
            if (content)
            {
                updateGroupItemCount(content.countInInventory);
                updateBitmapBlend((content.countInInventory > 0));
            };
        }


    }
}


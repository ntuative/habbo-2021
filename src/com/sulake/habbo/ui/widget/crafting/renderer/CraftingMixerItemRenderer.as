package com.sulake.habbo.ui.widget.crafting.renderer
{
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;

    public class CraftingMixerItemRenderer extends FurniThumbnailRendererBase 
    {

        private var _inventoryId:int;

        public function CraftingMixerItemRenderer(_arg_1:CraftingFurnitureItem, _arg_2:IWindowContainer, _arg_3:CraftingWidget)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function onTriggered():void
        {
            if ((((!(_SafeStr_1324)) || (_SafeStr_1324.craftingInProgress)) || (_SafeStr_1324.inventoryDirty)))
            {
                return;
            };
            if (_inventoryId == 0)
            {
                _SafeStr_1324.setInfoState(9, furnitureData);
                return;
            };
            if (_SafeStr_1324.inSecretRecipeMode)
            {
                _SafeStr_1324.mixerCtrl.removeListItem(this);
            };
        }

        public function returnItemToInventory():void
        {
            if (_inventoryId != 0)
            {
                _SafeStr_690.returnItemToInventory(_inventoryId);
            };
            this.dispose();
        }

        override public function updateItemCount():void
        {
            updateBitmapBlend((!(_inventoryId == 0)));
        }

        public function get inventoryId():int
        {
            return (_inventoryId);
        }

        public function set inventoryId(_arg_1:int):void
        {
            _inventoryId = _arg_1;
            updateItemCount();
        }


    }
}


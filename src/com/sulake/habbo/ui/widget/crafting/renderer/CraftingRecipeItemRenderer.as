package com.sulake.habbo.ui.widget.crafting.renderer
{
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;

    public class CraftingRecipeItemRenderer extends FurniThumbnailRendererBase 
    {

        public function CraftingRecipeItemRenderer(_arg_1:CraftingFurnitureItem, _arg_2:IWindowContainer, _arg_3:CraftingWidget)
        {
            super(_arg_1, _arg_2, _arg_3);
            hideItemCount();
        }

        override protected function onTriggered():void
        {
            if ((((!(_SafeStr_1324)) || (!(content))) || (_SafeStr_1324.craftingInProgress)))
            {
                return;
            };
            _SafeStr_1324.showCraftableProduct(content);
        }


    }
}


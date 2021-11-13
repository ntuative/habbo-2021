package com.sulake.habbo.ui.widget.crafting.controller
{
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import com.sulake.core.window.IWindowContainer;

    public class CraftingGridControllerBase 
    {

        protected var _SafeStr_1324:CraftingWidget;

        public function CraftingGridControllerBase(_arg_1:CraftingWidget)
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
        }

        public function get mainWindow():IWindowContainer
        {
            return (_SafeStr_1324.window);
        }

        public function getItemTemplate():IWindowContainer
        {
            return (_SafeStr_1324.itemTemplate);
        }


    }
}


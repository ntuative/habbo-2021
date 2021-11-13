package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;

    public class CategoryBaseView 
    {

        protected var _window:IWindowContainer;
        protected var _SafeStr_1285:String = "";
        protected var _currentTabName:String = "";
        protected var _SafeStr_1275:IAvatarEditorCategoryModel;
        protected var _SafeStr_573:Boolean;

        public function CategoryBaseView(_arg_1:IAvatarEditorCategoryModel)
        {
            _SafeStr_1275 = _arg_1;
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1275 = null;
            _SafeStr_573 = false;
        }

        public function init():void
        {
        }

        public function reset():void
        {
            _SafeStr_1285 = "";
            _currentTabName = "";
            _SafeStr_573 = false;
        }

        public function getWindowContainer():IWindowContainer
        {
            if (!_SafeStr_573)
            {
                init();
            };
            return (_window);
        }

        public function showPalettes(_arg_1:String, _arg_2:int):void
        {
            _SafeStr_1275.controller.view.gridView.showPalettes(_arg_2);
        }

        protected function updateGridView(_arg_1:String):void
        {
            _SafeStr_1275.controller.view.gridView.initFromList(_SafeStr_1275, _arg_1);
        }

        protected function activateTab(_arg_1:String):void
        {
            var _local_2:IStaticBitmapWrapperWindow;
            if (!_window)
            {
                return;
            };
            var _local_3:IWindowContainer = (_window.findChildByName(_arg_1) as IWindowContainer);
            if (_local_3)
            {
                _local_2 = (_local_3.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow);
                TabUtils.setElementImage(_local_2, true);
            };
        }

        protected function inactivateTab(_arg_1:String):void
        {
            var _local_2:IStaticBitmapWrapperWindow;
            if (!_window)
            {
                return;
            };
            var _local_3:IWindowContainer = (_window.findChildByName(_arg_1) as IWindowContainer);
            if (_local_3)
            {
                _local_2 = (_local_3.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow);
                TabUtils.setElementImage(_local_2, false);
            };
        }


    }
}


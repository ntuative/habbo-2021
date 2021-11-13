package com.sulake.habbo.avatar.hotlooks
{
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.wardrobe.Outfit;
    import com.sulake.core.window.events.WindowEvent;

    public class HotLooksView implements IAvatarEditorCategoryView 
    {

        private var _window:IWindowContainer;
        private var _SafeStr_1275:HotLooksModel;
        private var _SafeStr_1336:IItemGridWindow;

        public function HotLooksView(_arg_1:HotLooksModel)
        {
            _SafeStr_1275 = _arg_1;
        }

        public function init():void
        {
            if (_SafeStr_1336)
            {
                _SafeStr_1336.removeGridItems();
            };
            if (!_window)
            {
                _window = (_SafeStr_1275.controller.view.getCategoryContainer("hotlooks") as IWindowContainer);
                _SafeStr_1336 = (_window.findChildByName("hotlooks") as IItemGridWindow);
                _window.visible = false;
            };
            update();
        }

        public function dispose():void
        {
            _SafeStr_1336.removeGridItems();
            _window = null;
            _SafeStr_1275 = null;
        }

        public function update():void
        {
            var _local_2:IWindow;
            _SafeStr_1336.removeGridItems();
            for each (var _local_1:Outfit in _SafeStr_1275.hotLooks)
            {
                _local_2 = _local_1.view.window;
                _SafeStr_1336.addGridItem(_local_2);
                _local_2.procedure = hotLooksEventProc;
            };
        }

        public function getWindowContainer():IWindowContainer
        {
            return (_window);
        }

        private function hotLooksEventProc(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:int;
            if (_arg_2 == null)
            {
                _arg_2 = (_arg_1.target as IWindow);
            };
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _SafeStr_1336.getGridItemIndex(_arg_2.parent);
                _SafeStr_1275.selectHotLook(_local_3);
            };
        }

        public function switchCategory(_arg_1:String):void
        {
        }

        public function showPalettes(_arg_1:String, _arg_2:int):void
        {
        }

        public function reset():void
        {
        }


    }
}


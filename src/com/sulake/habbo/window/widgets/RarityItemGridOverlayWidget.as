package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.utils.LimitedItemOverlayNumberBitmapGenerator;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class RarityItemGridOverlayWidget implements IRarityItemGridOverlayWidget 
    {

        public static const TYPE:String = "rarity_item_overlay_grid";

        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _disposed:Boolean;
        private var _SafeStr_1165:IWindowContainer;
        private var _rarityLevel:int;
        private var _SafeStr_4440:IStaticBitmapWrapperWindow;

        public function RarityItemGridOverlayWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_griditem_xml").content)));
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set rarityLevel(_arg_1:int):void
        {
            _rarityLevel = _arg_1;
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_SafeStr_1165.findChildByName("rarity_item_overlay_plaque_number_bitmap"));
            _local_2.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets, rarityLevel, _local_2.width, _local_2.height);
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function get properties():Array
        {
            return ([]);
        }

        public function set properties(_arg_1:Array):void
        {
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }


    }
}


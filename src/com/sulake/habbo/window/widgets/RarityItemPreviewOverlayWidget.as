package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class RarityItemPreviewOverlayWidget implements IRarityItemPreviewOverlayWidget
    {

        public static const TYPE:String = "rarity_item_overlay_preview";
        private static const _SafeStr_4441:String = "rarity_item_overlay_preview:level";
        private static const RARITY_LEVEL_DEFAULT:PropertyStruct = new PropertyStruct("rarity_item_overlay_preview:level", 0, "int");

        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _rarityLevel:int;
        private var _disposed:Boolean;
        private var _SafeStr_4442:ITextWindow;

        public function RarityItemPreviewOverlayWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_preview_xml").content)));
            _SafeStr_4442 = (_SafeStr_1165.findChildByName("level") as ITextWindow);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function set rarityLevel(_arg_1:int):void
        {
            _rarityLevel = _arg_1;
            _SafeStr_4442.caption = _arg_1.toString();
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(RARITY_LEVEL_DEFAULT.withValue(rarityLevel));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "rarity_item_overlay_preview:level":
                        rarityLevel = int(_local_2.value);
                };
            };
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }


    }
}
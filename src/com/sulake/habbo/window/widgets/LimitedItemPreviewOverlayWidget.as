package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.utils.LimitedItemOverlayNumberBitmapGenerator;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class LimitedItemPreviewOverlayWidget implements ILimitedItemPreviewOverlayWidget 
    {

        public static const TYPE:String = "limited_item_overlay_preview";

        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _serialNumber:int;
        private var _seriesSize:int;

        public function LimitedItemPreviewOverlayWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_preview_xml").content)));
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function set serialNumber(_arg_1:int):void
        {
            _serialNumber = _arg_1;
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_SafeStr_1165.findChildByName("unique_item_serial_number_bitmap"));
            _local_2.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets, serialNumber, _local_2.width, _local_2.height);
        }

        public function set seriesSize(_arg_1:int):void
        {
            _seriesSize = _arg_1;
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_SafeStr_1165.findChildByName("unique_item_edition_size_bitmap"));
            _local_2.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets, _arg_1, _local_2.width, _local_2.height);
        }

        public function get serialNumber():int
        {
            return (_serialNumber);
        }

        public function get seriesSize():int
        {
            return (_seriesSize);
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
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1165 == null);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }


    }
}


package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class LimitedItemSupplyLeftOverlayWidget implements ILimitedItemSupplyLeftOverlayWidget 
    {

        public static const TYPE:String = "limited_item_overlay_supply";

        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _supplyLeft:int;
        private var _seriesSize:int;

        public function LimitedItemSupplyLeftOverlayWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_supply_xml").content)));
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function set supplyLeft(_arg_1:int):void
        {
            _supplyLeft = _arg_1;
            var _local_3:ITextWindow = (_SafeStr_1165.findChildByName("items_left_count") as ITextWindow);
            _local_3.text = _arg_1.toString();
            var _local_2:Boolean;
            _SafeStr_1165.findChildByName("unique_item_sold_out_bitmap").visible = _local_2;
        }

        public function get supplyLeft():int
        {
            return (_supplyLeft);
        }

        public function set serialNumber(_arg_1:int):void
        {
        }

        public function set seriesSize(_arg_1:int):void
        {
            _seriesSize = _arg_1;
            var _local_2:ITextWindow = (_SafeStr_1165.findChildByName("items_total_count") as ITextWindow);
            _local_2.text = _arg_1.toString();
        }

        public function get serialNumber():int
        {
            return (0);
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


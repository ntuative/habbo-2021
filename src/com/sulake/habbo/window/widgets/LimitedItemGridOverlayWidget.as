package com.sulake.habbo.window.widgets
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.getTimer;
    import com.sulake.habbo.window.utils.LimitedItemOverlayNumberBitmapGenerator;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class LimitedItemGridOverlayWidget implements ILimitedItemGridOverlayWidget, IUpdateReceiver 
    {

        public static const TYPE:String = "limited_item_overlay_grid";

        private const SHINE_INTERVAL_MS:uint = 10000;
        private const SHINE_LENGTH_MS:uint = 250;

        private var _disposed:Boolean = false;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _SafeStr_4437:BitmapData;
        private var _SafeStr_4436:IBitmapWrapperWindow;
        private var _serialNumber:int;
        private var _SafeStr_4435:uint = getTimer();
        private var _SafeStr_4438:uint = _SafeStr_4435;
        private var _animated:Boolean = false;

        public function LimitedItemGridOverlayWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_4437 = BitmapData(_windowManager.assets.getAssetByName("unique_item_label_plaque_metal").content).clone();
            _SafeStr_1165 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_griditem_xml").content)));
            _SafeStr_4436 = IBitmapWrapperWindow(_SafeStr_1165.findChildByName("unique_item_overlay_plaque_background_bitmap"));
            _SafeStr_4436.bitmap = _SafeStr_4437;
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_animated)
                {
                    _windowManager.removeUpdateReceiver(this);
                };
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

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set serialNumber(_arg_1:int):void
        {
            _serialNumber = _arg_1;
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_SafeStr_1165.findChildByName("unique_item_overlay_plaque_number_bitmap"));
            _local_2.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets, serialNumber, _local_2.width, _local_2.height);
        }

        public function set seriesSize(_arg_1:int):void
        {
        }

        public function get serialNumber():int
        {
            return (_serialNumber);
        }

        public function get seriesSize():int
        {
            return (0);
        }

        public function get properties():Array
        {
            return ([]);
        }

        public function set properties(_arg_1:Array):void
        {
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        public function get animated():Boolean
        {
            return (_animated);
        }

        public function set animated(_arg_1:Boolean):void
        {
            _animated = _arg_1;
            if (_animated)
            {
                _windowManager.registerUpdateReceiver(this, 5);
            }
            else
            {
                _windowManager.removeUpdateReceiver(this);
            };
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:BitmapData;
            var _local_3:Number;
            var _local_4:int;
            if (!disposed)
            {
                _SafeStr_4435 = (_SafeStr_4435 + _arg_1);
                if ((_SafeStr_4435 - _SafeStr_4438) > 10000)
                {
                    _local_2 = new BitmapData(_SafeStr_4436.width, _SafeStr_4436.height, false);
                    _local_3 = (((_SafeStr_4435 - _SafeStr_4438) - 10000) / 250);
                    if (_local_3 < 1)
                    {
                        _local_4 = ((_SafeStr_4437.height - _SafeStr_4436.height) * _local_3);
                        _local_2.copyPixels(_SafeStr_4437, new Rectangle(0, _local_4, _SafeStr_4436.width, _SafeStr_4436.height), new Point(0, 0));
                        _SafeStr_4436.bitmap = _local_2;
                    }
                    else
                    {
                        _SafeStr_4436.bitmap = _SafeStr_4437;
                        _SafeStr_4438 = _SafeStr_4435;
                    };
                };
            };
        }


    }
}


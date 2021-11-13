package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.IIterator;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindow;

    public class SeparatorWidget implements ISeparatorWidget 
    {

        public static const TYPE:String = "separator";
        private static const VERTICAL_KEY:String = "separator:vertical";
        private static const VERTICAL_DEFAULT:PropertyStruct = new PropertyStruct("separator:vertical", false, "Boolean");
        private static const BORDER_IMAGE_HORIZONTAL:String = "illumina_light_separator_horizontal";
        private static const BORDER_IMAGE_VERTICAL:String = "illumina_light_separator_vertical";

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _SafeStr_1267:IBitmapWrapperWindow;
        private var _SafeStr_4429:BitmapData;
        private var _children:IWindowContainer;
        private var _vertical:Boolean = VERTICAL_DEFAULT.value;

        public function SeparatorWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("separator_xml").content as XML)) as IWindowContainer);
            _SafeStr_1267 = (_SafeStr_1165.getChildByName("canvas") as IBitmapWrapperWindow);
            _children = (_SafeStr_1165.getChildByName("children") as IWindowContainer);
            _SafeStr_1267.addEventListener("WE_RESIZE", onChange);
            _SafeStr_1267.addEventListener("WE_RESIZED", onChange);
            _children.addEventListener("WE_CHILD_ADDED", onChange);
            _children.addEventListener("WE_CHILD_REMOVED", onChange);
            _children.addEventListener("WE_CHILD_RELOCATED", onChange);
            _children.addEventListener("WE_CHILD_RESIZED", onChange);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        private function onChange(_arg_1:WindowEvent):void
        {
            refresh();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_4429 != null)
                {
                    _SafeStr_4429.dispose();
                    _SafeStr_4429 = null;
                };
                if (_SafeStr_1267 != null)
                {
                    _SafeStr_1267.removeEventListener("WE_RESIZE", onChange);
                    _SafeStr_1267.removeEventListener("WE_RESIZED", onChange);
                    _SafeStr_1267 = null;
                };
                if (_children != null)
                {
                    _children.removeEventListener("WE_CHILD_ADDED", onChange);
                    _children.removeEventListener("WE_CHILD_REMOVED", onChange);
                    _children.removeEventListener("WE_CHILD_RELOCATED", onChange);
                    _children.removeEventListener("WE_CHILD_RESIZED", onChange);
                    _children = null;
                };
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (_children.iterator);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(VERTICAL_DEFAULT.withValue(_vertical));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            if (_disposed)
            {
                return;
            };
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "separator:vertical":
                        vertical = _local_2.value;
                };
            };
        }

        public function get vertical():Boolean
        {
            return (_vertical);
        }

        public function set vertical(_arg_1:Boolean):void
        {
            _vertical = _arg_1;
            refresh();
        }

        private function refresh():void
        {
            var _local_1:BitmapData;
            var _local_4:Point;
            if (_disposed)
            {
                return;
            };
            if ((((_SafeStr_4429 == null) || (!(_SafeStr_4429.width == _SafeStr_1267.width))) || (!(_SafeStr_4429.height == _SafeStr_1267.height))))
            {
                if (_SafeStr_4429 != null)
                {
                    _SafeStr_4429.dispose();
                };
                _SafeStr_4429 = new BitmapData(Math.max(1, _SafeStr_1267.width), Math.max(1, _SafeStr_1267.height), true, 0);
                _SafeStr_1267.bitmap = _SafeStr_4429;
            };
            _SafeStr_4429.lock();
            _SafeStr_4429.fillRect(new Rectangle(0, 0, _SafeStr_1267.width, _SafeStr_1267.height), 0);
            var _local_3:BitmapDataAsset = (_windowManager.assets.getAssetByName(((_vertical) ? "illumina_light_separator_vertical" : "illumina_light_separator_horizontal")) as BitmapDataAsset);
            if (_local_3 != null)
            {
                _local_1 = (_local_3.content as BitmapData);
                if (_vertical)
                {
                    _local_4 = new Point(((_SafeStr_1267.width / 2) - 1), 0);
                    while (_local_4.y < _SafeStr_1267.height)
                    {
                        _SafeStr_4429.copyPixels(_local_1, _local_3.rectangle, _local_4);
                        _local_4.y = (_local_4.y + _local_3.rectangle.height);
                    };
                }
                else
                {
                    _local_4 = new Point(0, ((_SafeStr_1267.height / 2) - 1));
                    while (_local_4.x < _SafeStr_1267.width)
                    {
                        _SafeStr_4429.copyPixels(_local_1, _local_3.rectangle, _local_4);
                        _local_4.x = (_local_4.x + _local_3.rectangle.width);
                    };
                };
            };
            for each (var _local_2:IWindow in _children.iterator)
            {
                if (_local_2.visible)
                {
                    _SafeStr_4429.fillRect(_local_2.rectangle, 0);
                };
            };
            _SafeStr_4429.unlock();
            _SafeStr_1267.invalidate();
        }


    }
}


package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.habbo.window.enum._SafeStr_222;
    import com.sulake.habbo.window.enum._SafeStr_198;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.utils.IBitmapDataContainer;

    public class ProgressIndicatorWidget implements IProgressIndicatorWidget
    {

        public static const TYPE:String = "progress_indicator";
        private static const STYLE_KEY:String = "progress_indicator:style";
        private static const SIZE_KEY:String = "progress_indicator:size";
        private static const _SafeStr_4439:String = "progress_indicator:position";
        private static const MODE_KEY:String = "progress_indicator:mode";
        private static const STYLE_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:style", "flat", "String", false, _SafeStr_222.ALL);
        private static const SIZE_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:size", 1, "uint");
        private static const POSITION_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:position", 0, "uint");
        private static const MODE_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:mode", "position", "String", false, _SafeStr_198.ALL);
        private static const MAXIMUM_SIZE:uint = 1000;

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IItemListWindow;
        private var _position:uint = uint(POSITION_DEFAULT.value);
        private var _style:String = String(STYLE_DEFAULT.value);
        private var _mode:String = String(MODE_DEFAULT.value);

        public function ProgressIndicatorWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("progress_indicator_xml").content as XML)) as IItemListWindow);
            _SafeStr_4407.setParamFlag(147456);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
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
            return (EmptyIterator.INSTANCE);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(STYLE_DEFAULT.withValue(_style));
            _local_1.push(SIZE_DEFAULT.withValue(size));
            _local_1.push(POSITION_DEFAULT.withValue(_position));
            _local_1.push(MODE_DEFAULT.withValue(_mode));
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
                    case "progress_indicator:style":
                        style = String(_local_2.value);
                        break;
                    case "progress_indicator:size":
                        size = uint(_local_2.value);
                        break;
                    case "progress_indicator:position":
                        position = uint(_local_2.value);
                        break;
                    case "progress_indicator:mode":
                        mode = String(_local_2.value);
                };
            };
        }

        public function get style():String
        {
            return (_style);
        }

        public function set style(_arg_1:String):void
        {
            _style = _arg_1;
            refresh();
        }

        public function get size():uint
        {
            return (_SafeStr_1165.numListItems);
        }

        public function set size(_arg_1:uint):void
        {
            _arg_1 = Math.min(Math.max(_arg_1, 1), 1000);
            if (_arg_1 != size)
            {
                while (_arg_1 < size)
                {
                    _SafeStr_1165.removeListItemAt((size - 1));
                };
                while (_arg_1 > size)
                {
                    _SafeStr_1165.addListItem(_SafeStr_1165.getListItemAt(0).clone());
                };
                refresh();
            };
        }

        public function get position():uint
        {
            return (_position);
        }

        public function set position(_arg_1:uint):void
        {
            _position = _arg_1;
            refresh();
        }

        public function get mode():String
        {
            return (_mode);
        }

        public function set mode(_arg_1:String):void
        {
            _mode = _arg_1;
            refresh();
        }

        private function refresh():void
        {
            var _local_3:int;
            var _local_4:IStaticBitmapWrapperWindow;
            var _local_2:Boolean;
            var _local_1:BitmapData;
            _local_3 = 0;
            while (_local_3 < size)
            {
                _local_4 = (_SafeStr_1165.getListItemAt(_local_3) as IStaticBitmapWrapperWindow);
                switch (_mode)
                {
                    case "position":
                        _local_2 = ((_local_3 + 1) == position);
                        break;
                    case "progress":
                        _local_2 = (_local_3 < position);
                };
                _local_4.assetUri = (("progress_disk_" + _style) + ((_local_2) ? "_on" : "_off"));
                _local_1 = IBitmapDataContainer(_local_4).bitmapData;
                _local_4.width = _local_1.width;
                _local_4.height = _local_1.height;
                _SafeStr_1165.height = _local_1.height;
                _local_3++;
            };
        }


    }
}
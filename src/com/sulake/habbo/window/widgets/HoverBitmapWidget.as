package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class HoverBitmapWidget implements IHoverBitmapWidget
    {

        public static const TYPE:String = "hover_bitmap";
        private static const _SafeStr_4425:String = "hover_bitmap:hover_asset";
        private static const _SafeStr_4426:String = "hover_bitmap:normal_asset";
        private static const HOVER_ASSET_DEFAULT:PropertyStruct = new PropertyStruct("hover_bitmap:hover_asset", null, "String");
        private static const NORMAL_ASSET_DEFAULT:PropertyStruct = new PropertyStruct("hover_bitmap:normal_asset", null, "String");

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _bitmapWrapper:IStaticBitmapWrapperWindow;
        private var _normalAsset:String;
        private var _hoverAsset:String;
        private var _SafeStr_4427:Boolean = false;

        public function HoverBitmapWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _bitmapWrapper = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("hover_bitmap_xml").content as XML)) as IStaticBitmapWrapperWindow);
            _bitmapWrapper.addEventListener("WME_OVER", onMouseOver);
            _bitmapWrapper.addEventListener("WME_OUT", onMouseOut);
            _SafeStr_4407.rootWindow = _bitmapWrapper;
            _bitmapWrapper.width = _SafeStr_4407.width;
            _bitmapWrapper.height = _SafeStr_4407.height;
            _bitmapWrapper.invalidate();
        }

        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_4427 = true;
            _bitmapWrapper.assetUri = _hoverAsset;
        }

        private function onMouseOut(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_4427 = false;
            _bitmapWrapper.assetUri = _normalAsset;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_bitmapWrapper != null)
                {
                    _bitmapWrapper.dispose();
                    _bitmapWrapper = null;
                };
                _SafeStr_4407.rootWindow = null;
                _SafeStr_4407 = null;
                _windowManager = null;
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
            var _local_2:Array = [];
            if (_disposed)
            {
                return (_local_2);
            };
            _local_2.push(NORMAL_ASSET_DEFAULT.withValue(_normalAsset));
            _local_2.push(HOVER_ASSET_DEFAULT.withValue(_hoverAsset));
            if (_bitmapWrapper != null)
            {
                for each (var _local_1:PropertyStruct in _bitmapWrapper.properties)
                {
                    if (_local_1.key != "asset_uri")
                    {
                        _local_2.push(_local_1);
                    };
                };
            };
            return (_local_2);
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
                    case "hover_bitmap:normal_asset":
                        normalAsset = String(_local_2.value);
                        break;
                    case "hover_bitmap:hover_asset":
                        hoverAsset = String(_local_2.value);
                };
            };
            if (_bitmapWrapper != null)
            {
                _bitmapWrapper.properties = _arg_1;
                _bitmapWrapper.invalidate();
            };
        }

        public function get normalAsset():String
        {
            return (_normalAsset);
        }

        public function set normalAsset(_arg_1:String):void
        {
            _normalAsset = _arg_1;
            if (!_SafeStr_4427)
            {
                _bitmapWrapper.assetUri = _normalAsset;
            };
        }

        public function get hoverAsset():String
        {
            return (_hoverAsset);
        }

        public function set hoverAsset(_arg_1:String):void
        {
            _hoverAsset = _arg_1;
            if (_SafeStr_4427)
            {
                _bitmapWrapper.assetUri = _hoverAsset;
            };
        }

        public function get bitmapWrapper():IStaticBitmapWrapperWindow
        {
            return (_bitmapWrapper);
        }


    }
}
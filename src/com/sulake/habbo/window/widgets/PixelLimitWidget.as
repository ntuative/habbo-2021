package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class PixelLimitWidget implements IPixelLimitWidget
    {

        public static const TYPE:String = "pixel_limit";
        private static const LIMIT_KEY:String = "pixel_limit:limit";
        private static const LIMIT_DEFAULT:PropertyStruct = new PropertyStruct("pixel_limit:limit", 0, "String", false, null);

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_958:Boolean;
        private var _SafeStr_1165:IWindowContainer;
        private var _bitmap:IStaticBitmapWrapperWindow;
        private var _region:IRegionWindow;
        private var _limit:int = int(LIMIT_DEFAULT.value);

        public function PixelLimitWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("badge_image_xml").content as XML)) as IWindowContainer);
            _bitmap = (_SafeStr_1165.findChildByName("bitmap") as IStaticBitmapWrapperWindow);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        public function get limit():int
        {
            return (_limit);
        }

        public function set limit(_arg_1:int):void
        {
            _limit = Math.max(0, Math.min(100, _arg_1));
            refresh();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_region != null)
                {
                    _region.removeEventListener("WME_CLICK", onClick);
                    _region.dispose();
                    _region = null;
                };
                _bitmap = null;
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
            var _local_2:Array = [];
            if (_disposed)
            {
                return (_local_2);
            };
            _local_2.push(LIMIT_DEFAULT.withValue(_limit));
            for each (var _local_1:PropertyStruct in _bitmap.properties)
            {
                if (_local_1.key != "asset_uri")
                {
                    _local_2.push(_local_1.withNameSpace("pixel_limit"));
                };
            };
            return (_local_2);
        }

        public function set properties(_arg_1:Array):void
        {
            _SafeStr_958 = true;
            var _local_3:Array = [];
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "pixel_limit:limit":
                        limit = int(_local_2.value);
                };
                if (_local_2.key != "pixel_limit:asset_uri")
                {
                    _local_3.push(_local_2.withoutNameSpace());
                };
            };
            _bitmap.properties = _local_3;
            _SafeStr_958 = false;
            refresh();
        }

        private function refresh():void
        {
            if (_SafeStr_958)
            {
                return;
            };
            _bitmap.assetUri = assetUri;
            _bitmap.invalidate();
        }

        private function get assetUri():String
        {
            var _local_2:String;
            var _local_1:int = int((Math.floor((_limit / 20)) * 20));
            _local_1 = Math.max(_local_1, 20);
            _local_2 = "${image.library.url}reception/challenge_meter_%amount%.png";
            return (_local_2.replace("%amount%", _local_1.toString()));
        }

        private function onClick(_arg_1:WindowMouseEvent):void
        {
        }

        public function get bitmapData():BitmapData
        {
            return (IBitmapDataContainer(_bitmap).bitmapData);
        }

        public function get pivotPoint():uint
        {
            return (_bitmap.pivotPoint);
        }

        public function set pivotPoint(_arg_1:uint):void
        {
            _bitmap.pivotPoint = _arg_1;
            _bitmap.invalidate();
        }

        public function get stretchedX():Boolean
        {
            return (_bitmap.stretchedX);
        }

        public function set stretchedX(_arg_1:Boolean):void
        {
            _bitmap.stretchedX = _arg_1;
            _bitmap.invalidate();
        }

        public function get stretchedY():Boolean
        {
            return (_bitmap.stretchedY);
        }

        public function set stretchedY(_arg_1:Boolean):void
        {
            _bitmap.stretchedY = _arg_1;
            _bitmap.invalidate();
        }

        public function get zoomX():Number
        {
            return (_bitmap.zoomX);
        }

        public function set zoomX(_arg_1:Number):void
        {
            _bitmap.zoomX = _arg_1;
            _bitmap.invalidate();
        }

        public function get zoomY():Number
        {
            return (_bitmap.zoomY);
        }

        public function set zoomY(_arg_1:Number):void
        {
            _bitmap.zoomY = _arg_1;
            _bitmap.invalidate();
        }

        public function get greyscale():Boolean
        {
            return (_bitmap.greyscale);
        }

        public function set greyscale(_arg_1:Boolean):void
        {
            _bitmap.greyscale = _arg_1;
            _bitmap.invalidate();
        }

        public function get etchingColor():uint
        {
            return (_bitmap.etchingColor);
        }

        public function set etchingColor(_arg_1:uint):void
        {
            _bitmap.etchingColor = _arg_1;
            _bitmap.invalidate();
        }

        public function get fitSizeToContents():Boolean
        {
            return (_bitmap.fitSizeToContents);
        }

        public function set fitSizeToContents(_arg_1:Boolean):void
        {
            _bitmap.fitSizeToContents = _arg_1;
            _bitmap.invalidate();
        }

        public function get etchingPoint():Point
        {
            return (new Point(0, 1));
        }

        public function get wrapX():Boolean
        {
            return (false);
        }

        public function set wrapX(_arg_1:Boolean):void
        {
        }

        public function get wrapY():Boolean
        {
            return (false);
        }

        public function set wrapY(_arg_1:Boolean):void
        {
        }


    }
}
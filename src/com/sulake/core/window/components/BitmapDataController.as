package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.theme.IPropertyMap;
    import com.sulake.core.window.enum.PivotPoint;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.PropertyStruct;

    public class BitmapDataController extends WindowController implements IBitmapDataContainer
    {

        protected var _bitmapData:BitmapData;
        protected var _SafeStr_884:uint;
        protected var _SafeStr_885:Boolean;
        protected var _SafeStr_886:Boolean;
        protected var _SafeStr_887:Number;
        protected var _SafeStr_888:Number;
        protected var _SafeStr_889:Boolean;
        protected var _etchingColor:uint;
        protected var _etchingPoint:Point = new Point(0, -1);
        protected var _SafeStr_890:Boolean;
        private var _wrapX:Boolean;
        private var _wrapY:Boolean;

        public function BitmapDataController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            var _local_12:IPropertyMap = _arg_5.getWindowFactory().getThemeManager().getPropertyDefaults(_arg_3);
            _SafeStr_884 = PivotPoint.pivotFromName(String(_local_12.get("pivot_point").value));
            _SafeStr_885 = _local_12.get("stretched_x").value;
            _SafeStr_886 = _local_12.get("stretched_y").value;
            _SafeStr_887 = Number(_local_12.get("zoom_x").value);
            _SafeStr_888 = Number(_local_12.get("zoom_y").value);
            _wrapX = _local_12.get("wrap_x").value;
            _wrapY = _local_12.get("wrap_y").value;
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function dispose():void
        {
            _bitmapData = null;
            super.dispose();
        }

        public function get bitmapData():BitmapData
        {
            return (_bitmapData);
        }

        public function get pivotPoint():uint
        {
            return (_SafeStr_884);
        }

        public function set pivotPoint(_arg_1:uint):void
        {
            _SafeStr_884 = _arg_1;
        }

        public function get stretchedX():Boolean
        {
            return (_SafeStr_885);
        }

        public function set stretchedX(_arg_1:Boolean):void
        {
            _SafeStr_885 = _arg_1;
        }

        public function get stretchedY():Boolean
        {
            return (_SafeStr_886);
        }

        public function set stretchedY(_arg_1:Boolean):void
        {
            _SafeStr_886 = _arg_1;
        }

        public function get zoomX():Number
        {
            return (_SafeStr_887);
        }

        public function set zoomX(_arg_1:Number):void
        {
            _SafeStr_887 = _arg_1;
            fitSize();
        }

        public function get zoomY():Number
        {
            return (_SafeStr_888);
        }

        public function set zoomY(_arg_1:Number):void
        {
            _SafeStr_888 = _arg_1;
            fitSize();
        }

        public function get greyscale():Boolean
        {
            return (_SafeStr_889);
        }

        public function set greyscale(_arg_1:Boolean):void
        {
            _SafeStr_889 = _arg_1;
        }

        public function get etchingColor():uint
        {
            return (_etchingColor);
        }

        public function set etchingColor(_arg_1:uint):void
        {
            _etchingColor = _arg_1;
        }

        public function get fitSizeToContents():Boolean
        {
            return (_SafeStr_890);
        }

        public function set fitSizeToContents(_arg_1:Boolean):void
        {
            _SafeStr_890 = _arg_1;
            fitSize();
        }

        override public function get etchingPoint():Point
        {
            return (_etchingPoint);
        }

        override public function set etching(_arg_1:Array):void
        {
            etchingColor = _arg_1[0];
            _etchingPoint = new Point(_arg_1[1], _arg_1[2]);
        }

        public function get wrapX():Boolean
        {
            return (_wrapX);
        }

        public function set wrapX(_arg_1:Boolean):void
        {
            _wrapX = _arg_1;
        }

        public function get wrapY():Boolean
        {
            return (_wrapY);
        }

        public function set wrapY(_arg_1:Boolean):void
        {
            _wrapY = _arg_1;
        }

        protected function fitSize():void
        {
            if (((_SafeStr_890) && (!(_bitmapData == null))))
            {
                width = Math.abs((_bitmapData.width * _SafeStr_887));
                height = Math.abs((_bitmapData.height * _SafeStr_888));
            };
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("pivot_point", PivotPoint.PIVOT_NAMES[_SafeStr_884]));
            _local_1.push(createProperty("stretched_x", _SafeStr_885));
            _local_1.push(createProperty("stretched_y", _SafeStr_886));
            _local_1.push(createProperty("wrap_x", _wrapX));
            _local_1.push(createProperty("wrap_y", _wrapY));
            _local_1.push(createProperty("zoom_x", _SafeStr_887));
            _local_1.push(createProperty("zoom_y", _SafeStr_888));
            _local_1.push(createProperty("greyscale", _SafeStr_889));
            _local_1.push(createProperty("etching_color", _etchingColor));
            _local_1.push(createProperty("fit_size_to_contents", _SafeStr_890));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "pivot_point":
                        _SafeStr_884 = PivotPoint.pivotFromName(String(_local_2.value));
                        break;
                    case "stretched_x":
                        _SafeStr_885 = _local_2.value;
                        break;
                    case "stretched_y":
                        _SafeStr_886 = _local_2.value;
                        break;
                    case "zoom_x":
                        _SafeStr_887 = Number(_local_2.value);
                        break;
                    case "zoom_y":
                        _SafeStr_888 = Number(_local_2.value);
                        break;
                    case "wrap_x":
                        _wrapX = _local_2.value;
                        break;
                    case "wrap_y":
                        _wrapY = _local_2.value;
                        break;
                    case "greyscale":
                        _SafeStr_889 = _local_2.value;
                        break;
                    case "etching_color":
                        _etchingColor = uint(_local_2.value);
                        break;
                    case "fit_size_to_contents":
                        fitSizeToContents = (_local_2.value as Boolean);
                };
            };
            super.properties = _arg_1;
        }


    }
}
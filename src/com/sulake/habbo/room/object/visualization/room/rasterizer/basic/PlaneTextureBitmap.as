package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;

    public class PlaneTextureBitmap 
    {

        public static const _SafeStr_3425:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _bitmap:BitmapData = null;
        private var _normalMinX:Number = -1;
        private var _normalMaxX:Number = 1;
        private var _normalMinY:Number = -1;
        private var _normalMaxY:Number = 1;
        private var _assetName:String = null;

        public function PlaneTextureBitmap(_arg_1:BitmapData, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1, _arg_6:String=null)
        {
            _normalMinX = _arg_2;
            _normalMaxX = _arg_3;
            _normalMinY = _arg_4;
            _normalMaxY = _arg_5;
            _assetName = _arg_6;
            _bitmap = _arg_1;
        }

        public function get bitmap():BitmapData
        {
            return (_bitmap);
        }

        public function get normalMinX():Number
        {
            return (_normalMinX);
        }

        public function get normalMaxX():Number
        {
            return (_normalMaxX);
        }

        public function get normalMinY():Number
        {
            return (_normalMinY);
        }

        public function get normalMaxY():Number
        {
            return (_normalMaxY);
        }

        public function get assetName():String
        {
            return (_assetName);
        }

        public function dispose():void
        {
            _bitmap = null;
        }


    }
}


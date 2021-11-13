package com.sulake.habbo.room.object.visualization.room
{
    import com.sulake.room.object.visualization.IPlaneDrawingData;
    import __AS3__.vec.Vector;
    import flash.geom.Point;

    public class PlaneDrawingData implements IPlaneDrawingData 
    {

        private var _z:Number;
        private var _cornerPoints:Vector.<Point>;
        private var _color:uint;
        private var _maskAssetNames:Array;
        private var _maskAssetLocations:Array;
        private var _maskAssetFlipHs:Array;
        private var _maskAssetFlipVs:Array;
        private var _SafeStr_3446:Boolean = false;
        private var _assetNameColumns:Array = [];

        public function PlaneDrawingData(_arg_1:PlaneDrawingData=null, _arg_2:uint=0, _arg_3:Boolean=false)
        {
            _maskAssetNames = [];
            _maskAssetLocations = [];
            _maskAssetFlipHs = [];
            _maskAssetFlipVs = [];
            if (_arg_1 != null)
            {
                _maskAssetNames = _arg_1._maskAssetNames;
                _maskAssetLocations = _arg_1._maskAssetLocations;
                _maskAssetFlipHs = _arg_1._maskAssetFlipHs;
                _maskAssetFlipVs = _arg_1._maskAssetFlipVs;
            };
            _color = _arg_2;
            _SafeStr_3446 = _arg_3;
        }

        public function addMask(_arg_1:String, _arg_2:Point, _arg_3:Boolean, _arg_4:Boolean):void
        {
            _maskAssetNames.push(_arg_1);
            _maskAssetLocations.push(_arg_2);
            _maskAssetFlipHs.push(_arg_3);
            _maskAssetFlipVs.push(_arg_4);
        }

        public function addAssetColumn(_arg_1:Array):void
        {
            _assetNameColumns.push(_arg_1);
        }

        public function set z(_arg_1:Number):void
        {
            _z = _arg_1;
        }

        public function get z():Number
        {
            return (_z);
        }

        public function set cornerPoints(_arg_1:Vector.<Point>):void
        {
            _cornerPoints = _arg_1;
        }

        public function get cornerPoints():Vector.<Point>
        {
            return (_cornerPoints);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get maskAssetNames():Array
        {
            return (_maskAssetNames);
        }

        public function get maskAssetLocations():Array
        {
            return (_maskAssetLocations);
        }

        public function get maskAssetFlipHs():Array
        {
            return (_maskAssetFlipHs);
        }

        public function get maskAssetFlipVs():Array
        {
            return (_maskAssetFlipVs);
        }

        public function isBottomAligned():Boolean
        {
            return (_SafeStr_3446);
        }

        public function get assetNameColumns():Array
        {
            return (_assetNameColumns);
        }


    }
}


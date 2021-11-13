package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class PlaneMaskBitmap 
    {

        public static const _SafeStr_3425:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _asset:IGraphicAsset = null;
        private var _normalMinX:Number = -1;
        private var _normalMaxX:Number = 1;
        private var _normalMinY:Number = -1;
        private var _normalMaxY:Number = 1;

        public function PlaneMaskBitmap(_arg_1:IGraphicAsset, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1)
        {
            _normalMinX = _arg_2;
            _normalMaxX = _arg_3;
            _normalMinY = _arg_4;
            _normalMaxY = _arg_5;
            _asset = _arg_1;
        }

        public function get asset():IGraphicAsset
        {
            return (_asset);
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

        public function dispose():void
        {
            _asset = null;
        }


    }
}


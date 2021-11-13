package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AnimationItem 
    {

        private var _SafeStr_954:Number = 0;
        private var _SafeStr_955:Number = 0;
        private var _SafeStr_2278:Number = 0;
        private var _SafeStr_2279:Number = 0;
        private var _bitmapData:BitmapData = null;

        public function AnimationItem(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:BitmapData)
        {
            _SafeStr_954 = _arg_1;
            _SafeStr_955 = _arg_2;
            _SafeStr_2278 = _arg_3;
            _SafeStr_2279 = _arg_4;
            if (isNaN(_SafeStr_954))
            {
                _SafeStr_954 = 0;
            };
            if (isNaN(_SafeStr_955))
            {
                _SafeStr_955 = 0;
            };
            if (isNaN(_SafeStr_2278))
            {
                _SafeStr_2278 = 0;
            };
            if (isNaN(_SafeStr_2279))
            {
                _SafeStr_2279 = 0;
            };
            _bitmapData = _arg_5;
        }

        public function get bitmapData():BitmapData
        {
            return (_bitmapData);
        }

        public function dispose():void
        {
            _bitmapData = null;
        }

        public function getPosition(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:int):Point
        {
            var _local_6:Number = _SafeStr_954;
            var _local_7:Number = _SafeStr_955;
            if (_arg_3 > 0)
            {
                _local_6 = (_local_6 + (((_SafeStr_2278 / _arg_3) * _arg_5) / 1000));
            };
            if (_arg_4 > 0)
            {
                _local_7 = (_local_7 + (((_SafeStr_2279 / _arg_4) * _arg_5) / 1000));
            };
            var _local_8:int = ((_local_6 % 1) * _arg_1);
            var _local_9:int = ((_local_7 % 1) * _arg_2);
            return (new Point(_local_8, _local_9));
        }


    }
}


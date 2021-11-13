package com.sulake.core.utils.profiler.tracking
{
    import flash.display.BitmapData;
    import flash.geom.Point;

   public class TrackedBitmapData extends BitmapData
    {

        private static const MAX_PIXELS:int = 0xFFFFFF;
        private static const MAX_WIDTH:int = 8191;
        private static const MAX_HEIGHT:int = 8191;
        private static const MIN_WIDTH:int = 1;
        private static const MIN_HEIGHT:int = 1;
        public static const DEFAULT_SIZE:int = 4095;
        private static const ZERO_POINT:Point = new Point();

        private static var _numInstances:uint = 0;
        private static var _allocatedByteCount:uint = 0;

        private var _SafeStr_863:Object;
        private var _disposed:Boolean = false;

        public function TrackedBitmapData(_arg_1:Object, _arg_2:int, _arg_3:int, _arg_4:Boolean=true, _arg_5:uint=0xFFFFFFFF)
        {
            if ((_arg_2 * _arg_3) > 0xFFFFFF)
            {
                _arg_2 = 4095;
                _arg_3 = 4095;
            }
            else
            {
                if (_arg_2 > 8191)
                {
                    _arg_2 = 8191;
                }
                else
                {
                    if (_arg_2 < 1)
                    {
                        _arg_2 = 1;
                    };
                };
                if (_arg_3 > 8191)
                {
                    _arg_3 = 8191;
                }
                else
                {
                    if (_arg_3 < 1)
                    {
                        _arg_3 = 1;
                    };
                };
            };
            super(_arg_2, _arg_3, _arg_4, _arg_5);
            _numInstances++;
            _allocatedByteCount = (_allocatedByteCount + ((_arg_2 * _arg_3) * 4));
            _SafeStr_863 = _arg_1;
        }

        public static function get numInstances():uint
        {
            return (_numInstances);
        }

        public static function get allocatedByteCount():uint
        {
            return (_allocatedByteCount);
        }


        override public function dispose():void
        {
            if (!_disposed)
            {
                _allocatedByteCount = (_allocatedByteCount - ((width * height) * 4));
                _numInstances--;
                _disposed = true;
                _SafeStr_863 = null;
                super.dispose();
            };
        }

        override public function clone():BitmapData
        {
            if (_disposed)
            {
                return (null);
            };
            var _local_1:TrackedBitmapData = new TrackedBitmapData(_SafeStr_863, width, height, transparent);
            _local_1.copyPixels(this, rect, ZERO_POINT);
            return (_local_1);
        }


    }
}
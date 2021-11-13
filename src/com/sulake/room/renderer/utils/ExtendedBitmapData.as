package com.sulake.room.renderer.utils
{
    import flash.display.BitmapData;
    import flash.geom.Point;

       public class ExtendedBitmapData extends BitmapData
    {

        private static const ZERO_POINT:Point = new Point(0, 0);

        private var _referenceCount:int = 0;
        private var _disposed:Boolean = false;

        public function ExtendedBitmapData(_arg_1:int, _arg_2:int, _arg_3:Boolean=true, _arg_4:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function get referenceCount():int
        {
            return (_referenceCount);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function addReference():void
        {
            _referenceCount++;
        }

        override public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (--_referenceCount <= 0)
            {
                super.dispose();
                _disposed = true;
            };
        }

        override public function clone():BitmapData
        {
            var _local_1:ExtendedBitmapData;
            try
            {
                _local_1 = new ExtendedBitmapData(width, height, true, 0xFFFFFF);
                _local_1.copyPixels(this, rect, ZERO_POINT, null, null, true);
            }
            catch(e:Error)
            {
                _local_1 = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
            };
            return (_local_1);
        }


    }
}

package com.codeazur.as3swf.data
{
    import flash.geom.Rectangle;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.NumberUtils;

    public class SWFRectangle 
    {

        public var xmin:int = 0;
        public var _SafeStr_284:int = 11000;
        public var ymin:int = 0;
        public var _SafeStr_285:int = 8000;
        protected var _rectangle:Rectangle;

        public function SWFRectangle(_arg_1:SWFData=null)
        {
            _rectangle = new Rectangle();
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            _arg_1.resetBitsPending();
            var _local_2:uint = _arg_1.readUB(5);
            xmin = _arg_1.readSB(_local_2);
            _SafeStr_284 = _arg_1.readSB(_local_2);
            ymin = _arg_1.readSB(_local_2);
            _SafeStr_285 = _arg_1.readSB(_local_2);
        }

        public function publish(_arg_1:SWFData):void
        {
            var _local_2:uint = _arg_1.calculateMaxBits(true, [xmin, _SafeStr_284, ymin, _SafeStr_285]);
            _arg_1.resetBitsPending();
            _arg_1.writeUB(5, _local_2);
            _arg_1.writeSB(_local_2, xmin);
            _arg_1.writeSB(_local_2, _SafeStr_284);
            _arg_1.writeSB(_local_2, ymin);
            _arg_1.writeSB(_local_2, _SafeStr_285);
        }

        public function clone():SWFRectangle
        {
            var _local_1:SWFRectangle = new SWFRectangle();
            _local_1.xmin = xmin;
            _local_1._SafeStr_284 = _SafeStr_284;
            _local_1.ymin = ymin;
            _local_1._SafeStr_285 = _SafeStr_285;
            return (_local_1);
        }

        public function get rect():Rectangle
        {
            _rectangle.left = NumberUtils.roundPixels20((xmin / 20));
            _rectangle.right = NumberUtils.roundPixels20((_SafeStr_284 / 20));
            _rectangle.top = NumberUtils.roundPixels20((ymin / 20));
            _rectangle.bottom = NumberUtils.roundPixels20((_SafeStr_285 / 20));
            return (_rectangle);
        }

        public function toString():String
        {
            return (((((((("(" + xmin) + ",") + _SafeStr_284) + ",") + ymin) + ",") + _SafeStr_285) + ")");
        }

        public function toStringSize():String
        {
            return (((("(" + ((_SafeStr_284 / 20) - (xmin / 20))) + ",") + ((_SafeStr_285 / 20) - (ymin / 20))) + ")");
        }


    }
}


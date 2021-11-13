package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import flash.geom.Matrix;
    import flash.geom.Point;

    public class SWFMatrix 
    {

        public var scaleX:Number = 1;
        public var scaleY:Number = 1;
        public var rotateSkew0:Number = 0;
        public var rotateSkew1:Number = 0;
        public var _SafeStr_290:int = 0;
        public var _SafeStr_291:int = 0;
        public var _SafeStr_315:Number;
        public var _SafeStr_316:Number;
        public var rotation:Number;

        public function SWFMatrix(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function get matrix():Matrix
        {
            return (new Matrix(scaleX, rotateSkew0, rotateSkew1, scaleY, _SafeStr_290, _SafeStr_291));
        }

        public function parse(_arg_1:SWFData):void
        {
            var _local_3:uint;
            var _local_2:uint;
            _arg_1.resetBitsPending();
            scaleX = 1;
            scaleY = 1;
            if (_arg_1.readUB(1) == 1)
            {
                _local_3 = _arg_1.readUB(5);
                scaleX = _arg_1.readFB(_local_3);
                scaleY = _arg_1.readFB(_local_3);
            };
            rotateSkew0 = 0;
            rotateSkew1 = 0;
            if (_arg_1.readUB(1) == 1)
            {
                _local_2 = _arg_1.readUB(5);
                rotateSkew0 = _arg_1.readFB(_local_2);
                rotateSkew1 = _arg_1.readFB(_local_2);
            };
            var _local_5:uint = _arg_1.readUB(5);
            _SafeStr_290 = _arg_1.readSB(_local_5);
            _SafeStr_291 = _arg_1.readSB(_local_5);
            var _local_4:Point = matrix.deltaTransformPoint(new Point(0, 1));
            rotation = (((180 / 3.14159265358979) * Math.atan2(_local_4.y, _local_4.x)) - 90);
            if (rotation < 0)
            {
                rotation = (360 + rotation);
            };
            _SafeStr_315 = Math.sqrt(((scaleX * scaleX) + (rotateSkew0 * rotateSkew0)));
            _SafeStr_316 = Math.sqrt(((rotateSkew1 * rotateSkew1) + (scaleY * scaleY)));
        }

        public function clone():SWFMatrix
        {
            var _local_1:SWFMatrix = new SWFMatrix();
            _local_1.scaleX = scaleX;
            _local_1.scaleY = scaleY;
            _local_1.rotateSkew0 = rotateSkew0;
            _local_1.rotateSkew1 = rotateSkew1;
            _local_1._SafeStr_290 = _SafeStr_290;
            _local_1._SafeStr_291 = _SafeStr_291;
            return (_local_1);
        }

        public function isIdentity():Boolean
        {
            return ((((((scaleX == 1) && (scaleY == 1)) && (rotateSkew0 == 0)) && (rotateSkew1 == 0)) && (_SafeStr_290 == 0)) && (_SafeStr_291 == 0));
        }

        public function toString():String
        {
            return (((((((((((("(" + scaleX) + ",") + rotateSkew0) + ",") + rotateSkew1) + ",") + scaleY) + ",") + _SafeStr_290) + ",") + _SafeStr_291) + ")");
        }


    }
}


package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class SWFLineStyle 
    {

        public var width:uint;
        public var color:uint;
        public var _SafeStr_346:uint;
        public var _SafeStr_318:uint = 0;
        public var endCapsStyle:uint = 0;
        public var jointStyle:uint = 0;
        public var hasFillFlag:Boolean = false;
        public var noHScaleFlag:Boolean = false;
        public var noVScaleFlag:Boolean = false;
        public var pixelHintingFlag:Boolean = false;
        public var noClose:Boolean = false;
        public var miterLimitFactor:Number = 3;
        public var fillType:SWFFillStyle;

        public function SWFLineStyle(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _SafeStr_346 = _arg_2;
            width = _arg_1.readUI16();
            color = ((_arg_2 <= 2) ? _arg_1.readRGB() : _arg_1.readRGBA());
        }

        public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _arg_1.writeUI16(width);
            if (_arg_2 <= 2)
            {
                _arg_1.writeRGB(color);
            }
            else
            {
                _arg_1.writeRGBA(color);
            };
        }

        public function clone():SWFLineStyle
        {
            var _local_1:SWFLineStyle = new SWFLineStyle();
            _local_1.width = width;
            _local_1.color = color;
            _local_1._SafeStr_318 = _SafeStr_318;
            _local_1.endCapsStyle = endCapsStyle;
            _local_1.jointStyle = jointStyle;
            _local_1.hasFillFlag = hasFillFlag;
            _local_1.noHScaleFlag = noHScaleFlag;
            _local_1.noVScaleFlag = noVScaleFlag;
            _local_1.pixelHintingFlag = pixelHintingFlag;
            _local_1.noClose = noClose;
            _local_1.miterLimitFactor = miterLimitFactor;
            _local_1.fillType = fillType.clone();
            return (_local_1);
        }

        public function toString():String
        {
            return ((("[SWFLineStyle] Width: " + width) + " Color: ") + ((_SafeStr_346 <= 2) ? ColorUtils.rgbToString(color) : ColorUtils.rgbaToString(color)));
        }


    }
}


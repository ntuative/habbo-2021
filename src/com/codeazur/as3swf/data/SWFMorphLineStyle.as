package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class SWFMorphLineStyle 
    {

        public var startWidth:uint;
        public var endWidth:uint;
        public var startColor:uint;
        public var endColor:uint;
        public var _SafeStr_318:uint = 0;
        public var endCapsStyle:uint = 0;
        public var jointStyle:uint = 0;
        public var hasFillFlag:Boolean = false;
        public var noHScaleFlag:Boolean = false;
        public var noVScaleFlag:Boolean = false;
        public var pixelHintingFlag:Boolean = false;
        public var noClose:Boolean = false;
        public var miterLimitFactor:Number = 3;
        public var fillType:SWFMorphFillStyle;

        public function SWFMorphLineStyle(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            startWidth = _arg_1.readUI16();
            endWidth = _arg_1.readUI16();
            startColor = _arg_1.readRGBA();
            endColor = _arg_1.readRGBA();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _arg_1.writeUI16(startWidth);
            _arg_1.writeUI16(endWidth);
            _arg_1.writeRGBA(startColor);
            _arg_1.writeRGBA(endColor);
        }

        public function getMorphedLineStyle(_arg_1:Number=0):SWFLineStyle
        {
            var _local_2:SWFLineStyle = new SWFLineStyle();
            if (hasFillFlag)
            {
                _local_2.fillType = fillType.getMorphedFillStyle(_arg_1);
            }
            else
            {
                _local_2.color = ColorUtils.interpolate(startColor, endColor, _arg_1);
                _local_2.width = (startWidth + ((endWidth - startWidth) * _arg_1));
            };
            _local_2._SafeStr_318 = _SafeStr_318;
            _local_2.endCapsStyle = endCapsStyle;
            _local_2.jointStyle = jointStyle;
            _local_2.hasFillFlag = hasFillFlag;
            _local_2.noHScaleFlag = noHScaleFlag;
            _local_2.noVScaleFlag = noVScaleFlag;
            _local_2.pixelHintingFlag = pixelHintingFlag;
            _local_2.noClose = noClose;
            _local_2.miterLimitFactor = miterLimitFactor;
            return (_local_2);
        }

        public function toString():String
        {
            return (((((((((("[SWFMorphLineStyle] StartWidth: " + startWidth) + ", ") + "EndWidth: ") + endWidth) + ", ") + "StartColor: ") + ColorUtils.rgbaToString(startColor)) + ", ") + "EndColor: ") + ColorUtils.rgbaToString(endColor));
        }


    }
}


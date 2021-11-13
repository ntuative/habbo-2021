package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_86;
    import com.codeazur.as3swf.data.consts._SafeStr_89;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class SWFMorphLineStyle2 extends SWFMorphLineStyle 
    {

        public function SWFMorphLineStyle2(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            startWidth = _arg_1.readUI16();
            endWidth = _arg_1.readUI16();
            _SafeStr_318 = _arg_1.readUB(2);
            jointStyle = _arg_1.readUB(2);
            hasFillFlag = (_arg_1.readUB(1) == 1);
            noHScaleFlag = (_arg_1.readUB(1) == 1);
            noVScaleFlag = (_arg_1.readUB(1) == 1);
            pixelHintingFlag = (_arg_1.readUB(1) == 1);
            var _local_3:uint = _arg_1.readUB(5);
            noClose = (_arg_1.readUB(1) == 1);
            endCapsStyle = _arg_1.readUB(2);
            if (jointStyle == 2)
            {
                miterLimitFactor = _arg_1.readFIXED8();
            };
            if (hasFillFlag)
            {
                fillType = _arg_1.readMORPHFILLSTYLE(_arg_2);
            }
            else
            {
                startColor = _arg_1.readRGBA();
                endColor = _arg_1.readRGBA();
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _arg_1.writeUI16(startWidth);
            _arg_1.writeUI16(endWidth);
            _arg_1.writeUB(2, _SafeStr_318);
            _arg_1.writeUB(2, jointStyle);
            _arg_1.writeUB(1, ((hasFillFlag) ? 1 : 0));
            _arg_1.writeUB(1, ((noHScaleFlag) ? 1 : 0));
            _arg_1.writeUB(1, ((noVScaleFlag) ? 1 : 0));
            _arg_1.writeUB(1, ((pixelHintingFlag) ? 1 : 0));
            _arg_1.writeUB(5, 0);
            _arg_1.writeUB(1, ((noClose) ? 1 : 0));
            _arg_1.writeUB(2, endCapsStyle);
            if (jointStyle == 2)
            {
                _arg_1.writeFIXED8(miterLimitFactor);
            };
            if (hasFillFlag)
            {
                _arg_1.writeMORPHFILLSTYLE(fillType, _arg_2);
            }
            else
            {
                _arg_1.writeRGBA(startColor);
                _arg_1.writeRGBA(endColor);
            };
        }

        override public function toString():String
        {
            var _local_1:String = ((((((((((((("[SWFMorphLineStyle2] StartWidth: " + startWidth) + ", ") + "EndWidth: ") + endWidth) + ", ") + "StartCaps: ") + _SafeStr_86.toString(_SafeStr_318)) + ", ") + "EndCaps: ") + _SafeStr_86.toString(endCapsStyle)) + ", ") + "Joint: ") + _SafeStr_89.toString(jointStyle));
            if (hasFillFlag)
            {
                _local_1 = (_local_1 + (", Fill: " + fillType.toString()));
            }
            else
            {
                _local_1 = (_local_1 + (", StartColor: " + ColorUtils.rgbaToString(startColor)));
                _local_1 = (_local_1 + (", EndColor: " + ColorUtils.rgbaToString(endColor)));
            };
            return (_local_1);
        }


    }
}


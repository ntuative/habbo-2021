package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class SWFMorphGradientRecord 
    {

        public var _SafeStr_337:uint;
        public var startColor:uint;
        public var endRatio:uint;
        public var endColor:uint;

        public function SWFMorphGradientRecord(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            _SafeStr_337 = _arg_1.readUI8();
            startColor = _arg_1.readRGBA();
            endRatio = _arg_1.readUI8();
            endColor = _arg_1.readRGBA();
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeUI8(_SafeStr_337);
            _arg_1.writeRGBA(startColor);
            _arg_1.writeUI8(endRatio);
            _arg_1.writeRGBA(endColor);
        }

        public function getMorphedGradientRecord(_arg_1:Number=0):SWFGradientRecord
        {
            var _local_2:SWFGradientRecord = new SWFGradientRecord();
            _local_2.color = ColorUtils.interpolate(startColor, endColor, _arg_1);
            _local_2._SafeStr_286 = (_SafeStr_337 + ((endRatio - _SafeStr_337) * _arg_1));
            return (_local_2);
        }

        public function toString():String
        {
            return (((((((("[" + _SafeStr_337) + ",") + ColorUtils.rgbaToString(startColor)) + ",") + endRatio) + ",") + ColorUtils.rgbaToString(endColor)) + "]");
        }


    }
}


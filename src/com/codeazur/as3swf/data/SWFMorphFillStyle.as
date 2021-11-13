package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;
    import com.codeazur.as3swf.utils.MatrixUtils;

    public class SWFMorphFillStyle 
    {

        public var type:uint;
        public var startColor:uint;
        public var endColor:uint;
        public var _SafeStr_352:SWFMatrix;
        public var endGradientMatrix:SWFMatrix;
        public var _SafeStr_312:SWFMorphGradient;
        public var _SafeStr_317:uint;
        public var _SafeStr_353:SWFMatrix;
        public var endBitmapMatrix:SWFMatrix;

        public function SWFMorphFillStyle(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            type = _arg_1.readUI8();
            switch (type)
            {
                case 0:
                    startColor = _arg_1.readRGBA();
                    endColor = _arg_1.readRGBA();
                    return;
                case 16:
                case 18:
                case 19:
                    _SafeStr_352 = _arg_1.readMATRIX();
                    endGradientMatrix = _arg_1.readMATRIX();
                    _SafeStr_312 = ((type == 19) ? _arg_1.readMORPHFOCALGRADIENT(_arg_2) : _arg_1.readMORPHGRADIENT(_arg_2));
                    return;
                case 64:
                case 65:
                case 66:
                case 67:
                    _SafeStr_317 = _arg_1.readUI16();
                    _SafeStr_353 = _arg_1.readMATRIX();
                    endBitmapMatrix = _arg_1.readMATRIX();
                    return;
                default:
                    throw (new Error(("Unknown fill style type: 0x" + type.toString(16))));
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _arg_1.writeUI8(type);
            switch (type)
            {
                case 0:
                    _arg_1.writeRGBA(startColor);
                    _arg_1.writeRGBA(endColor);
                    return;
                case 16:
                case 18:
                case 19:
                    _arg_1.writeMATRIX(_SafeStr_352);
                    _arg_1.writeMATRIX(endGradientMatrix);
                    if (type == 19)
                    {
                        _arg_1.writeMORPHFOCALGRADIENT(SWFMorphFocalGradient(_SafeStr_312), _arg_2);
                    }
                    else
                    {
                        _arg_1.writeMORPHGRADIENT(_SafeStr_312, _arg_2);
                    };
                    return;
                case 64:
                case 65:
                case 66:
                case 67:
                    _arg_1.writeUI16(_SafeStr_317);
                    _arg_1.writeMATRIX(_SafeStr_353);
                    _arg_1.writeMATRIX(endBitmapMatrix);
                    return;
                default:
                    throw (new Error(("Unknown fill style type: 0x" + type.toString(16))));
            };
        }

        public function getMorphedFillStyle(_arg_1:Number=0):SWFFillStyle
        {
            var _local_2:SWFFillStyle = new SWFFillStyle();
            _local_2.type = type;
            switch (type)
            {
                case 0:
                    _local_2.rgb = ColorUtils.interpolate(startColor, endColor, _arg_1);
                    break;
                case 16:
                case 18:
                    _local_2._SafeStr_311 = MatrixUtils.interpolate(_SafeStr_352, endGradientMatrix, _arg_1);
                    _local_2._SafeStr_312 = _SafeStr_312.getMorphedGradient(_arg_1);
                    break;
                case 64:
                case 65:
                case 66:
                case 67:
                    _local_2._SafeStr_317 = _SafeStr_317;
                    _local_2._SafeStr_314 = MatrixUtils.interpolate(_SafeStr_353, endBitmapMatrix, _arg_1);
            };
            return (_local_2);
        }

        public function toString():String
        {
            var _local_1:String = ("[SWFMorphFillStyle] Type: " + type.toString(16));
            switch (type)
            {
                case 0:
                    _local_1 = (_local_1 + (((" (solid), StartColor: " + ColorUtils.rgbaToString(startColor)) + ", EndColor: ") + ColorUtils.rgbaToString(endColor)));
                    break;
                case 16:
                    _local_1 = (_local_1 + (" (linear gradient), Gradient: " + _SafeStr_312));
                    break;
                case 18:
                    _local_1 = (_local_1 + (" (radial gradient), Gradient: " + _SafeStr_312));
                    break;
                case 19:
                    _local_1 = (_local_1 + (" (focal radial gradient), Gradient: " + _SafeStr_312));
                    break;
                case 64:
                    _local_1 = (_local_1 + (" (repeating bitmap), BitmapID: " + _SafeStr_317));
                    break;
                case 65:
                    _local_1 = (_local_1 + (" (clipped bitmap), BitmapID: " + _SafeStr_317));
                    break;
                case 66:
                    _local_1 = (_local_1 + (" (non-smoothed repeating bitmap), BitmapID: " + _SafeStr_317));
                    break;
                case 67:
                    _local_1 = (_local_1 + (" (non-smoothed clipped bitmap), BitmapID: " + _SafeStr_317));
            };
            return (_local_1);
        }


    }
}


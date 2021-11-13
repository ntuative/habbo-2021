package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class SWFFillStyle 
    {

        public var type:uint;
        public var rgb:uint;
        public var _SafeStr_312:SWFGradient;
        public var _SafeStr_311:SWFMatrix;
        public var _SafeStr_317:uint;
        public var _SafeStr_314:SWFMatrix;
        protected var _SafeStr_346:uint;

        public function SWFFillStyle(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _SafeStr_346 = _arg_2;
            type = _arg_1.readUI8();
            switch (type)
            {
                case 0:
                    rgb = ((_arg_2 <= 2) ? _arg_1.readRGB() : _arg_1.readRGBA());
                    return;
                case 16:
                case 18:
                case 19:
                    _SafeStr_311 = _arg_1.readMATRIX();
                    _SafeStr_312 = ((type == 19) ? _arg_1.readFOCALGRADIENT(_arg_2) : _arg_1.readGRADIENT(_arg_2));
                    return;
                case 64:
                case 65:
                case 66:
                case 67:
                    _SafeStr_317 = _arg_1.readUI16();
                    _SafeStr_314 = _arg_1.readMATRIX();
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
                    if (_arg_2 <= 2)
                    {
                        _arg_1.writeRGB(rgb);
                    }
                    else
                    {
                        _arg_1.writeRGBA(rgb);
                    };
                    return;
                case 16:
                case 18:
                    _arg_1.writeMATRIX(_SafeStr_311);
                    _arg_1.writeGRADIENT(_SafeStr_312, _arg_2);
                    return;
                case 19:
                    _arg_1.writeMATRIX(_SafeStr_311);
                    _arg_1.writeFOCALGRADIENT(SWFFocalGradient(_SafeStr_312), _arg_2);
                    return;
                case 64:
                case 65:
                case 66:
                case 67:
                    _arg_1.writeUI16(_SafeStr_317);
                    _arg_1.writeMATRIX(_SafeStr_314);
                    return;
                default:
                    throw (new Error(("Unknown fill style type: 0x" + type.toString(16))));
            };
        }

        public function clone():SWFFillStyle
        {
            var _local_1:SWFFillStyle = new SWFFillStyle();
            _local_1.type = type;
            _local_1.rgb = rgb;
            _local_1._SafeStr_312 = _SafeStr_312.clone();
            _local_1._SafeStr_311 = _SafeStr_311.clone();
            _local_1._SafeStr_317 = _SafeStr_317;
            _local_1._SafeStr_314 = _SafeStr_314.clone();
            return (_local_1);
        }

        public function toString():String
        {
            var _local_1:String = ("[SWFFillStyle] Type: " + StringUtils.printf("%02x", type));
            switch (type)
            {
                case 0:
                    _local_1 = (_local_1 + (" (solid), Color: " + ((_SafeStr_346 <= 2) ? ColorUtils.rgbToString(rgb) : ColorUtils.rgbaToString(rgb))));
                    break;
                case 16:
                    _local_1 = (_local_1 + (((" (linear gradient), Gradient: " + _SafeStr_312) + ", Matrix: ") + _SafeStr_311));
                    break;
                case 18:
                    _local_1 = (_local_1 + (((" (radial gradient), Gradient: " + _SafeStr_312) + ", Matrix: ") + _SafeStr_311));
                    break;
                case 19:
                    _local_1 = (_local_1 + (((((" (focal radial gradient), Gradient: " + _SafeStr_312) + ", Matrix: ") + _SafeStr_311) + ", FocalPoint: ") + _SafeStr_312.focalPoint));
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


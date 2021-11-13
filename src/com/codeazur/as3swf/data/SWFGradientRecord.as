package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class SWFGradientRecord 
    {

        public var _SafeStr_286:uint;
        public var color:uint;
        protected var _SafeStr_346:uint;

        public function SWFGradientRecord(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            _SafeStr_346 = _arg_2;
            _SafeStr_286 = _arg_1.readUI8();
            color = ((_arg_2 <= 2) ? _arg_1.readRGB() : _arg_1.readRGBA());
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeUI8(_SafeStr_286);
            if (_arg_2 <= 2)
            {
                _arg_1.writeRGB(color);
            }
            else
            {
                _arg_1.writeRGBA(color);
            };
        }

        public function clone():SWFGradientRecord
        {
            var _local_1:SWFGradientRecord = new SWFGradientRecord();
            _local_1._SafeStr_286 = _SafeStr_286;
            _local_1.color = color;
            return (_local_1);
        }

        public function toString():String
        {
            return (((("[" + _SafeStr_286) + ",") + ((_SafeStr_346 <= 2) ? ColorUtils.rgbToString(color) : ColorUtils.rgbaToString(color))) + "]");
        }


    }
}


package com.codeazur.as3swf.data.filters
{
    import __AS3__.vec.Vector;
    import flash.filters.ConvolutionFilter;
    import com.codeazur.as3swf.utils.ColorUtils;
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class FilterConvolution extends Filter implements IFilter 
    {

        public var _SafeStr_400:uint;
        public var _SafeStr_401:uint;
        public var _SafeStr_402:Number;
        public var _SafeStr_403:Number;
        public var defaultColor:uint;
        public var clamp:Boolean;
        public var preserveAlpha:Boolean;
        protected var _SafeStr_700:Vector.<Number>;

        public function FilterConvolution(_arg_1:uint)
        {
            super(_arg_1);
            _SafeStr_700 = new Vector.<Number>();
        }

        public function get matrix():Vector.<Number>
        {
            return (_SafeStr_700);
        }

        override public function get filter():BitmapFilter
        {
            var _local_1:int;
            var _local_2:Array = [];
            _local_1 = 0;
            while (_local_1 < _SafeStr_700.length)
            {
                _local_2.push(_SafeStr_700[_local_1]);
                _local_1++;
            };
            return (new ConvolutionFilter(_SafeStr_400, _SafeStr_401, _local_2, _SafeStr_402, _SafeStr_403, preserveAlpha, clamp, ColorUtils.rgb(defaultColor), ColorUtils.alpha(defaultColor)));
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_4:uint;
            _SafeStr_400 = _arg_1.readUI8();
            _SafeStr_401 = _arg_1.readUI8();
            _SafeStr_402 = _arg_1.readFLOAT();
            _SafeStr_403 = _arg_1.readFLOAT();
            var _local_2:uint = (_SafeStr_400 * _SafeStr_401);
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                matrix.push(_arg_1.readFLOAT());
                _local_4++;
            };
            defaultColor = _arg_1.readRGBA();
            var _local_3:uint = _arg_1.readUI8();
            clamp = (!((_local_3 & 0x02) == 0));
            preserveAlpha = (!((_local_3 & 0x01) == 0));
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_4:uint;
            _arg_1.writeUI8(_SafeStr_400);
            _arg_1.writeUI8(_SafeStr_401);
            _arg_1.writeFLOAT(_SafeStr_402);
            _arg_1.writeFLOAT(_SafeStr_403);
            var _local_2:uint = (_SafeStr_400 * _SafeStr_401);
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _arg_1.writeFLOAT(matrix[_local_4]);
                _local_4++;
            };
            _arg_1.writeRGBA(defaultColor);
            var _local_3:uint;
            if (clamp)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (preserveAlpha)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _arg_1.writeUI8(_local_3);
        }

        override public function clone():IFilter
        {
            var _local_3:uint;
            var _local_1:FilterConvolution = new FilterConvolution(id);
            _local_1._SafeStr_400 = _SafeStr_400;
            _local_1._SafeStr_401 = _SafeStr_401;
            _local_1._SafeStr_402 = _SafeStr_402;
            _local_1._SafeStr_403 = _SafeStr_403;
            var _local_2:uint = (_SafeStr_400 * _SafeStr_401);
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_1.matrix.push(matrix[_local_3]);
                _local_3++;
            };
            _local_1.defaultColor = defaultColor;
            _local_1.clamp = clamp;
            _local_1.preserveAlpha = preserveAlpha;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_5:uint;
            var _local_4:uint;
            var _local_2:String = ((((((("[ConvolutionFilter] DefaultColor: " + ColorUtils.rgbToString(defaultColor)) + ", ") + "Divisor: ") + _SafeStr_402) + ", ") + "Bias: ") + _SafeStr_403);
            var _local_3:Array = [];
            if (clamp)
            {
                _local_3.push("Clamp");
            };
            if (preserveAlpha)
            {
                _local_3.push("PreserveAlpha");
            };
            if (_local_3.length > 0)
            {
                _local_2 = (_local_2 + (", Flags: " + _local_3.join(", ")));
            };
            if (matrix.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Matrix:"));
                _local_5 = 0;
                while (_local_5 < _SafeStr_401)
                {
                    _local_2 = (_local_2 + (((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_5) + "]"));
                    _local_4 = 0;
                    while (_local_4 < _SafeStr_400)
                    {
                        _local_2 = (_local_2 + (((_local_4 > 0) ? ", " : " ") + matrix[((_SafeStr_400 * _local_5) + _local_4)]));
                        _local_4++;
                    };
                    _local_5++;
                };
            };
            return (_local_2);
        }


    }
}


package com.codeazur.as3swf.data.filters
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.utils.ColorUtils;
    import flash.filters.GradientGlowFilter;
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class FilterGradientGlow extends Filter implements IFilter 
    {

        public var numColors:uint;
        public var blurX:Number;
        public var blurY:Number;
        public var angle:Number;
        public var distance:Number;
        public var strength:Number;
        public var innerShadow:Boolean;
        public var knockout:Boolean;
        public var compositeSource:Boolean;
        public var onTop:Boolean;
        public var _SafeStr_397:uint;
        protected var _gradientColors:Vector.<uint>;
        protected var _gradientRatios:Vector.<uint>;

        public function FilterGradientGlow(_arg_1:uint)
        {
            super(_arg_1);
            _gradientColors = new Vector.<uint>();
            _gradientRatios = new Vector.<uint>();
        }

        public function get gradientColors():Vector.<uint>
        {
            return (_gradientColors);
        }

        public function get gradientRatios():Vector.<uint>
        {
            return (_gradientRatios);
        }

        override public function get filter():BitmapFilter
        {
            var _local_4:int;
            var _local_5:String;
            var _local_1:Array = [];
            var _local_2:Array = [];
            var _local_3:Array = [];
            _local_4 = 0;
            while (_local_4 < numColors)
            {
                _local_1.push(ColorUtils.rgb(gradientColors[_local_4]));
                _local_2.push(ColorUtils.alpha(gradientColors[_local_4]));
                _local_3.push(gradientRatios[_local_4]);
                _local_4++;
            };
            if (onTop)
            {
                _local_5 = "full";
            }
            else
            {
                _local_5 = ((innerShadow) ? "inner" : "outer");
            };
            return (new GradientGlowFilter(distance, ((angle * 180) / 3.14159265358979), _local_1, _local_2, _local_3, blurX, blurY, strength, _SafeStr_397, _local_5, knockout));
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_3:uint;
            numColors = _arg_1.readUI8();
            _local_3 = 0;
            while (_local_3 < numColors)
            {
                _gradientColors.push(_arg_1.readRGBA());
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < numColors)
            {
                _gradientRatios.push(_arg_1.readUI8());
                _local_3++;
            };
            blurX = _arg_1.readFIXED();
            blurY = _arg_1.readFIXED();
            angle = _arg_1.readFIXED();
            distance = _arg_1.readFIXED();
            strength = _arg_1.readFIXED8();
            var _local_2:uint = _arg_1.readUI8();
            innerShadow = (!((_local_2 & 0x80) == 0));
            knockout = (!((_local_2 & 0x40) == 0));
            compositeSource = (!((_local_2 & 0x20) == 0));
            onTop = (!((_local_2 & 0x10) == 0));
            _SafeStr_397 = (_local_2 & 0x0F);
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_3:uint;
            _arg_1.writeUI8(numColors);
            _local_3 = 0;
            while (_local_3 < numColors)
            {
                _arg_1.writeRGBA(gradientColors[_local_3]);
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < numColors)
            {
                _arg_1.writeUI8(gradientRatios[_local_3]);
                _local_3++;
            };
            _arg_1.writeFIXED(blurX);
            _arg_1.writeFIXED(blurY);
            _arg_1.writeFIXED(angle);
            _arg_1.writeFIXED(distance);
            _arg_1.writeFIXED8(strength);
            var _local_2:uint = (_SafeStr_397 & 0x0F);
            if (innerShadow)
            {
                _local_2 = (_local_2 | 0x80);
            };
            if (knockout)
            {
                _local_2 = (_local_2 | 0x40);
            };
            if (compositeSource)
            {
                _local_2 = (_local_2 | 0x20);
            };
            if (onTop)
            {
                _local_2 = (_local_2 | 0x10);
            };
            _arg_1.writeUI8(_local_2);
        }

        override public function clone():IFilter
        {
            var _local_2:uint;
            var _local_1:FilterGradientGlow = new FilterGradientGlow(id);
            _local_1.numColors = numColors;
            _local_2 = 0;
            while (_local_2 < numColors)
            {
                _local_1.gradientColors.push(gradientColors[_local_2]);
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < numColors)
            {
                _local_1.gradientRatios.push(gradientRatios[_local_2]);
                _local_2++;
            };
            _local_1.blurX = blurX;
            _local_1.blurY = blurY;
            _local_1.angle = angle;
            _local_1.distance = distance;
            _local_1.strength = strength;
            _local_1._SafeStr_397 = _SafeStr_397;
            _local_1.innerShadow = innerShadow;
            _local_1.knockout = knockout;
            _local_1.compositeSource = compositeSource;
            _local_1.onTop = onTop;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_2:String = ((((((((((((((((((("[" + filterName) + "] ") + "BlurX: ") + blurX) + ", ") + "BlurY: ") + blurY) + ", ") + "Angle: ") + angle) + ", ") + "Distance: ") + distance) + ", ") + "Strength: ") + strength) + ", ") + "Passes: ") + _SafeStr_397);
            var _local_3:Array = [];
            if (innerShadow)
            {
                _local_3.push("InnerShadow");
            };
            if (knockout)
            {
                _local_3.push("Knockout");
            };
            if (compositeSource)
            {
                _local_3.push("CompositeSource");
            };
            if (onTop)
            {
                _local_3.push("OnTop");
            };
            if (_local_3.length > 0)
            {
                _local_2 = (_local_2 + (", Flags: " + _local_3.join(", ")));
            };
            if (gradientColors.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "GradientColors:"));
                _local_4 = 0;
                while (_local_4 < gradientColors.length)
                {
                    _local_2 = (_local_2 + (((_local_4 > 0) ? ", " : " ") + ColorUtils.rgbToString(gradientColors[_local_4])));
                    _local_4++;
                };
            };
            if (gradientRatios.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "GradientRatios:"));
                _local_4 = 0;
                while (_local_4 < gradientRatios.length)
                {
                    _local_2 = (_local_2 + (((_local_4 > 0) ? ", " : " ") + gradientRatios[_local_4]));
                    _local_4++;
                };
            };
            return (_local_2);
        }

        protected function get filterName():String
        {
            return ("GradientGlowFilter");
        }


    }
}


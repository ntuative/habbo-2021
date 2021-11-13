package com.codeazur.as3swf.data.filters
{
    import flash.filters.GlowFilter;
    import com.codeazur.as3swf.utils.ColorUtils;
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;

    public class FilterGlow extends Filter implements IFilter 
    {

        public var glowColor:uint;
        public var blurX:Number;
        public var blurY:Number;
        public var strength:Number;
        public var innerGlow:Boolean;
        public var knockout:Boolean;
        public var compositeSource:Boolean;
        public var _SafeStr_397:uint;

        public function FilterGlow(_arg_1:uint)
        {
            super(_arg_1);
        }

        override public function get filter():BitmapFilter
        {
            return (new GlowFilter(ColorUtils.rgb(glowColor), ColorUtils.alpha(glowColor), blurX, blurY, strength, _SafeStr_397, innerGlow, knockout));
        }

        override public function parse(_arg_1:SWFData):void
        {
            glowColor = _arg_1.readRGBA();
            blurX = _arg_1.readFIXED();
            blurY = _arg_1.readFIXED();
            strength = _arg_1.readFIXED8();
            var _local_2:uint = _arg_1.readUI8();
            innerGlow = (!((_local_2 & 0x80) == 0));
            knockout = (!((_local_2 & 0x40) == 0));
            compositeSource = (!((_local_2 & 0x20) == 0));
            _SafeStr_397 = (_local_2 & 0x1F);
        }

        override public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeRGBA(glowColor);
            _arg_1.writeFIXED(blurX);
            _arg_1.writeFIXED(blurY);
            _arg_1.writeFIXED8(strength);
            var _local_2:uint = (_SafeStr_397 & 0x1F);
            if (innerGlow)
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
            _arg_1.writeUI8(_local_2);
        }

        override public function clone():IFilter
        {
            var _local_1:FilterGlow = new FilterGlow(id);
            _local_1.glowColor = glowColor;
            _local_1.blurX = blurX;
            _local_1.blurY = blurY;
            _local_1.strength = strength;
            _local_1._SafeStr_397 = _SafeStr_397;
            _local_1.innerGlow = innerGlow;
            _local_1.knockout = knockout;
            _local_1.compositeSource = compositeSource;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((((((((((((("[GlowFilter] GlowColor: " + ColorUtils.rgbToString(glowColor)) + ", ") + "BlurX: ") + blurX) + ", ") + "BlurY: ") + blurY) + ", ") + "Strength: ") + strength) + ", ") + "Passes: ") + _SafeStr_397);
            var _local_3:Array = [];
            if (innerGlow)
            {
                _local_3.push("InnerGlow");
            };
            if (knockout)
            {
                _local_3.push("Knockout");
            };
            if (compositeSource)
            {
                _local_3.push("CompositeSource");
            };
            if (_local_3.length > 0)
            {
                _local_2 = (_local_2 + (", Flags: " + _local_3.join(", ")));
            };
            return (_local_2);
        }


    }
}


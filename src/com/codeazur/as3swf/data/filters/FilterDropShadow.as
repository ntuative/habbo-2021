package com.codeazur.as3swf.data.filters
{
    import flash.filters.DropShadowFilter;
    import com.codeazur.as3swf.utils.ColorUtils;
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;

    public class FilterDropShadow extends Filter implements IFilter 
    {

        public var dropShadowColor:uint;
        public var blurX:Number;
        public var blurY:Number;
        public var angle:Number;
        public var distance:Number;
        public var strength:Number;
        public var innerShadow:Boolean;
        public var knockout:Boolean;
        public var compositeSource:Boolean;
        public var _SafeStr_397:uint;

        public function FilterDropShadow(_arg_1:uint)
        {
            super(_arg_1);
        }

        override public function get filter():BitmapFilter
        {
            return (new DropShadowFilter(distance, ((angle * 180) / 3.14159265358979), ColorUtils.rgb(dropShadowColor), ColorUtils.alpha(dropShadowColor), blurX, blurY, strength, _SafeStr_397, innerShadow, knockout));
        }

        override public function parse(_arg_1:SWFData):void
        {
            dropShadowColor = _arg_1.readRGBA();
            blurX = _arg_1.readFIXED();
            blurY = _arg_1.readFIXED();
            angle = _arg_1.readFIXED();
            distance = _arg_1.readFIXED();
            strength = _arg_1.readFIXED8();
            var _local_2:uint = _arg_1.readUI8();
            innerShadow = (!((_local_2 & 0x80) == 0));
            knockout = (!((_local_2 & 0x40) == 0));
            compositeSource = (!((_local_2 & 0x20) == 0));
            _SafeStr_397 = (_local_2 & 0x1F);
        }

        override public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeRGBA(dropShadowColor);
            _arg_1.writeFIXED(blurX);
            _arg_1.writeFIXED(blurY);
            _arg_1.writeFIXED(angle);
            _arg_1.writeFIXED(distance);
            _arg_1.writeFIXED8(strength);
            var _local_2:uint = (_SafeStr_397 & 0x1F);
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
            _arg_1.writeUI8(_local_2);
        }

        override public function clone():IFilter
        {
            var _local_1:FilterDropShadow = new FilterDropShadow(id);
            _local_1.dropShadowColor = dropShadowColor;
            _local_1.blurX = blurX;
            _local_1.blurY = blurY;
            _local_1.angle = angle;
            _local_1.distance = distance;
            _local_1.strength = strength;
            _local_1._SafeStr_397 = _SafeStr_397;
            _local_1.innerShadow = innerShadow;
            _local_1.knockout = knockout;
            _local_1.compositeSource = compositeSource;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((((((((((((((((((("[DropShadowFilter] DropShadowColor: " + ColorUtils.rgbToString(dropShadowColor)) + ", ") + "BlurX: ") + blurX) + ", ") + "BlurY: ") + blurY) + ", ") + "Angle: ") + angle) + ", ") + "Distance: ") + distance) + ", ") + "Strength: ") + strength) + ", ") + "Passes: ") + _SafeStr_397);
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
            if (_local_3.length > 0)
            {
                _local_2 = (_local_2 + (", Flags: " + _local_3.join(", ")));
            };
            return (_local_2);
        }


    }
}


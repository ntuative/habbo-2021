package com.codeazur.as3swf.data.filters
{
    import com.codeazur.as3swf.utils.ColorUtils;
    import flash.filters.GradientBevelFilter;
    import flash.filters.BitmapFilter;

    public class FilterGradientBevel extends FilterGradientGlow implements IFilter 
    {

        public function FilterGradientBevel(_arg_1:uint)
        {
            super(_arg_1);
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
            return (new GradientBevelFilter(distance, angle, _local_1, _local_2, _local_3, blurX, blurY, strength, _SafeStr_397, _local_5, knockout));
        }

        override public function clone():IFilter
        {
            var _local_2:uint;
            var _local_1:FilterGradientBevel = new FilterGradientBevel(id);
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

        override protected function get filterName():String
        {
            return ("GradientBevelFilter");
        }


    }
}


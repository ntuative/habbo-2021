package com.codeazur.as3swf.factories
{
    import com.codeazur.as3swf.data.filters.FilterDropShadow;
    import com.codeazur.as3swf.data.filters.FilterBlur;
    import com.codeazur.as3swf.data.filters.FilterGlow;
    import com.codeazur.as3swf.data.filters.FilterBevel;
    import com.codeazur.as3swf.data.filters.FilterGradientGlow;
    import com.codeazur.as3swf.data.filters.FilterConvolution;
    import com.codeazur.as3swf.data.filters.FilterColorMatrix;
    import com.codeazur.as3swf.data.filters.FilterGradientBevel;
    import com.codeazur.as3swf.data.filters.IFilter;

    public class _SafeStr_83 
    {


        public static function create(_arg_1:uint):IFilter
        {
            switch (_arg_1)
            {
                case 0:
                    return (new FilterDropShadow(_arg_1));
                case 1:
                    return (new FilterBlur(_arg_1));
                case 2:
                    return (new FilterGlow(_arg_1));
                case 3:
                    return (new FilterBevel(_arg_1));
                case 4:
                    return (new FilterGradientGlow(_arg_1));
                case 5:
                    return (new FilterConvolution(_arg_1));
                case 6:
                    return (new FilterColorMatrix(_arg_1));
                case 7:
                    return (new FilterGradientBevel(_arg_1));
                default:
                    throw (new Error(("Unknown filter ID: " + _arg_1)));
            };
        }


    }
}

